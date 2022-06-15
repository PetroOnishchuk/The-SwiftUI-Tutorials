package main

import (
	"fmt"

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

	fmt.Printf("Hello PostgreSQL Satabase")
}
