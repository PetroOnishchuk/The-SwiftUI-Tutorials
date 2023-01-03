package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/google/uuid"
	"github.com/gorilla/websocket"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func Upgrade(w http.ResponseWriter, r *http.Request) (*websocket.Conn, error) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Printf("Error with Conn: %v", err)
		return nil, err
	}
	return conn, nil
}

func NewPool() *Pool {
	newPool := &Pool{
		Register:   make(chan *Client),
		Unregister: make(chan *Client),
		Clients:    make(map[*Client]bool),
		Broadcast:  make(chan Message),
	}
	return newPool
}

func (pool *Pool) StartWrite() {
	for {
		select {
		case client := <-pool.Register:
			pool.Clients[client] = true
			log.Printf("Size of Connection Pool: %v", len(pool.Clients))
			newClientID := client.ID
			for client, _ := range pool.Clients {
				newMessage := Message{Id: uuid.New().String(), Body: "Joined a New User", Sender: "", SenderID: newClientID}
				wrErr := client.Conn.WriteJSON(newMessage)
				if wrErr != nil {
					log.Printf("Error with WriteJSON Message from SenderID: %v", newClientID)
					return
				}
			}
			break
		case client := <-pool.Unregister:
			delete(pool.Clients, client)
			log.Printf("USER Disconect ID: %v\n", client.ID)
			fmt.Printf("Size of Connection Pool: %v\n", len(pool.Clients))
			delID := client.ID
			for client, _ := range pool.Clients {
				messageForSend := Message{Id: uuid.New().String(), Body: "User Disconect", Sender: "", SenderID: delID}
				wrErr := client.Conn.WriteJSON(messageForSend)
				if wrErr != nil {
					log.Printf("Error with WriteJSON Unregistr with SenderID :%v\n", delID)
					return
				}
			}
		case message := <-pool.Broadcast:
			log.Printf("Sending message to all clients in Pool\n")
			for client := range pool.Clients {
				time.Sleep(1 * time.Second)

				wrErr := client.Conn.WriteJSON(message)
				if wrErr != nil {
					fmt.Printf("Error with write message %v\n", wrErr)
					return
				}
			}
		}
	}
}

func (client *Client) StartRead() {
	defer func() {
		client.Pool.Unregister <- client
		client.Conn.Close()
	}()
	for {
		_, p, err := client.Conn.ReadMessage()
		if err != nil {
			log.Printf("ReadMessage Error: %v\n", err)
			return
		}
		var inputMessage Message
		unErr := json.Unmarshal(p, &inputMessage)
		if unErr != nil {
			log.Printf("Unmarshal Error: %v\n", unErr)

		}
		newMessage := Message{Id: uuid.New().String(), Body: inputMessage.Body, Sender: inputMessage.Sender, SenderID: client.ID}
		client.Pool.Broadcast <- newMessage
	}
}

func performWS(pool *Pool, writer http.ResponseWriter, request *http.Request) {
	conn, err := Upgrade(writer, request)
	if err != nil {
		fmt.Fprintf(writer, "%+v\n", err)
	}

	for name, val := range request.Header {
		fmt.Printf("Header: %v Value: %v"+"\n", name, val)
	}
	swsKey := request.Header.Get("Sec-Websocket-Key")

	client := &Client{
		ID:   swsKey,
		Conn: conn,
		Pool: pool,
	}
	pool.Register <- client

	client.StartRead()
}

func setupWSApp() {
	pool := NewPool()
	go pool.StartWrite()

	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		performWS(pool, writer, request)
	})
}
