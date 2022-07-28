package main

import "github.com/gorilla/websocket"

type Message struct {
	Id       string `json:"id"`
	Body     string `json:"body"`
	Sender   string `json:"sender"`
	SenderID string `json:"senderid"`
}

type Client struct {
	ID   string
	Conn *websocket.Conn
	Pool *Pool
}

type Pool struct {
	Register   chan *Client
	Unregister chan *Client
	Clients    map[*Client]bool
	Broadcast  chan Message
}
