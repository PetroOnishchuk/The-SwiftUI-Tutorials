package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"strings"
)

var DB *sql.DB

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "password"
	dbname   = "userpostgresql"
)

// OPEN Database
func openDatabase() (err error) {
	psqlconn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)

	db, err := sql.Open("postres", psqlconn)
	if err != nil {
		fmt.Printf("Error Open Database %n\n", err)
		return err
	}
	err = db.Ping()
	if err != nil {
		fmt.Printf("Error with db.Ping: %v", err)
		return err
	}
	DB = db
	fmt.Printf("Database Connected\n")
	return nil
}

//EXECUTE SQL File
func execSqlFile() (err error) {
	file, err := ioutil.ReadFile("users.sql")
	if err != nil {
		return err
	}

	requests := strings.Split(string(file), ";")

	for _, request := range requests {
		fmt.Printf("REQUEST %v\n", request)

		_, err := DB.Exec(request)

		if err != nil {
			return err
		}

	}
	return nil
}
