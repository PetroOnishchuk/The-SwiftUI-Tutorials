package main

import (
	"fmt"

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
	fmt.Printf("MySQL Project")
}
