-- 1. Определение наивысшей текущей зарплаты в каждом отделе (для подсчета текущей зарплаты, используем фильтр WHERE to_date = '9999-01-01')
SELECT s.emp_no, s.salary, d.dept_no, MAX(s.salary) OVER (PARTITION BY d.dept_no) as max_salary_in_dept
FROM salaries s JOIN dept_emp d ON s.emp_no = d.emp_no
WHERE s.to_date = '9999-01-01';

-- 2. Сравнение зарплаты каждого сотрудника с средней зарплатой в их отделе
SELECT s.emp_no, s.salary, d.dept_no, AVG(s.salary) OVER (PARTITION BY d.dept_no) as avg_salary_in_dept
FROM salaries s JOIN dept_emp d ON s.emp_no = d.emp_no;

-- 3. Ранжирование сотрудников в отделе по стажу работы
SELECT e.emp_no, e.hire_date, d.dept_no, DENSE_RANK() OVER (PARTITION BY d.dept_no ORDER BY hire_date) as experience_rank
FROM employees e JOIN dept_emp d ON e.emp_no = d.emp_no;

-- 4.Нахождение следующей должности каждого сотрудника
SELECT emp_no, title, LEAD(title, 1, 'UNKNOWn') OVER (PARTITION BY emp_no ORDER BY from_date) AS next_title
FROM titles;

-- 5. Определение начальной и последней зарплаты сотрудника:
SELECT emp_no, salary, 
FIRST_VALUE(salary) OVER (PARTITION BY emp_no ORDER BY salary) AS first_salary, 
LAST_VALUE(salary) OVER (PARTITION BY emp_no) AS last_salary
FROM salaries;

-- 6. - Цель: Вычислить скользящее среднее зарплаты для каждого сотрудника, основываясь на его последних трех зарплатах.
SELECT emp_no, from_date, salary, 
AVG(salary) OVER (PARTITION BY emp_no ORDER BY from_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM salaries;
