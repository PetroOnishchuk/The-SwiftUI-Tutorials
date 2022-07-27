package main

import "github.com/gorilla/websocket"

type Message struct {
	Id       string `json:"id"`
	Body     string `json:"body"`
	Sender   string `json:"sender"`
	SenderID string `json:"senderid"`
}

type ClientS struct {
	ID   string
	Conn *websocket.Conn
}

type Client struct {
	ID           string
	Conn         *websocket.Conn
	Message      chan Message
	RegistClient chan Message
	CloseConn    chan string
}
