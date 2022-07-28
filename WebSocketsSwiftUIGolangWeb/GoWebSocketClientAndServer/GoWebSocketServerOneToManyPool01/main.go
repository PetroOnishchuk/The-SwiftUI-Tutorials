package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	fmt.Printf("Hello, WebSocket Server!")

	setupWSApp()
	serverErr := http.ListenAndServe(":5000", nil)
	if serverErr != nil {
		log.Printf("SERVER ERROR: %v\n", serverErr.Error())
	}
}
