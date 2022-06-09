package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
)

//SELECT ALL Users
func selectAllUsersRequest(write http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "GET":
		var allUsers = []User{}

		reqFormValue := request.FormValue("users")
		if reqFormValue != "" {
			switch reqFormValue {
			case "all":
				write.Header().Set("Content-Type", "application/json")
				queryErr := selectAllUsers(&allUsers)
				if queryErr != nil {
					http.Error(write, queryErr.Error(), http.StatusBadRequest)
					return
				}
				newEncoder := json.NewEncoder(write)

				encodeErr := newEncoder.Encode(allUsers)

				if encodeErr != nil {
					http.Error(write, encodeErr.Error(), http.StatusBadRequest)
					return
				}
			default:
				http.Error(write, "WRONG QUERY Value", http.StatusBadRequest)
				return
			}

		} else {
			http.Error(write, "WRONG Query Items", http.StatusBadRequest)
		}
	case "POST":
		fmt.Printf("POST Request\n")
	}
}

//SELECT Couple Users
func selectUsersPOSTRequest(write http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		ctx := context.Background()

		write.Header().Set("Content-Type", "application/json")

		var newUser User

		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&newUser)

		if decErr != nil {
			http.Error(write, decErr.Error(), http.StatusBadRequest)
			return
		}
		var allSelectedUsers = []User{}

		err := selectUsersRows(ctx, newUser, &allSelectedUsers)

		if err != nil {
			http.Error(write, err.Error(), http.StatusBadRequest)
			return
		}

		newEncoder := json.NewEncoder(write)

		encodeErr := newEncoder.Encode(allSelectedUsers)

		if encodeErr != nil {
			http.Error(write, encodeErr.Error(), http.StatusBadRequest)
			return
		}

	}
}

//SELECT Single User
func selectSingleUserPOSTRequest(write http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		write.Header().Set("Content-Type", "application/json")

		var newUser User

		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&newUser)

		if decErr != nil {
			http.Error(write, decErr.Error(), http.StatusBadRequest)
			return
		}

		foundUser, err := selectSingleUsersRow(newUser)
		if err != nil {
			http.Error(write, err.Error(), http.StatusBadRequest)
			return
		}

		newEncoder := json.NewEncoder(write)

		encodeErr := newEncoder.Encode(foundUser)

		if encodeErr != nil {
			http.Error(write, encodeErr.Error(), http.StatusBadRequest)
			return
		}

	}
}

// INSERT NEW User
