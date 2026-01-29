/*1. Создать процедуру, в которой мы получаем на вход два параметра p_salary, p_dept и на выходе получим:
- Список сотрудников (emp_no, first_name, gender), у которых средняя зарплата больше p_salary и которые когда-то работали в департаменте p_dept.*/
DELIMITER $$
CREATE PROCEDURE salary_dept(
    IN p_salary DECIMAL (10,2),
    IN p_dept VARCHAR(50)
)
BEGIN
    SELECT e.emp_no, e.first_name, e.gender
    FROM employees e 
    JOIN salaries s ON e.emp_no=s.emp_no
    JOIN dept_emp de ON s.emp_no=de.emp_no
    JOIN departments d ON d.dept_no=de.dept_no
    WHERE d.dept_name = p_dept
    GROUP BY e.emp_no, e.first_name, e.gender
    HAVING AVG(s.salary) > p_salary;
END $$
DELIMITER ;

CALL salary_dept( 60000, 'Customer Service');

-- 2. Создать функцию, которая получает на вход f_name и выдает максимальную зарплату среди сотрудников с именем f_name.
DELIMITER $$
CREATE FUNCTION max_salary_byname(f_name VARCHAR(50)) RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE max_salary DECIMAL(10,2);
    SELECT MAX(salary) INTO max_salary
    FROM employees e 
    JOIN salaries s ON e.emp_no=s.emp_no
    WHERE first_name = f_name;
    RETURN max_salary;
END$$
DELIMITER ;

SELECT max_salary_byname('Niclas');

-- 1. Посчитайте количество городов в каждой стране, где IndepYear = 1991 (Independence Year).
USE world;
SELECT co.Name AS country, COUNT(ci.id) AS city_count
FROM city ci 
JOIN country co 
ON ci.CountryCode = co.Code
WHERE IndepYear = 1991
GROUP BY co.Code, co.Name;

-- 2. Узнайте, какая численность населения и средняя продолжительность жизни людей в Аргентине (ARG).
SELECT population, LifeExpectancy
FROM  country 
WHERE Code = 'ARG';

-- 3. В какой стране самая высокая продолжительность жизни?
SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy = (
    SELECT MAX(LifeExpectancy) FROM country );

-- 4. Перечислите все языки, на которых говорят в регионе «Southeast Asia».
SELECT DISTINCT l.language 
FROM country c 
JOIN countrylanguage l 
ON c.code = l.countrycode
WHERE c.region = 'Southeast Asia';

-- 5. Посчитайте сумму SurfaceArea для каждого континента.
SELECT continent, SUM(SurfaceArea) as surface
FROM country
GROUP BY continent;