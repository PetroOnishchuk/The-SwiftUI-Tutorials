package main

import (
	"context"
	"database/sql"
	"errors"
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

//SELECT All Users
func selectAllUsers(allUsers *[]User) error {
	rows, err := DB.Query("SELECT * from Users")
	if err != nil {
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

//SELECT Users Rows
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
	tx.Commit()
	return nil
}

//SELECT Single Users Row
func selectSingleUsersRow(searchUser User) (User, error) {
	selectedUser := User{}
	stmt, err := DB.Prepare("SELECT id, first_name, last_name, email, avatar FROM Users WHERE id = ? OR first_name = ?")

	if err != nil {
		return selectedUser, err
	}
	defer stmt.Close()

	sqlErr := stmt.QueryRow(searchUser.Id, searchUser.First_name).Scan(&selectedUser.Id, &selectedUser.First_name, &selectedUser.Last_name, &selectedUser.Email, &selectedUser.Avatar)

	if sqlErr != nil {
		if sqlErr == sql.ErrNoRows {
			return selectedUser, errors.New("no ROWS Error")
		}
		return selectedUser, sqlErr
	}
	return selectedUser, nil
}

// SELECT Single Users Row ID Name
func selectSingleUsersRowIdName(searchUser User) (User, error) {
	selectedUser := User{}
	stmtId, errId := DB.Prepare("SELECT id, first_name, last_name, email, avatar FROM Users WHERE id = ?")
	if errId != nil {
		return selectedUser, errId
	}

	stmtName, errName := DB.Prepare("SELECT id, first_name, last_name, email, avatar FROM Users WHERE first_name = ?")
	if errName != nil {
		return selectedUser, errName
	}

	mySQLIdErr := stmtId.QueryRow(searchUser.Id).Scan(&selectedUser.Id, &selectedUser.First_name, &selectedUser.Last_name, &selectedUser.Email, &selectedUser.Avatar)

	if mySQLIdErr != nil {
		if mySQLIdErr == sql.ErrNoRows {
			mySQLNameErr := stmtName.QueryRow(searchUser.First_name).Scan(&selectedUser.Id, &selectedUser.First_name, &selectedUser.Last_name, &selectedUser.Email, &selectedUser.Avatar)
			if mySQLNameErr != nil {
				if mySQLNameErr == sql.ErrNoRows {
					return selectedUser, nil
				}
				return selectedUser, mySQLNameErr
			}
			return selectedUser, nil
		}
		return searchUser, mySQLIdErr
	}
	return selectedUser, nil
}

//INSERT New Users Row
func insertNewUsersRow(newUser User) (id int64, err error) {
	tx, err := DB.Begin()
	if err != nil {
		return 0, err
	}
	stmt, err := tx.Prepare("INSERT INTO Users( first_name, last_name, email, avatar) VALUES (?, ?, ?, ?)")
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
	tx.Commit()
	return id, nil
}

// UPDATE Users Row
func updateUsersRow(updateUser User) (int64, error) {
	tx, err := DB.Begin()
	if err != nil {
		return 0, err
	}

	stmt, err := tx.Prepare("UPDATE Users SET first_name = ?, last_name = ?, email = ?, avatar = ? WHERE id = ?")

	if err != nil {
		return 0, err
	}

	defer stmt.Close()

	res, err := stmt.Exec(updateUser.First_name, updateUser.Last_name, updateUser.Email, updateUser.Avatar, updateUser.Id)

	if err != nil {
		tx.Rollback()
		return 0, err
	}

	rowAfected, err := res.RowsAffected()

	if err != nil {
		tx.Rollback()
		return 0, err
	} else if rowAfected == 0 {
		tx.Rollback()
		return 0, errors.New("no Row Afected while Update Row")
	}

	comErr := tx.Commit()
	if comErr != nil {
		return rowAfected, comErr
	} else {
		return rowAfected, nil
	}
}

// DELETE Users Row

func deleteUsersRow(deleteUser User) (int64, error) {
	tx, err := DB.Begin()
	if err != nil {
		return 0, err
	}

	stmt, err := tx.Prepare("DELETE FROM Users WHERE id = ?")

	if err != nil {
		return 0, err
	}
	defer stmt.Close()
	res, err := stmt.Exec(deleteUser.Id)

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

	comErr := tx.Commit()
	if err != nil {
		return rowAfected, comErr
	} else {
		return rowAfected, nil
	}

}
