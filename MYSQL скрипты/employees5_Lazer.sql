# 1. Условный оператор IF. Если работает более 30 лет, cтатус будет "Veteran Employee", в противном случае - "New Employee".
USE Employees;
SELECT emp_no, first_name, 
IF(TIMESTAMPDIFF(YEAR, hire_date, CURDATE())>30,"Veteran Employee","New Employee") AS emp_status
FROM employees;

# 2. Условный оператор IF. Если возраст превышает 63 года статус "Пенсионер", в противном случае - "Активный сотрудник".
SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS Age, 
IF(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())>63,"Пенсионер","Активный сотрудник") AS Status
FROM employees;

# 3. CASE WHEN. "Молодой" - младше 30 лет, "средний" - от 30 до 50 лет, "старший" - старше 50 лет.

SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS Age, 
CASE
	WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE())<30 THEN "молодой"
    WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 30 AND 50 THEN "средний"
    ELSE "старший"
END AS Status
FROM employees;

# 4.REGEXP. Сотрудники чьи имена начинаются на букву 'A' или 'B'.
SELECT * FROM employees
WHERE first_name REGEXP '^(A|B)';

# 5. IFNULL
USE Trainingdb;
SELECT first_name, department_id, IFNULL(salary, "UNKNOWN") 
FROM Employees;

# 6. COALESCE 
SELECT COALESCE(salary, default_salary, 25000) AS Salary
FROM Employees;

