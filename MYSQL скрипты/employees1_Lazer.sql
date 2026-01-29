Create database family;

Use family;

CREATE TABLE FamilyMembers (    
member_id int not null primary key auto_increment,    
status_fam varchar(10) not null,    
member_name varchar(25) not null,
birthdate date
);

CREATE TABLE Payments (    
payment_id int primary key not null auto_increment,    
good_name varchar(10) not null,    
amount decimal(7,2),
date_good date
);

CREATE TABLE FamilyFriends (    
friend_id int not null primary key auto_increment,    
friend_name varchar(25) not null,    
member_name varchar(25) not null,
friend_age int
);

# Drop database family;
-- Drop table Payment;