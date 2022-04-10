package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/users", HandleUserRequest)
	err := http.ListenAndServe(":5000", nil)
	if err != nil {
		fmt.Printf("Server Error: %v", err.Error())
	}
}
