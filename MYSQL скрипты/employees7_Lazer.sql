/* 1. Выведите список всех менеджеров, а именно их emp_no, имена/фамилии, номер департамента, который они курируют, 
и дату найма в компанию. (именно менеджером, то есть подсказка dept_manager)*/
SELECT e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM employees e
JOIN dept_manager d
ON e.emp_no = d.emp_no;

/* 2. Существует ли сотрудник по фамилии Markovitch, который когда-то был менеджером департамента. 
Может быть таких сотрудников несколько? (именно менеджером, то есть подсказка dept_manager)*/
SELECT *
FROM employees e
JOIN dept_manager d
ON e.emp_no = d.emp_no
WHERE e.last_name = "Markovitch";

# 3. Вывести список сотрудников, имена/фамилии, дату найма, должность в компании, у которых имя начинается на М, а фамилия заканчивается на H.
SELECT e.first_name, e.last_name, t.title, e.hire_date
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
WHERE e.first_name LIKE 'M%' AND e.last_name LIKE '%H';

/* 4. Создайте временную таблицу на основе salaries, где у вас будет emp_no и его/ее максимальная и минимальная зарплата за весь период работы в компании. 
Далее сделайте JOIN используя эту временную таблицу и таблицу employees чтобы получить список сотрудников, их имена/фамилии, и их мин/макс зарплат.*/
CREATE TEMPORARY TABLE salary1 AS
SELECT emp_no, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM salaries
GROUP BY emp_no;

SELECT e.first_name, e.last_name, s.max_salary, s.min_salary
FROM employees e
JOIN salary1 s
ON e.emp_no = s.emp_no;
