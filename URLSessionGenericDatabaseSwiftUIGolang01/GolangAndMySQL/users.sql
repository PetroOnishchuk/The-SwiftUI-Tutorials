USE UsersMySQL;
DROP TABLE IF EXISTS Users;

CREATE TABLE IF NOT EXISTS Users (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    First_name varchar(255),
    Last_name varchar(255),
    Email varchar(255),
    Avatar varchar(255)
);

INSERT INTO Users(First_name, Last_name, Email, Avatar) VALUES
("ron", "MySQL", "testemailt@icloud.com", ":)"),
("rona", "MySQL", "testemail@gmail.com", ":)"),
("tom", "MySQL", "testemailt@yahoo.com", ":)");