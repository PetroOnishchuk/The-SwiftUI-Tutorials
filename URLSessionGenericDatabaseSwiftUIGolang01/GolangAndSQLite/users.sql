DROP TABLE IF EXISTS Users;

CREATE TABLE IF NOT EXISTS Users (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    First_name TEXT NOT NULL,
    Last_name TEXT NOT NULL,
    Email TEXT NOT NULL,
    Avatar TEXT NOT NULL
);


INSERT INTO Users (First_name, Last_name, Email, Avatar) VALUES 
("ron", "dn", "testemailt@icloud.com", ":)" ),
("rona", "ql", "testemail@gmail.com", ":)"),
("tom", "mt", "testemailt@yahoo.com", ":)");