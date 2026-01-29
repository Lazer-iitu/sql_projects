USE TrainingDB;
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    balance INT
);

INSERT INTO accounts (id, balance) VALUES (1, 1000);
INSERT INTO accounts (id, balance) VALUES (2, 1500);
INSERT INTO accounts (id, balance) VALUES (3, 2000);

SET autocommit = 0;

-- READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

UPDATE accounts
SET balance = 2000
WHERE id = 1; -- 1. Пока транзакция открыта, изменения не сохранены, запускаем второй сеанс

ROLLBACK; -- 3. Вернем в исходную пощицию

-- READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

UPDATE accounts
SET balance = 2000
WHERE id = 1;

SELECT * FROM accounts WHERE id = 1; -- 1. не сделали COMMIT и проверим. у нас balance = 2000 

COMMIT; -- 3. фиксируем изменения

