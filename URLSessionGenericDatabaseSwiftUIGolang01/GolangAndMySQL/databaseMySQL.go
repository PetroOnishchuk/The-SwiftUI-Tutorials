package main

import (
	"database/sql"
	"fmt"
	"os"

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
