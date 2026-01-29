# 1. Найдите количество сотрудников мужского пола (M) и женского пола (F) и выведите записи в порядке убывания по количеству сотрудников.
SELECT gender, COUNT(gender) AS count
FROM employees
GROUP BY gender
ORDER BY count DESC;

/* 2. Найдите среднюю зарплату в разрезе должностей сотрудников (title), округлите эти средние зарплаты до 2 знаков после запятой и 
      выведите записи в порядке убывания.*/
SELECT title, ROUND(AVG(salary),2) AS title_salary
FROM salaries s
JOIN titles t 
ON s.emp_no = t.emp_no
GROUP BY title
ORDER BY title_salary DESC;

# 3. Вывести месяцы (от 1 до 12), и количество нанятых сотрудников в эти месяцы.
SELECT MONTH(hire_date) as hire_month, COUNT(hire_date)
FROM employees
GROUP BY hire_month
ORDER BY hire_month;

/* 4.  Сформируйте запрос, который соединяет employees, dept_emp, departments и titles, чтобы показать имена и фамилии сотрудников, 
       названия их отделов и их текущие должности (именно текущие должности, то есть фильтр по таблице titles, столбец to_date).*/
SELECT e.first_name, e.last_name, d.dept_name, t.title
FROM employees e 
JOIN titles t
ON e.emp_no = t.emp_no
JOIN dept_emp de 
ON t.emp_no = de.emp_no
JOIN departments d 
ON de.dept_no = d.dept_no 
WHERE t.to_date =  '9999-01-01';

# 5. Используйте Self JOIN в таблице employees, чтобы найти пары сотрудников с одинаковыми фамилиями. Отобразите их имена и фамилии.
SELECT e1.first_name AS "1 First Name", e1.last_name AS "1 Last Name", e2.first_name AS "2 First Name", e2.last_name AS  "2 Last Name"
FROM employees e1
JOIN employees e2
ON e1.last_name = e2.last_name AND e1.emp_no < e2.emp_no;
