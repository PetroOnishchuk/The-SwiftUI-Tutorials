package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	"github.com/go-sql-driver/mysql"
	_ "github.com/go-sql-driver/mysql"
)

var DB *sql.DB

func setDBConfig() {
	os.Setenv("DBUSER", "root")
	os.Setenv("DBPASS", "444888444")
}

func openDatabase() (err error) {
	cfg := mysql.Config{
		User:   os.Getenv("DBUSER"),
		Passwd: os.Getenv("DBPASS"),
		Net:    "tcp",
		Addr:   "127.0.0.1:3306",
		DBName: "UsersMySQL",
	}
	db, err := sql.Open("mysql", cfg.FormatDSN())

	// V.2.0
	//db, err := sql.Open("mysql","root:444888444@tcp(127.0.0.1:3306)/UsersMySQL")

	if err != nil {
		fmt.Printf("Error open MySQL Database %v\n", err)
		return err
	}
	fmt.Printf("DATABASE Opened \n")
	DB = db
	return nil

}

// Execute users.sql file
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
