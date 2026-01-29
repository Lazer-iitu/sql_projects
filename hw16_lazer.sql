USE world;
DROP INDEX idx_continent ON country;

CREATE INDEX idx_continent
ON country(continent);

SELECT * 
FROM country
WHERE continent LIKE 'A%';

-- before 0.00067 sec / 0.000032 sec
-- after 0.0011 sec / 0.000028 sec
-- LAZER

