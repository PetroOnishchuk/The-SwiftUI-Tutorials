package main

import "github.com/gorilla/websocket"

type Message struct {
	Id       string `json:"id"`
	Body     string `json:"body"`
	Sender   string `json:"sender"`
	SenderID string `json:"senderid"`
}

type Client struct {
	Message   chan Message
	Conn      *websocket.Conn
	CloseConn chan bool
}
