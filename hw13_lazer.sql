Use final_project;
CREATE TABLE uk_bank(
customer_id INT PRIMARY KEY,
name VARCHAR(50),
surname VARCHAR(50),
gender VARCHAR(6),
age INT,
region VARCHAR(50),
job_classification VARCHAR(50),
date_joined VARCHAR(50),
balance FLOAT
);

ALTER TABLE uk_bank ADD COLUMN date_joined_date DATE;

UPDATE uk_bank
SET date_joined_date = STR_TO_DATE(date_joined, '%d.%b.%y')
WHERE customer_id > 0;

ALTER TABLE uk_bank DROP COLUMN date_joined;

ALTER TABLE uk_bank 
CHANGE COLUMN date_joined_date date_joined DATE;

SELECT * FROM uk_bank;