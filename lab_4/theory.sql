USE world;

# IS NULL

SELECT c.Name, c.GNPOld
FROM country c
WHERE c.GNPOld IS NULL;
# WHERE c.GNPOld = NULL;
# WHERE c.GNPOld = "NULL";
# WHERE c.GNPOld = "0";

# Operacje na NULL

SELECT NULL * 10, NULL + 5, SQRT(NULL); -- NULL, NULL, NULL
SELECT 3 / 0, SQRT(-2); -- NULL, NULL

# IFNULL

SELECT c.Name, IFNULL(c.GNPOld, 'Nieznane')
FROM country c
LIMIT 10;

USE friend;

CREATE TABLE orders
(
    date_when      DATE      NOT NULL,
    datetime_when  DATETIME  NOT NULL,
    time_when      TIME      NOT NULL,
    # DEFAULT CURRENT_TIMESTAMP
    timestamp_when TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO orders VALUE ('2026.03-25', '2026:03%25 10/13:35', '10:13:35', '2026@03$25 10.13^45');

ALTER TABLE orders
    MODIFY timestamp_when TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

INSERT INTO orders(date_when, datetime_when, time_when) VALUE ('2026.03-25', '2026:03%25 10/13:35', '10:13:35');

SELECT *
FROM orders;

# NOW

SELECT NOW();

# DATE_FORMAT, TIME_FORMAT

SELECT DATE_FORMAT(o.timestamp_when, '%M %d, %y at %h:%i:%s %p'),
       TIME_FORMAT(o.timestamp_when, '%M %d, %y at %h:%i:%s %p')
FROM orders o
LIMIT 1;

# YEAR, MONTH, DAY
# MINUTE, HOUR, SECOND

WITH t AS (SELECT NOW() n)
SELECT YEAR(n), MONTH(n), DAY(n), HOUR(n), MINUTE(n), SECOND(n)
FROM t;

USE world;

# CONCAT

SELECT CONCAT('Państwem ', c.Name, ' rządzi ', c.HeadOfState, '.')
FROM country c
WHERE c.Name LIKE 'P%'
ORDER BY c.HeadOfState;

# LENGTH
# LEFT, RIGHT
# UPPER, LOWER

SELECT LENGTH('polska gurom'); -- 12
SELECT CONCAT('polska', ' ', 'gurom'); -- 'polska gurom'
SELECT LEFT('myszojeleń', 5), RIGHT('myszojeleń', 5); -- 'myszo', 'jeleń'
SELECT SUBSTR('zielonydywanlatający', 8, 5);
SELECT SUBSTR('zielonydywanlatający', 8);
SELECT UPPER('John'), LOWER('Pork');
SELECT LTRIM('    w z i    uuu m     '), RTRIM('    w z i    uuu m     ');
SELECT TRIM('    w z i    uuu m     ');

# IF

SELECT IF(2 + 4 = 6, 'To prawda', 'To nieprawda');


