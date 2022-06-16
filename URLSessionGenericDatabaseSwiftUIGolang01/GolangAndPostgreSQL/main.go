package main

import (
	"fmt"
	"net/http"

	_ "github.com/lib/pq"
)

func main() {

	// OPEN Database
	err := openDatabase()
	if err != nil {
		fmt.Printf("Error Open Database: %v", err)
	}

	// RUN Execute sql file
	execErr := execSqlFile()
	if execErr != nil {
		fmt.Printf("Error with execute SQL File: %v\n", execErr)
	}

	// SELECT All Users Rows
	http.HandleFunc("/users/", selectAllUsersRowsRequest)

	// SELECT Multiple Users Rows
	http.HandleFunc("/select", selectMultipleUsersPOSTRequest)

	// SELECT Single Users Row
	http.HandleFunc("/selectSingle", selectSingleUserPOSTRequest)

	// INSERT New Users Row
	http.HandleFunc("/newUser", insertNewUserPOSTRequest)

	// UPDATE Users Row
	http.HandleFunc("/update", updateUserPOSTRequest)

	// DELETE Users Row
	http.HandleFunc("/delete", deleteUserPOSTRequest)

	// HTTP SERVER
	serverErr := http.ListenAndServe(":5000", nil)
	if serverErr != nil {
		fmt.Printf("SERVER :5000 Error: %v", serverErr)
	}

	defer DB.Close()

	fmt.Printf("Hello PostgreSQL Satabase")
}
