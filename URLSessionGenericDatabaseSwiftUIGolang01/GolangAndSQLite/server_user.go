package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
)

//SELECT ALL Users
func selectAllUsersRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "GET":
		var allUsers = []User{}

		reqFormValue := request.FormValue("users")
		if reqFormValue != "" {
			switch reqFormValue {
			case "all":
				writer.Header().Set("Content-Type", "application/json")
				queryErr := selectAllUsers(&allUsers)
				if queryErr != nil {
					http.Error(writer, queryErr.Error(), http.StatusBadRequest)
					return
				}
				newEncoder := json.NewEncoder(writer)

				encodeErr := newEncoder.Encode(allUsers)

				if encodeErr != nil {
					http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
					return
				}
			default:
				http.Error(writer, "WRONG QUERY Value", http.StatusBadRequest)
				return
			}

		} else {
			http.Error(writer, "WRONG Query Items", http.StatusBadRequest)
		}
	case "POST":
		fmt.Printf("POST Request\n")
	}
}

//SELECT Couple Users
func selectUsersPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		ctx := context.Background()

		writer.Header().Set("Content-Type", "application/json")

		var newUser User

		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&newUser)

		if decErr != nil {
			http.Error(writer, decErr.Error(), http.StatusBadRequest)
			return
		}
		var allSelectedUsers = []User{}

		err := selectUsersRows(ctx, newUser, &allSelectedUsers)

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

	}
}

//SELECT Single User
func selectSingleUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "application/json")

		var newUser User

		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&newUser)

		if decErr != nil {
			http.Error(writer, decErr.Error(), http.StatusBadRequest)
			return
		}
		// V.1
		//foundUser, err := selectSingleUsersRow(newUser)
		// V.2
		foundUserIdName, err := selectSingleUsersRowIdName(newUser)

		if err != nil {
			http.Error(writer, err.Error(), http.StatusBadRequest)
			return
		}

		newEncoder := json.NewEncoder(writer)
		// V.1
		//	encodeErr := newEncoder.Encode(foundUser)
		// V.2
		encodeErr := newEncoder.Encode(foundUserIdName)

		if encodeErr != nil {
			http.Error(writer, encodeErr.Error(), http.StatusBadRequest)
			return
		}

	}
}

// INSERT NEW User
func insertNewUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "applicaion/json")

		var newUser User
		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&newUser)

		if decErr != nil {
			http.Error(writer, decErr.Error(), http.StatusBadRequest)
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
		fmt.Printf("Create New User with ID: %v\n", id)

	}
}

//UPDATE ROW User
func updateUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "applicaion/json")

		var updateUser User

		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&updateUser)

		if decErr != nil {
			http.Error(writer, decErr.Error(), http.StatusBadRequest)
			return
		}

		result, err := updateUsersRow(updateUser)
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

		fmt.Printf("Rows Update: #%v\n", result)
	}

}

//DELETE User
func deleteUserPOSTRequest(writer http.ResponseWriter, request *http.Request) {
	switch request.Method {
	case "POST":
		writer.Header().Set("Content-Type", "applicaion/json")

		var deleteUser User

		newDec := json.NewDecoder(request.Body)
		decErr := newDec.Decode(&deleteUser)

		if decErr != nil {
			http.Error(writer, decErr.Error(), http.StatusBadRequest)
			return
		}

		result, err := deleteUsersRow(deleteUser)

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

		fmt.Printf("User deleted: #%v\n", result)
	}
}
