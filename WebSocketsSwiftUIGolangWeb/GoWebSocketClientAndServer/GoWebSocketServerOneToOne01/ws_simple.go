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

func serverSimpleWS(w http.ResponseWriter, r *http.Request) {
	conn, err := Upgrade(w, r)
	if err != nil {
		fmt.Fprintf(w, "%+V\n", err)
	}
	swsKey := r.Header.Get("Sec-Websocket-Key")

	defer conn.Close()

	simpleClient := &ClientS{
		ID:   swsKey,
		Conn: conn,
	}
	fmt.Printf("Client is Conected. Connection ID: %v", swsKey)

	StartSimpleClient(simpleClient)
}

func StartSimpleClient(client *ClientS) {
	for {
		_, p, err := client.Conn.ReadMessage()
		if err != nil {
			log.Printf("Error Read Message %v\n", err)
			return
		}

		var newMessage Message
		unErr := json.Unmarshal(p, &newMessage)

		if unErr != nil {
			fmt.Printf("Unmarshal Error: %v", unErr)
		}
		message := Message{Id: uuid.New().String(), Body: newMessage.Body, Sender: newMessage.Sender, SenderID: client.ID}

		writeErr := client.Conn.WriteJSON(message)
		if writeErr != nil {
			fmt.Printf("Error with WriteJSON %v", writeErr)
			return
		}
	}
}
