DROP TABLE IF EXISTS Users;


CREATE TABLE IF NOT EXISTS Users (
    Id serial PRIMARY KEY,
    First_name varchar(255),
    Last_name varchar(255),
    Email varchar(255),
    Avatar varchar(255)
);

INSERT INTO Users(First_name, Last_name, Email, Avatar) VALUES
('ron', 'PostgreSQL', 'testemailt@icloud.com', ':)' ),
('rona', 'PostgreSQL', 'testemail@gmail.com', ':)'),
('tom', 'PostgreSQL', 'testemailt@yahoo.com', ':)');
