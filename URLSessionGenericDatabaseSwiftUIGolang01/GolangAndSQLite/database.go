package main

import (
	"database/sql"
	"fmt"

	_ "modernc.org/sqlite"
)

var DB *sql.DB

//OPEN DATABASE
func openDatabase() (err error) {
	db, err := sql.Open("sqlite", "users.db")
	if err != nil {
		return err
	}

	fmt.Printf("Database Opened\n")
	DB = db
	return nil
}
