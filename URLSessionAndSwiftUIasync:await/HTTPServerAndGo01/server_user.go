package main

import (
	"encoding/json"
	"errors"
	"net/http"
	"strings"
)

func HandleUserRequest(write http.ResponseWriter, request *http.Request) {

	switch request.Method {
	// V 1.0
	case "GET":
		// pageValue := request.FormValue("page")
		// if pageValue != "" {
		// 	switch pageValue {
		// 	case "2":
		// 		write.Header().Set("Content-Type", "application/json")
		// 		encErr := json.NewEncoder(write).Encode(GetUsers)
		// 		if encErr != nil {
		// 			http.Error(write, encErr.Error(), http.StatusBadRequest)
		// 			return
		// 		}
		// 	default:
		// 		http.Error(write, "WRONG QueryValue", http.StatusBadRequest)
		// 		return
		// 	}
		// } else {
		// 	http.Error(write, "WRONG QueryItems", http.StatusBadRequest)
		// }
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
		write.Header().Set("Content-Type", "application/json")
		var user UserForm

		decErr := json.NewDecoder(request.Body).Decode(&user)
		if decErr != nil {
			http.Error(write, decErr.Error(), http.StatusBadRequest)
			return
		}
		newFormUser, foudErr := foundUser(user, PostUsers)
		if foudErr != nil {
			http.Error(write, foudErr.Error(), http.StatusBadRequest)
			return
		}
		encError := json.NewEncoder(write).Encode(newFormUser)
		if encError != nil {
			http.Error(write, encError.Error(), http.StatusBadRequest)
		}
	}
}

func foundUser(userForm UserForm, postUsers []PostUser) (PostUser, error) {
	for _, v := range postUsers {
		if (strings.EqualFold(v.Name, userForm.Name)) && (strings.EqualFold(v.Job, userForm.Job)) {
			return v, nil
		}
	}
	return PostUser{Name: "User" + userForm.Name + "", Job: "not found", Id: "", CreatedAt: ""}, errors.New("User" + userForm.Name + "not found")
}
