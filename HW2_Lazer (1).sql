-- Address Person Student Teacher Course
-- pk fk unique null default

CREATE DATABASE University;
USE University;
CREATE TABLE Address (    
id INT NOT NULL AUTO_INCREMENT,    
Country VARCHAR(25) NOT NULL,    
City VARCHAR(25),
Street VARCHaR(25),
Number VARCHAR(5),
PRIMARY KEY(id)
);
SELECT * from Address;

CREATE TABLE Person (    
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,    
FirstName VARCHAR(25),    
LastName VARCHAR(25) NOT NULL,
PhoneNumber VARCHAR(20),
BirthDate DATE,
AdressId int,
FOREIGN KEY(AdressId) REFERENCES Address(id),
UNIQUE KEY(PhoneNumber)
);
SELECT * FROM Person;

CREATE TABLE Student (    
id INT NOT NULL AUTO_INCREMENT,    
PersonId INT,    
Description VARCHAR(100) DEFAULT "prosto jurgen adam",
PRIMARY KEY(id),
FOREIGN KEY(PersonId) REFERENCES Person(id) ON DELETE CASCADE
);
SELECT * from Student;



CREATE TABLE Teacher (    
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,    
PersonId INT,    
Position VARCHAR(50),
FOREIGN KEY(PersonId) REFERENCES Person(id)
);
SELECT * FROM Teacher;

CREATE TABLE Course (    
id INT NOT NULL AUTO_INCREMENT,   
Name VARCHAR(50),
Credits INT Default 3,
Description VARCHAR(100), 
TeacherId INT,    
PRIMARY KEY(id),
FOREIGN KEY(TeacherId) REFERENCES Teacher(id)
);
SELECT * FROM Course;

DROP TABLE Address; # Cannot drop table 'address' referenced by a foreign key constraint 'person_ibfk_1' on table 'Person'.
ALTER TABLE Address
-- DROP COLUMN City;
-- ALTER COLUMN City SET DEFAULT 'Kazakhstan';
MODIFY Country VARCHAR(25) DEFAULT 'Kazakhstan';

-- it will change my otpechatku
ALTER TABLE Person
CHANGE COLUMN AdressId AddressId INT;


INSERT INTO Address VALUES
(1, 'China', 'Habahe', 'Shanshui st', '101A'),#my home address
(2, 'Kazakhstan', 'Astana', 'Satpayev', '25A'),
(3,'France', 'Le Plessis-robinson', '20 rue Adolphe Wurtz', '50S'),
(4,'Belgium', 'Zemst', 'Touwslagerstraat', '85'),
(5,'Kazakhstan', 'Almaty', 'Abai', '10'),
(6,'Kazakhstan', 'Shymkent', 'Tauke Khan', '50'),
(7,'Kazakhstan', 'Atyrau', 'Baitursynov', '15B');

-- default check country kazakhstan 8
INSERT INTO Address (City, Street, Number) VALUES 
('Aktobe', 'Seifullin', '33');

INSERT INTO Person (FirstName, LastName, PhoneNumber, BirthDate, AddressId) VALUES
('Li', 'Wei', '8607000001', '1987-04-12', 1),
('Marie', 'Dupont', '8607000002', '1992-07-25', 3),
('Lucas', 'Peeters', '8607000004', '1990-02-28', 4), 
('Aidar', 'Bekov', '8707000001', '2006-05-12', 2),
('Marat', 'Kairat', '8707000002', '2007-03-22', 2),
('Nurila', 'Sarsenova', '8707000003', '2005-11-15', 5),
('Aigerim', 'Tulegenkyzy', '8707000004', '2005-09-01', 6),
('Serik', 'Perik', '8707000005', '1982-01-30', 8);

-- unique phone number check
INSERT INTO Person (FirstName, LastName, PhoneNumber, BirthDate, AddressId) VALUES
('Serik', 'Berik', '8707000001', '2008-01-30', 7);

INSERT INTO Student (PersonId, Description) VALUES
(4, 'Excellent student'),
(6, 'Exchange program'),
(7, 'Graduate student');

-- default description prosto jurgen adam
INSERT INTO Student (PersonId) VALUES
(5);

INSERT INTO Teacher (PersonId, Position) VALUES
(1, 'Professor'),
(2, 'Lecturer'),
(3, 'Senior Lecturer'),
(8, 'Tutor');

INSERT INTO Course (Name, Credits, Description, TeacherId) VALUES
('Mathematics', 5, 'calculus 1', 1),
('Physics', 4, 'mechanics', 2),
('History', 2, 'Kazakh history', 4),
('WebDev', 1, 'Java EE', 3);

-- default credit is 3
INSERT INTO Course (Name, Description, TeacherId) VALUES
('Programming', 'Intro to Python', 3);