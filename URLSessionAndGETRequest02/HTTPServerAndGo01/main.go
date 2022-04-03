package main

import (
	"fmt"
	"net/http"
)

func main() {

	http.HandleFunc("/json", HandleJsonRequest)
	err := http.ListenAndServe(":5000", nil)
	if err != nil {
		fmt.Printf("Error: %v", err.Error())
	}

}
