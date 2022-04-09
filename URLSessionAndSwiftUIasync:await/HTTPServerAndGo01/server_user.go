package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func HandleUserRequest(write http.ResponseWriter, request *http.Request) {

	switch request.Method {
	// V 1.0
	case "GET":
		pageValue := request.FormValue("page")
		if pageValue != "" {
			switch pageValue {
			case "2":
				write.Header().Set("Content-Type", "application/json")
				encErr := json.NewEncoder(write).Encode(GetUsers)
				if encErr != nil {
					http.Error(write, encErr.Error(), http.StatusBadRequest)
					return
				}
			default:
				http.Error(write, "WRONG QueryValue", http.StatusBadRequest)
				return
			}
		} else {
			http.Error(write, "WRONG QueryItems", http.StatusBadRequest)
		}
		// V 2.0
		allQueryValues := request.URL.Query()
		for key, values := range allQueryValues {
			switch key {
			case "page":
				for _, item := range values {
					switch item {
					case "2":
						write.Header().Set("Content-Type", "application/json")
						encErr := json.NewEncoder(write).Encode(GetUsers)
						if encErr != nil {
							http.Error(write, encErr.Error(), http.StatusBadRequest)
							return
						}
					default:
						http.Error(write, "WRONG QueryValue", http.StatusBadRequest)
						return
					}
				}
			default:
				http.Error(write, "WRONG QueryItems", http.StatusBadRequest)
			}
		}

	case "POST":
		fmt.Println("POST Request")
	}
}
