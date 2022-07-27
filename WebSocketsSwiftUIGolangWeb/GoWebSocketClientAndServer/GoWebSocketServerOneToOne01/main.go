package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Printf("Hello, WebSocket Server!\n")

	http.HandleFunc("/", serverSimpleWS)

	serverErr := http.ListenAndServe(":5000", nil)

	if serverErr != nil {
		fmt.Printf("SERVER ERROR: %v", serverErr.Error())
	}
}
