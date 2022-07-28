package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

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
		return nil, err
	}
	return conn, nil
}

func serveComplexWS(w http.ResponseWriter, r *http.Request) {
	conn, err := Upgrade(w, r)
	if err != nil {
		fmt.Fprintf(w, "%+V\n", err)
	}

	swsKey := r.Header.Get("Sec-Websocket-Key")

	client := &Client{
		ID:           swsKey,
		Conn:         conn,
		Message:      make(chan Message),
		RegistClient: make(chan Message),
		CloseConn:    make(chan string),
	}

	go client.StartWrite()
	newMessage := Message{Id: uuid.New().String(), Body: "Connection succed", Sender: "", SenderID: client.ID}
	client.RegistClient <- newMessage

	client.StartRead()

}

func (client *Client) StartWrite() {
	defer client.Conn.Close()

	for {
		select {
		case message := <-client.RegistClient:
			err := client.Conn.WriteJSON(message)
			if err != nil {
				fmt.Printf("Error with WriteJSON RegistClient %v", err)
				return
			}

		case message := <-client.Message:
			err := client.Conn.WriteJSON(message)
			if err != nil {
				fmt.Printf("Error with write new message: %v", err)
				return
			}
		case closeMessage := <-client.CloseConn:
			fmt.Printf("Cloused ClientID: %v\n", closeMessage)
		}
	}
}

func (client *Client) StartRead() {
	defer func() {
		clientID := client.ID
		client.CloseConn <- clientID
		client.Conn.Close()
	}()
	for {
		_, p, err := client.Conn.ReadMessage()
		if err != nil {
			log.Println(err)
			return
		}

		var newMessage Message
		unErr := json.Unmarshal(p, &newMessage)
		if unErr != nil {
			fmt.Printf("Unmarshal error: %v", unErr)
		}
		message := Message{Id: uuid.New().String(), Body: newMessage.Body, Sender: newMessage.Sender, SenderID: client.ID}
		client.Message <- message

	}
}
