DESCRIBE phone;

CREATE TABLE phone_copy
(
    number  CHAR(9) NOT NULL,
    carrier ENUM ('tp', 'era', 'heyah')
);

ALTER TABLE phone_copy
    MODIFY carrier ENUM ('tp', 'era', 'heyhah', 'orange') NOT NULL;
-- W poleceniu CHANGE możemy też zmienić nazwę kolumny.

DESCRIBE phone_copy;

INSERT INTO phone_copy
SELECT number, carrier
from phone;

SELECT *
FROM phone_copy;

ALTER TABLE phone_copy
    ADD PRIMARY KEY (number);

ALTER TABLE phone_copy
    ADD COLUMN price DOUBLE UNSIGNED CHECK ( price > 0.0 AND price < 20.0 );
ALTER TABLE phone_copy
    ADD COLUMN phone_id TINYINT UNSIGNED NOT NULL;

ALTER TABLE phone_copy
    CHANGE phone_id id TINYINT UNSIGNED NOT NULL;

ALTER TABLE phone_copy
    DROP COLUMN price;
ALTER TABLE phone_copy
    DROP COLUMN phone_id;

DESCRIBE phone_copy;
SELECT *
FROM phone_copy;

SELECT *
FROM phone_copy;

# ALTER TABLE phone_copy
#     ADD CONSTRAINT FK_Phone PRIMARY KEY (number);
# ALTER TABLE phone_copy
#     ADD CONSTRAINT FK_Phone FOREIGN KEY (number) REFERENCES phone (number);
# ALTER TABLE phone_copy
#     DROP FOREIGN KEY FK_Phone;

ALTER TABLE phone_copy
    ADD CONSTRAINT pk_phone_copy PRIMARY KEY (phone_id);
-- Wskazujemy własną nazwę constraint.

DROP TABLE phone_copy;

CREATE TABLE test
(
    test_id TINYINT NOT NULL
);

ALTER TABLE test
    ALTER test_id SET DEFAULT 10;
INSERT INTO test
VALUES (),
       ();
SELECT *
FROM test;
ALTER TABLE test
    ALTER test_id DROP DEFAULT;
ALTER TABLE test
    RENAME test_table;

DELETE
FROM test_table
WHERE TRUE;
ALTER TABLE test_table
    ADD PRIMARY KEY (test_id);
ALTER TABLE test_table
    MODIFY test_id TINYINT NOT NULL AUTO_INCREMENT;
ALTER TABLE test_table
    AUTO_INCREMENT 20;
INSERT INTO test_table
VALUES (),
       ();
UPDATE test_table
SET test_id = test_id - 10;
SELECT *
FROM test_table;

DELETE
FROM test_table
WHERE test_id = 0;

ALTER TABLE test_table
    ADD COLUMN number INT;

INSERT INTO test_table
    VALUE (78, 12);

SHOW CREATE TABLE test_table;


-- Zadanie 1.
CREATE TABLE test
(
    test_id TINYINT NOT NULL
);
DESCRIBE test;

ALTER TABLE test
    ADD COLUMN letter CHAR(3) NOT NULL AFTER test_id;
INSERT INTO test
VALUES (1, 'a'),
       (1, 'b');
ALTER TABLE test
    ADD PRIMARY KEY (test_id);
-- Duplicate entry '1' for key 'test.PRIMARY'
-- Nie można utworzyć klucza głównego na kolumnie, w której powtarzają się dane.
DROP TABLE test;


