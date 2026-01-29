/* 1. Объединение сотрудников и менеджеров: Напишите запрос, который использует UNION для объединения списка всех сотрудников (мужчин) 
и всех менеджеров (только идентификаторы сотрудников emp_no).*/
SELECT emp_no
FROM employees
WHERE gender = 'M'
UNION
SELECT emp_no
FROM dept_manager

/* 2. Список уникальных должностей и отделов: Создайте запрос, который объединяет уникальные названия должностей из таблицы titles и 
названия отделов из departments.*/
SELECT DISTINCT title AS unique_name
FROM titles
UNION
SELECT DISTINCT dept_name AS unique_name
FROM departments;

/* 3. Сотрудники с зарплатами выше и ниже среднего: Напишите запрос, который использует UNION для объединения двух списков: 
сотрудников с зарплатой выше 60.000 долларов и сотрудников с зарплатой ниже 40.000 долларов (используйте имя и зарплату).*/
SELECT e.first_name, s.salary
FROM employees e JOIN salaries s ON e.emp_no =s.emp_no
WHERE s.salary > 60000
UNION
SELECT e.first_name, s.salary
FROM employees e JOIN salaries s ON e.emp_no =s.emp_no
WHERE s.salary <  40000

/* 4. Объединение текущих и бывших сотрудников: Используйте UNION для создания списка сотрудников, которые в настоящее время работают в компании, 
и тех, кто уже ушел (используйте имя, фамилию и статус 'Текущий' или 'Бывший' , то есть first_name, last_name, 'Текущий' AS status, 'Бывший' AS status ).*/
SELECT e.first_name, e.last_name, 'Текущий' AS status
FROM employees e JOIN dept_emp d ON e.emp_no = d.emp_no
WHERE d.to_date = '9999-01-01'
UNION
SELECT e.first_name, e.last_name, 'Бывший' AS status
FROM employees e
JOIN dept_emp d ON e.emp_no = d.emp_no
WHERE d.to_date <> '9999-01-01';

/* 5. Сравнение зарплат менеджеров и обычных сотрудников: Создайте запрос с использованием UNION, 
чтобы сравнить средние зарплаты менеджеров и обычных сотрудников (выведите тип сотрудника, 
либо Менеджер, либо Обычный сотрудник их среднюю зарплату, то есть 'Менеджер' AS type, 'Обычный сотрудник' AS type, AVG(salary) AS avg_salary ).*/
SELECT 'Менеджер' AS type, AVG(salary) AS avg_salary 
FROM titles t
JOIN salaries s ON s.emp_no = t.emp_no
WHERE title = 'Manager'
UNION 
SELECT 'Обычный сотрудник' AS type, AVG(salary) AS avg_salary 
FROM titles t
JOIN salaries s ON s.emp_no = t.emp_no
WHERE title <> 'Manager';

