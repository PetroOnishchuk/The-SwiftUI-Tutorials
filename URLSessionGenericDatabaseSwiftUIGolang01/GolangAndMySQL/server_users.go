package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
)

//SELECT All Users GET Request
func selectAllUsersRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "GET":

		var allSelectedUsers = []User{}

		reqFormValue := request.FormValue("users")
		if reqFormValue == "" {
			http.Error(writer, "WRONG Query Items", http.StatusBadRequest)
			return
		}
		switch reqFormValue {
		case "all":

			writer.Header().Set("Content-Type", "application/json")
			err := queryDatabaseUsers(&allSelectedUsers)
			if err != nil {
				http.Error(writer, err.Error(), http.StatusBadRequest)
				return
			}

			newEncoder := json.NewEncoder(writer)
			encodeErr := newEncoder.Encode(allSelectedUsers)

			if encodeErr != nil {
				http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
				return
			}

		default:
			http.Error(writer, "WRONG Query Value", http.StatusBadRequest)
			return
		}
	}
}

// SELECT couple Users POST Request
func selectUsersPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		ctx := context.Background()

		var allSelectedUsers = []User{}
		writer.Header().Set("Content-Type", "application/json")

		var searchingUser User

		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&searchingUser)

		if decErr != nil {
			http.Error(writer, decErr.Error(), http.StatusBadRequest)
			return
		}

		selectErr := selectUsersRows(ctx, searchingUser, &allSelectedUsers)

		if selectErr != nil {
			http.Error(writer, selectErr.Error(), http.StatusBadRequest)
			return
		}
		newEncoder := json.NewEncoder(writer)
		encodeErr := newEncoder.Encode(allSelectedUsers)

		if encodeErr != nil {
			http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
			return
		}
	}
}

// SELECT Single User
func selectSingleUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var searchingUser User

		newDecoder := json.NewDecoder(request.Body)
		decodeErr := newDecoder.Decode(&searchingUser)

		if decodeErr != nil {
			http.Error(writer, decodeErr.Error(), http.StatusBadRequest)
			return
		}
		// V.1
		//selectedUser, err := selectSingleUsersRow(searchingUser)
		// V.2
		selectedUserIdName, err := selectingSingleUsersRowIdName(searchingUser)
		if err != nil {
			http.Error(writer, err.Error(), http.StatusBadRequest)
			return
		}

		newEncoder := json.NewEncoder(writer)
		encodeErr := newEncoder.Encode(selectedUserIdName)

		if encodeErr != nil {
			http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
			return
		}
	}
}

//INSERT New User
func insertNewUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var newUser User

		newDecoder := json.NewDecoder(request.Body)
		decodeErr := newDecoder.Decode(&newUser)
		fmt.Printf("NEW USER %v", newUser)
		if decodeErr != nil {
			http.Error(writer, decodeErr.Error(), http.StatusBadRequest)
			return
		}

		id, err := insertNewUsersRow(newUser)

		if err != nil {
			http.Error(writer, err.Error(), http.StatusBadRequest)
			return
		}

		newEncoder := json.NewEncoder(writer)
		encodeErr := newEncoder.Encode(id)

		if encodeErr != nil {
			http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
			return
		}

	}
}

// UPDATE User
func updateUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var updatingUser User

		newDecoder := json.NewDecoder(request.Body)
		decoderErr := newDecoder.Decode(&updatingUser)

		if decoderErr != nil {
			http.Error(writer, decoderErr.Error(), http.StatusBadRequest)
			return
		}

		result, err := updateUsersRow(updatingUser)

		if err != nil {
			http.Error(writer, err.Error(), http.StatusBadRequest)
			return
		}
		newEncoder := json.NewEncoder(writer)
		encodeErr := newEncoder.Encode(result)

		if encodeErr != nil {
			http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
			return
		}
	}
}

// DELETE User
func deleteUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var deletingUser User

		newDecoder := json.NewDecoder(request.Body)
		decodeErr := newDecoder.Decode(&deletingUser)

		if decodeErr != nil {
			http.Error(writer, decodeErr.Error(), http.StatusBadRequest)
			return
		}

		result, err := deleteUsersRow(deletingUser)

		if err != nil {
			http.Error(writer, err.Error(), http.StatusBadRequest)
			return
		}
		newEncoder := json.NewEncoder(writer)
		encoderErr := newEncoder.Encode(result)

		if encoderErr != nil {
			http.Error(writer, encoderErr.Error(), http.StatusBadRequest)
			return
		}

	}
}
