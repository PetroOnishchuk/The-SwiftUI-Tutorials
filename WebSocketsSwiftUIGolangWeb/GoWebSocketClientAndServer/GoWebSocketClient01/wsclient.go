package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"os/signal"
	"strconv"

	"github.com/gorilla/websocket"
)

func startWebSocketClient() {
	allMessages := []Message{}

	interrupt := make(chan os.Signal)

	signal.Notify(interrupt, os.Interrupt)

	wsURL := "ws://localhost:5000"
	conn, _, err := websocket.DefaultDialer.Dial(wsURL, nil)
	if err != nil {
		log.Fatal("Error connection to WebSocket Server:\n", err)
	}

	client := &Client{
		Message:   make(chan Message),
		Conn:      conn,
		CloseConn: make(chan bool),
	}

	defer client.Conn.Close()

	go func() {
		defer func() {
			client.CloseConn <- true
		}()

		for {
			defer func() {
				client.CloseConn <- true
			}()
			_, message, err := client.Conn.ReadMessage()
			if err != nil {
				fmt.Printf("Read Message Error: %v\n,", err)
				return
			}
			var newMessage Message

			unErr := json.Unmarshal(message, &newMessage)

			if unErr != nil {
				fmt.Printf("Unmarshal Error: %v\n", unErr)
			}
			fmt.Printf("Receive Message: %v\n", newMessage)
			client.Message <- newMessage
		}
	}()
	for {
		select {
		case newMessage := <-client.Message:
			allMessages = append(allMessages, newMessage)

			allMessagesLen := len(allMessages)
			fmt.Printf("Count of AllMessages: %v\n", allMessagesLen)

			if allMessagesLen%3 == 0 {
				forSendM := Message{Id: "", Body: strconv.Itoa(allMessagesLen) + "%3 = 0", Sender: "Go-Client", SenderID: ""}
				err := client.Conn.WriteJSON(forSendM)
				if err != nil {
					fmt.Printf("WriteJson Error: %v", err)
					return
				}
			}
		case isClose := <-client.CloseConn:
			if isClose {
				client.Conn.Close()
				return
			}
		case <-interrupt:
			log.Printf("interrupt")
			err := client.Conn.WriteMessage(websocket.CloseMessage, websocket.FormatCloseMessage((websocket.CloseNormalClosure), ""))
			if err != nil {
				log.Printf("Write Message Error: %v\n", err)
				return
			}
			select {
			case <-client.CloseConn:
			}

		}
	}
}
