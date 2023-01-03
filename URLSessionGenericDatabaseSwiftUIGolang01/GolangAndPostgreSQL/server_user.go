package main

import (
	"context"
	"encoding/json"
	"net/http"
)

// SELECT ALL Users Rows
func selectAllUsersRowsRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "GET":
		var allSelectedUsers = []User{}

		reqFormValue := request.FormValue("users")
		if reqFormValue == "" {
			http.Error(writer, "wrong QueryItems", http.StatusBadRequest)
		}
		switch reqFormValue {
		case "all":
			writer.Header().Set("Content-Type", "application/json")
			err := queryDatabaseAllUsers(&allSelectedUsers)
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
			http.Error(writer, "wrong QueryValue", http.StatusBadRequest)
			return
		}
	}
}

// SELECT Multiple Users Rows
func selectMultipleUsersPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		ctx := context.Background()

		var allSelectedUsers = []User{}
		writer.Header().Set("Content-Type", "application/json")

		var searchUser User

		newDecoder := json.NewDecoder(request.Body)
		decodeErr := newDecoder.Decode(&searchUser)

		if decodeErr != nil {
			http.Error(writer, decodeErr.Error(), http.StatusBadRequest)
			return
		}

		selectErr := selectUsersRows(ctx, searchUser, &allSelectedUsers)

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

// SELECT Single Users Row
func selectSingleUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var searchUser User

		newDecoder := json.NewDecoder(request.Body)
		decodeErr := newDecoder.Decode(&searchUser)

		if decodeErr != nil {
			http.Error(writer, decodeErr.Error(), http.StatusBadRequest)
			return
		}
		//V.1
		//selectedUser, err := selectSingleUsersRow(searchUser)

		// V.2
		selectedUserIdName, err := selectSingleUsersRowIdName(searchUser)
		if err != nil {
			http.Error(writer, err.Error(), http.StatusBadRequest)
			return
		}

		newEncoder := json.NewEncoder(writer)
		encoderErr := newEncoder.Encode(selectedUserIdName)

		if encoderErr != nil {
			http.Error(writer, encoderErr.Error(), http.StatusBadRequest)
			return
		}
	}
}

// INSERT New Users Row
func insertNewUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var newUser User

		newDecoder := json.NewDecoder(request.Body)
		decodeErr := newDecoder.Decode(&newUser)

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

// UPDATE Users Row
func updateUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var updatingUser User

		newDecoder := json.NewDecoder(request.Body)
		decodeErr := newDecoder.Decode(&updatingUser)

		if decodeErr != nil {
			http.Error(writer, decodeErr.Error(), http.StatusBadRequest)
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

// DELETE Users Row
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
		encodeErr := newEncoder.Encode(result)

		if encodeErr != nil {
			http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
			return
		}
	}
}
