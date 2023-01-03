package main

import (
	"fmt"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	setDBConfig()

	// OPEN DATABASE
	openDBerr := openDatabase()
	if openDBerr != nil {
		fmt.Printf("Error open Database %v\n", openDBerr)
	}

	// EXECUTE users.sql file
	execErr := execSqlFile()

	if execErr != nil {
		fmt.Printf("Error with execute SQL File: %v\n", execErr)
	}

	// SELECT ALL User Rows
	http.HandleFunc("/users/", selectAllUsersRequest)

	// SELECT COUPLE Users Rows
	http.HandleFunc("/select", selectUsersPOSTRequest)

	// SELECT SINGLE Users Row
	http.HandleFunc("/selectSingle", selectSingleUserPOSTRequest)

	// INSERT NEW Users Row
	http.HandleFunc("/newUser", insertNewUserPOSTRequest)

	// UPDATE Users Row
	http.HandleFunc("/update", updateUserPOSTRequest)

	// DELETE Users Row
	http.HandleFunc("/delete", deleteUserPOSTRequest)

	serverErr := http.ListenAndServe(":5000", nil)
	if serverErr != nil {
		fmt.Printf("SERVER Error %v", serverErr)
	}

	defer DB.Close()

	fmt.Printf("MySQL Project")
}
