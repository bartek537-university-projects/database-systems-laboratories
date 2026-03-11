SHOW
    DATABASES;

CREATE
    DATABASE friend;
USE
    friend;

SHOW
    TABLES;

CREATE TABLE person
(
    person_id  TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name CHAR(12)         NOT NULL,
    last_name  CHAR(22)         NOT NULL,
    age        TINYINT,
    city       CHAR(33) DEFAULT 'Gliwice',

    PRIMARY KEY (person_id)
);

DESCRIBE person;

CREATE TABLE phone
(
    phone_id TINYINT UNSIGNED                      NOT NULL AUTO_INCREMENT,
    number   CHAR(9)                               NOT NULL,
    type     ENUM ('mobile', 'landline')           NOT NULL DEFAULT 'mobile',
    carrier  ENUM ('tp', 'era', 'heyah', 'orange') NOT NULL,

    PRIMARY KEY (phone_id)
);

-- Nie uda się utworzyć tabelki, która posiada niepoprawną wartość domyślną dla ENUMa.

DESCRIBE phone;

CREATE TABLE person_phone
(
    person_phone_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    person_id       TINYINT UNSIGNED NOT NULL,
    phone_id        TINYINT UNSIGNED NOT NULL,

    PRIMARY KEY (person_phone_id),
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (phone_id) REFERENCES phone (phone_id)
);

DESCRIBE person_phone;

INSERT INTO phone(phone_id, number, type, carrier)
VALUES (3, '123456789', 'mobile', 'orange');

INSERT INTO phone(phone_id, number, type, carrier)
VALUES (0, '123123123', 'landline', 'tp');

INSERT INTO phone(number, carrier)
VALUES ('987987987', 'orange');

-- Ustawienie 0 w polu typu AUTO_INCREMENT spowoduje wpisanie kolejnej wartości.

SELECT *
FROM phone;

INSERT person(first_name, last_name, age, city)
VALUES ('Ewa', 'Żbik', 23, 'Kędzierzyn-Koźle');

INSERT person(first_name, last_name, age, city)
VALUES ('Adam', 'Żubr', 37, 'Łódź'),
       ('Ola', 'Łoś', 7, 'Ełk'),
       ('Jan', 'Bąk', 87, 'Częstochowa');

SELECT *
FROM person;

UPDATE person
SET age = 87
WHERE person_id = 4;