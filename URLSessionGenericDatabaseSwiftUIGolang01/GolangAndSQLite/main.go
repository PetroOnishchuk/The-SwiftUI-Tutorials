package main

import (
	"fmt"

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

	defer DB.Close()
}
