package main

import (
	"fmt"
	"net/http"

	_ "modernc.org/sqlite"
)

func main() {
	fmt.Printf("SQLite Database\n")

	err := openDatabase()
	if err == nil {
		fmt.Printf("Database Open Succeed\n")
	} else {
		fmt.Printf("Error to Open Database %v\n", err)
	}

	d := DB.Ping()
	if d != nil {
		fmt.Printf("DATABASE CLOSE: %v\n", d)
	} else {
		fmt.Printf("DATABASE Open\n")
	}

	// SELECT ALL USERS
	http.HandleFunc("/users/", selectAllUsersRequest)

	// SELECT COUPLE USERS
	http.HandleFunc("/select", selectUsersPOSTRequest)

	// SELECT SINGLE USER
	http.HandleFunc("/selectSingle", selectSingleUserPOSTRequest)

	// INSERT NEW USER
	http.HandleFunc("/newUser", insertNewUserPOSTRequest)

	// UPDATE USER
	http.HandleFunc("/update", updateUserPOSTRequest)

	// DELETE USER
	http.HandleFunc("/delete", deleteUserPOSTRequest)

	serverErr := http.ListenAndServe(":5000", nil)

	if serverErr != nil {
		fmt.Printf("SERVER Error: %v", serverErr)
	}

	defer DB.Close()
}
