#1. Клиенты без пропусков
WITH continuous_clients AS (
    SELECT id_client
    FROM transactions
    WHERE date_new >='2015-06-01' AND date_new <'2016-06-01'
    GROUP BY id_client
    HAVING COUNT(DISTINCT DATE_FORMAT(date_new,'%Y-%m'))=12
)SELECT t.id_client,
    COUNT(*) AS total_operations,
    AVG(t.sum_payment) AS avg_check_year,
    SUM(t.sum_payment) / 12 AS avg_monthly_amount
FROM transactions t
JOIN continuous_clients c ON t.id_client = c.id_client
WHERE t.date_new >='2015-06-01' AND t.date_new<'2016-06-01'
GROUP BY t.id_client;


#2.a Средняя сумма чека в месяц
SELECT DATE_FORMAT(date_new, '%Y-%m') AS month, AVG(sum_payment) AS avg_check_month
FROM transactions
WHERE date_new>='2015-06-01' AND date_new<'2016-06-01'
GROUP BY month;

#2.b Среднее количество операций в месяц
SELECT DATE_FORMAT(date_new, '%Y-%m') AS month, COUNT(*) AS operations_count
FROM transactions
WHERE date_new >='2015-06-01' AND date_new<'2016-06-01'
GROUP BY month;

#2.c Среднее количество клиентов с операциями
SELECT DATE_FORMAT(date_new, '%Y-%m') AS month, COUNT(DISTINCT id_client) AS active_clients
FROM transactions
WHERE date_new>='2015-06-01' AND date_new<'2016-06-01'
GROUP BY month;

#2.d Доля операций и доля суммы
WITH year_totals AS (
    SELECT COUNT(*) AS total_ops_year, SUM(sum_payment) AS total_amount_year
    FROM transactions
    WHERE date_new>='2015-06-01' AND date_new<'2016-06-01'
),
monthly_stats AS (
    SELECT DATE_FORMAT(date_new,'%Y-%m') AS month, COUNT(*) AS ops_month, SUM(sum_payment) AS amount_month
    FROM transactions
    WHERE date_new >='2015-06-01' AND date_new<'2016-06-01'
    GROUP BY month
)
SELECT m.month,
    m.ops_month / y.total_ops_year AS ops_share_of_year,
    m.amount_month / y.total_amount_year AS amount_share_of_year
FROM monthly_stats m
CROSS JOIN year_totals y
ORDER BY m.month;


#2.e % соотношение M/F/NA в каждом месяце с их долей затрат
SELECT DATE_FORMAT(t.date_new, '%Y-%m') AS month, COALESCE(c.gender, 'NA') AS gender, COUNT(*) AS ops_count,
    SUM(t.sum_payment) AS total_amount,
    SUM(t.sum_payment)/SUM(SUM(t.sum_payment)) OVER (PARTITION BY DATE_FORMAT(t.date_new,'%Y-%m'))* 100 AS amount_share_pct
FROM transactions t
JOIN customer c ON t.id_client =c.id_client
WHERE t.date_new>= '2015-06-01' AND t.date_new<'2016-06-01'
GROUP BY month,gender;

#3 Возрастные группы шаг 10 лет
SELECT age_group, COUNT(*) AS ops_count, SUM(sum_payment) AS total_amount
FROM (SELECT t.sum_payment,
        CASE
            WHEN c.age IS NULL THEN 'NA'
            WHEN c.age <10 THEN '0-9'
            WHEN c.age < 20 THEN '10-19'
            WHEN c.age< 30 THEN '20-29'
            WHEN c.age <40 THEN '30-39'
            WHEN c.age < 50 THEN '40-49'
            WHEN c.age <60 THEN '50-59'
            ELSE '60+'
        END AS age_group
    FROM transactions t
    JOIN customer c ON t.id_client = c.id_client
    WHERE t.date_new>= '2015-06-01' AND t.date_new < '2016-06-01'
) x
GROUP BY age_group;

#3 Поквартально - средние показатели и %
SELECT CONCAT(YEAR(date_new), '-Q', QUARTER(date_new)) AS quarter, age_group,
    AVG(sum_payment) AS avg_check, COUNT(*) AS ops_count,
    COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY CONCAT(YEAR(date_new),'-Q',QUARTER(date_new))) * 100 AS ops_share_pct
FROM (SELECT t.date_new, t.sum_payment,
        CASE
			WHEN c.age IS NULL THEN 'NA'
            WHEN c.age <10 THEN '0-9'
            WHEN c.age < 20 THEN '10-19'
            WHEN c.age< 30 THEN '20-29'
            WHEN c.age <40 THEN '30-39'
            WHEN c.age < 50 THEN '40-49'
            WHEN c.age <60 THEN '50-59'
            ELSE '60+'
        END AS age_group
    FROM transactions t
    JOIN customer c ON t.id_client = c.id_client
) q
GROUP BY quarter, age_group;