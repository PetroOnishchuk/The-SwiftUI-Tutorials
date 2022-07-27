package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Printf("Hello, WebSocket Server!\n")
	// Simple WS Server
	//http.HandleFunc("/", serverSimpleWS)

	// Complex WS Server
	http.HandleFunc("/", serveComplexWS)

	serverErr := http.ListenAndServe(":5000", nil)

	if serverErr != nil {
		fmt.Printf("SERVER ERROR: %v", serverErr.Error())
	}
}
