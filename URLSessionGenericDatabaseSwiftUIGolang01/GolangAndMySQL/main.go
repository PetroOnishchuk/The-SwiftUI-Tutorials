package main

import (
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	setDBConfig()
	openDBerr := openDatabase()
	if openDBerr != nil {
		fmt.Printf("Error open Database %v\n", openDBerr)
	}
	fmt.Printf("MySQL Project")
}
