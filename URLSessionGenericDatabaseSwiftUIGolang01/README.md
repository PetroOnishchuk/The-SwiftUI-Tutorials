# SwiftUI Project & GO (Golang) Project & Databases (SQLite, MySQL, PostgreSQL)

## Setup SQLite Database.  

1. [Link to Download SQLite DB.](https://www.sqlite.org/download.html)<br />

2. Create Database: users
./sqlite3 users.db ".read users.sql"  
 
3. Setup Golang project:
go get modernc.org/sqlite  


## Setup MySQL Database.

1. [Link Download MySQL](https://dev.mysql.com/downloads/file/?id=499568)<br /> 


2. If you’re on a Mac, type the following command:  
export PATH=$PATH:/usr/local/mysql/bin  
 
3. On Terminal:  
    mysql -u root -p  
    —enter password—  
    
4. In mysql>  
   mysql> CREATE DATABASE UsersMySQL;  

5. Setup Golang project:  
go get -u github.com/go-sql-driver/mysql   


## Setup PostgreSQL Database.

1. [Download PostgreSQL](https://www.postgresql.org/download/)  

2. On Terminal:  
psql -U postgres  

3. On Postgres:  
postgres=# create database UserPostgreSQL;  

4. Setup Golang Project:   
go get -u github.com/lib/pq  

 
![visitors](https://visitor-badge.glitch.me/badge?page_id=petroonishchuk.URLSessionGenericDatabaseSwiftUIGolang01)
