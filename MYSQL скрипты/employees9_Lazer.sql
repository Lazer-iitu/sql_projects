# 1. Найдите всех сотрудников, которые работали как минимум в 2 департаментах. Вывести их имя и фамилию. Показать записи в порядке возрастания.
SELECT first_name, last_name
FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_emp GROUP BY emp_no HAVING COUNT(DISTINCT dept_no)>1)
ORDER BY first_name, last_name;

# 2. Вывести имя, фамилию и зарплату самого высокооплачиваемого сотрудника.
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE s.salary = (SELECT MAX(salary) FROM salaries);

# 3. Создайте запрос, который выбирает названия всех отделов, в которых работает более 100 сотрудников.
SELECT dept_name
FROM departments
WHERE dept_no IN (SELECT dept_no FROM dept_emp GROUP BY dept_no HAVING COUNT(dept_no)>100)

# 4. Напишите запрос, который находит имена и фамилии всех сотрудников, которые никогда не были менеджерами.
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no NOT IN (SELECT emp_no FROM dept_manager);

# 5. Создайте запрос, который для каждого отдела выводит сотрудников, получающих наибольшую зарплату в этом отделе.
SELECT de.dept_no, s.salary, s.emp_no
FROM dept_emp de
JOIN salaries s 
ON de.emp_no = s.emp_no
WHERE s.salary = ( SELECT MAX(s2.salary) FROM dept_emp de2 JOIN salaries s2 ON de2.emp_no = s2.emp_no WHERE de2.dept_no = de.dept_no);

# 6. Напишите запрос, который выбирает названия отделов, где средняя зарплата выше общей средней зарплаты по компании.
SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM departments d 
JOIN dept_emp de 
ON de.dept_no = d.dept_no 
JOIN salaries s 
ON s.emp_no = de.emp_no
GROUP BY d.dept_name
HAVING avg_salary > (SELECT AVG(salary) FROM salaries);