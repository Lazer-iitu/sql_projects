#Данные из таблицы employees
SELECT * FROM employees;

# Список мужчин из таблицы employees
SELECT * FROM employees
WHERE Gender = 'M';

# Cотрудники по имени Elvis
SELECT * FROM employees
WHERE first_name = 'Elvis';
# c like также
SELECT * FROM employees
WHERE first_name LIKE 'Elvis';

# Уникальные названия должностей
SELECT DISTINCT t.title AS 'Unique title' FROM titles t ;

# Сотрудники кто был трудоустроен в 2000 году 
SELECT * FROM employees e
WHERE YEAR(e.hire_date)=2000;

# Сотрудники кому за  60 лет 
SELECT e.*, TIMESTAMPDIFF(YEAR, e.birth_date, CURDATE()) AS AGE FROM employees e
WHERE TIMESTAMPDIFF(YEAR, e.birth_date, CURDATE())>60;

# Количество строк в таблице salaries
SELECT COUNT(*) AS "Salary count" FROM salaries;

# Количество сотрудников у кого зарплата > 100.000$
SELECT COUNT(*) AS "High salary" FROM salaries
WHERE salary>100000;