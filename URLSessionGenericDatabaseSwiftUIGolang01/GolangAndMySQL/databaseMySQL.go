package main

import (
	"context"
	"database/sql"
	"errors"
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

//SELECT ALL ROWS
func queryDatabaseUsers(allUsers *[]User) error {
	rows, err := DB.Query("SELECT * FROM Users")

	if err != nil {
		fmt.Printf("ERROR Query SELECT * FROM Users: %v", err)
		return err
	}
	defer rows.Close()
	for rows.Next() {
		var id int
		var first_name string
		var last_name string
		var email string
		var avatar string
		rows.Scan(&id, &first_name, &last_name, &email, &avatar)
		newUser := User{Id: id, First_name: first_name, Last_name: last_name, Email: email, Avatar: avatar}

		*allUsers = append(*allUsers, newUser)
	}
	return nil
}

// SELECT Multiple Rows
func selectUsersRows(ctx context.Context, searchUser User, allSelectedUsers *[]User) error {
	tx, err := DB.BeginTx(ctx, nil)
	if err != nil {
		return err
	}

	rows, err := tx.QueryContext(ctx, "SELECT id, first_name, last_name, email, avatar FROM Users WHERE id = ? OR first_name = ?", searchUser.Id, searchUser.First_name)

	if err != nil {
		tx.Rollback()
		return err
	}
	defer rows.Close()
	for rows.Next() {
		var id int
		var first_name string
		var last_name string
		var email string
		var avatar string

		rows.Scan(&id, &first_name, &last_name, &email, &avatar)

		newUser := User{Id: id, First_name: first_name, Last_name: last_name, Email: email, Avatar: avatar}

		*allSelectedUsers = append(*allSelectedUsers, newUser)
	}

	commitErr := tx.Commit()
	if commitErr != nil {
		return commitErr
	} else {
		return nil
	}
}

//SELECT Single Row
func selectSingleUsersRow(searchUser User) (User, error) {
	selectedUser := User{}
	stmt, err := DB.Prepare("SELECT id, first_name, last_name, email, avatar FROM Users WHERE id = ? OR first_name = ?")

	if err != nil {
		return selectedUser, err
	}

	mySQLErr := stmt.QueryRow(searchUser.Id, searchUser.First_name).Scan(&selectedUser.Id, &searchUser.First_name, &selectedUser.Last_name, &selectedUser.Email, &selectedUser.Avatar)

	if mySQLErr != nil {
		if mySQLErr == sql.ErrNoRows {
			return selectedUser, errors.New("no Rows Error")
		}
		return selectedUser, mySQLErr
	}
	return selectedUser, nil
}

// INSERT New Users Row
func insertNewUsersRow(newUser User) (id int64, err error) {
	tx, err := DB.Begin()
	if err != nil {
		return 0, err
	}

	stmt, err := tx.Prepare("INSERT INTO Users (first_name, last_name, email, avatar) VALUES (?, ?, ?, ?)")

	if err != nil {
		return 0, err
	}

	defer stmt.Close()

	res, err := stmt.Exec(newUser.First_name, newUser.Last_name, newUser.Email, newUser.Avatar)

	if err != nil {
		tx.Rollback()
		return 0, err
	}

	id, err = res.LastInsertId()
	if err != nil {
		tx.Rollback()
		return 0, err
	}

	commitErr := tx.Commit()
	if commitErr != nil {
		return id, commitErr
	} else {
		return id, nil
	}
}

// UPDATE Users Row
