package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func HandleJsonRequest(write http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "GET":
		switch request.FormValue("page") {
		case "2":
			write.Header().Set("Content-Type", "application/json")
			json.NewEncoder(write).Encode(Users)

		default:
			http.Error(write, "WRONG QueryItems", http.StatusNotFound)
		}
	case "POST":
		fmt.Println("POST Request")
	}
}
