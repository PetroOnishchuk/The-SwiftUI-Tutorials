package main

import (
	"context"
	"database/sql"
	"errors"
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

	db, err := sql.Open("postgres", psqlconn)
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

// SELECT ALL Users Rows
func queryDatabaseAllUsers(allSelectedUsers *[]User) error {
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
		*allSelectedUsers = append(*allSelectedUsers, newUser)
	}
	return nil

}

// SELECT Multiple Rows
func selectUsersRows(ctx context.Context, searchUser User, allSelectedUsers *[]User) error {

	tx, err := DB.BeginTx(ctx, nil)
	if err != nil {
		return err
	}

	rows, err := tx.QueryContext(ctx, "SELECT id, first_name, last_name, email, avatar FROM Users WHERE id = $1 OR first_name = $2", searchUser.Id, searchUser.First_name)
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

// SELECT Single Users Row
func selectSingleUsersRow(searchUser User) (User, error) {
	selectedUser := User{}
	stmt, err := DB.Prepare("SELECT id, first_name, last_name, email, avatar FROM Users WHERE id = $1 OR first_name = $2")

	if err != nil {
		return selectedUser, err
	}

	mySQLErr := stmt.QueryRow(searchUser.Id, searchUser.First_name).Scan(&selectedUser.Id, &selectedUser.First_name, &selectedUser.Last_name, &selectedUser.Email, &selectedUser.Avatar)

	if mySQLErr != nil {
		if mySQLErr == sql.ErrNoRows {
			return selectedUser, nil
		}
		return selectedUser, mySQLErr
	}
	return selectedUser, nil
}

// SELECT Single Users Row Id Name
func selectSingleUsersRowIdName(searchUser User) (User, error) {
	selectedUser := User{}
	stmtId, errId := DB.Prepare("SELECT id, first_name, last_name, email, avatar FROM Users WHERE id = $1")
	if errId != nil {
		return selectedUser, errId
	}

	stmtName, errName := DB.Prepare("SELECT id, first_name, last_name, email, avatar FROM Users WHERE first_name = $1")
	if errName != nil {
		return selectedUser, errName
	}

	mySQLErrId := stmtId.QueryRow(searchUser.Id).Scan(&selectedUser.Id, &selectedUser.First_name, &selectedUser.Last_name, &selectedUser.Email, &selectedUser.Avatar)

	if mySQLErrId != nil {
		if mySQLErrId == sql.ErrNoRows {

			mySQLErrName := stmtName.QueryRow(searchUser.First_name).Scan(&selectedUser.Id, &selectedUser.First_name, &selectedUser.Last_name, &selectedUser.Email, &selectedUser.Avatar)
			if mySQLErrName != nil {
				if mySQLErrName == sql.ErrNoRows {
					return selectedUser, nil
				}
				return selectedUser, mySQLErrName
			}
			return selectedUser, nil
		}
		return selectedUser, mySQLErrId
	}
	return selectedUser, nil
}

// INSERT NEW Users Row
func insertNewUsersRow(newUser User) (id int64, err error) {
	sqlStatement := `INSERT INTO Users(first_name, last_name, email, avatar) VALUES($1, $2, $3, $4) RETURNING id`

	err = DB.QueryRow(sqlStatement, newUser.First_name, newUser.Last_name, newUser.Email, newUser.Avatar).Scan(&id)

	if err != nil {
		return 0, err
	}
	return id, nil
}

// UPDATE Users Row
func updateUsersRow(updatingUser User) (int64, error) {
	tx, err := DB.Begin()
	if err != nil {
		return 0, err
	}

	stmt, err := tx.Prepare("UPDATE Users SET first_name = $1, last_name = $2, email = $3, avatar = $4 WHERE id = $5")

	if err != nil {
		return 0, err
	}
	defer stmt.Close()
	res, err := stmt.Exec(updatingUser.First_name, updatingUser.Last_name, updatingUser.Email, updatingUser.Avatar, updatingUser.Id)

	if err != nil {
		tx.Rollback()
		return 0, err
	}

	rowsAfected, err := res.RowsAffected()

	if err != nil {
		tx.Rollback()
		return 0, err
	} else if rowsAfected == 0 {
		tx.Rollback()
		return 0, errors.New("no Row Afected Error when Update")
	}
	commitErr := tx.Commit()
	if commitErr != nil {
		return 0, commitErr
	} else {
		return rowsAfected, nil
	}
}

// DELETE Users Row
func deleteUsersRow(deletingUser User) (int64, error) {
	tx, err := DB.Begin()
	if err != nil {
		return 0, err
	}

	stmt, err := tx.Prepare("DELETE FROM Users WHERE id = $1")
	if err != nil {
		return 0, err
	}
	defer stmt.Close()

	res, err := stmt.Exec(deletingUser.Id)
	if err != nil {
		tx.Rollback()
		return 0, err
	}

	rowAfected, err := res.RowsAffected()

	if err != nil {
		return 0, err
	}
	if rowAfected == 0 {
		return 0, errors.New("no Row Afected Error")
	}
	commitErr := tx.Commit()
	if commitErr != nil {
		return rowAfected, commitErr
	} else {
		return rowAfected, nil
	}

}
