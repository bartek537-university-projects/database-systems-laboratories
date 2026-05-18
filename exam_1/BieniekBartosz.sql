-- Zadanie 1.
CREATE DATABASE Restauracja;
USE Restauracja;

-- Zadanie 2.
CREATE TABLE KartaDan
(
    iddania    INT AUTO_INCREMENT,
    nazwadania VARCHAR(25)                                                                                NOT NULL,
    kategoria  ENUM ('Przystawki', 'Dania Główne', 'Desery', 'Napoje Bezalkoholowe', 'Napoje Alkoholowe') NOT NULL,
    cena       DECIMAL(4, 2) UNSIGNED,

    PRIMARY KEY (iddania)
);

-- Zadanie 3.
INSERT INTO KartaDan(iddania, nazwadania, kategoria, cena)
VALUES (1, 'Bruschetta z pomidorami', 'Przystawki', 16.00),
       (2, 'Kurczak w sosie curry', 'Dania Główne', 34.50),
       (3, 'Sernik z malinami', 'Desery', 18.00),
       (4, 'Woda mineralna', 'Napoje Bezalkoholowe', 6.00),
       (5, 'Latte', 'Napoje Bezalkoholowe', 12.00),
       (6, 'Czerwone wino (kieliszek)', 'Napoje Alkoholowe', 15.00);

-- Zadanie 4.
CREATE TABLE Zamowienia
(
    idzamowienia INT AUTO_INCREMENT,
    iddania      INT                           NOT NULL,
    nrstolika    TINYINT                       NOT NULL CHECK (nrstolika BETWEEN 1 AND 12),
    status       ENUM ('otwarte', 'zamknięte') NOT NULL,

    PRIMARY KEY (idzamowienia),
    FOREIGN KEY (iddania) REFERENCES KartaDan (iddania)
);

-- Zadanie 5.
INSERT INTO Zamowienia (idzamowienia, iddania, nrstolika, status)
VALUES (1, 1, 7, 'otwarte'),
       (2, 2, 7, 'otwarte'),
       (3, 6, 7, 'otwarte'),
       (4, 3, 3, 'zamknięte'),
       (5, 5, 3, 'zamknięte');

-- Zadanie 6.
UPDATE KartaDan
SET cena = 0.9 * cena
WHERE kategoria = 'Napoje Bezalkoholowe';

-- Zadanie 7.
DELETE
FROM KartaDan
WHERE nazwadania = 'Woda mineralna';

-- W przypadku, gdy będziemy chcieli usunąć rekord o nazwie 'Czerwone wino (kieliszek)',
-- zostanie wygenerowany komunikat o błędzie. Wynika to z faktu, że w tabeli `Zamowienia`
-- istnieje zamówienie, które odnosi się do tego dania.

-- Zadanie 8.
ALTER TABLE Zamowienia
    DROP COLUMN status;

-- Zadanie 9.
DROP DATABASE Restauracja;

-- Zadanie 10.
USE world;

SELECT Name Kraj
FROM country
WHERE Continent = 'Europe'
  AND Population > 20000000
  AND SurfaceArea > 200000;

-- Zadanie 11.
SELECT Name Miasto
FROM city
WHERE Name like 'T%'
  AND District = '';

-- Zadanie 12.
SELECT Name Kraj
FROM country
WHERE Continent = 'South America'
  AND LENGTH(Name) > 7
  AND RIGHT(Name, 1) = 'a';

-- Zadanie 13.
SELECT Name Nazwa
FROM country
WHERE Name LIKE 'S%'
UNION
SELECT Name
FROM city
WHERE Name LIKE 'S%';

-- Zadanie 14.
SELECT Continent,
       SUM(Population)
FROM country
GROUP BY Continent
HAVING SUM(Population) > 1e9;

-- Zadanie 15.
SELECT Region,
       AVG(LifeExpectancy)
FROM country
GROUP BY Region
HAVING AVG(LifeExpectancy) > 75;

-- Zadanie 16.
SELECT i.Name Miasto,
       o.Name Kraj
FROM city i
         JOIN country o ON i.CountryCode = o.Code
WHERE o.Continent = 'Asia'
  AND o.Population > 1e8;

-- Zadanie 17.
SELECT i.Name Miasto
FROM city i
         JOIN country o ON i.CountryCode = o.Code
WHERE i.Name LIKE 'X%'
  AND o.Population > 2e8;

-- Zadanie 18.
SELECT i.Name Miasto
FROM city i
WHERE i.Population > (SELECT AVG(Population) FROM city WHERE CountryCode = i.CountryCode)
ORDER BY i.Name
LIMIT 10;

-- Zadanie 19.
SELECT o.Name Kraj
FROM country o
WHERE 7000000 < ANY (SELECT city.Population FROM city WHERE CountryCode = o.Code);

-- Zadanie 20.
SELECT Name Kraj
FROM country
WHERE Population > ANY
      (SELECT io.Population
       FROM countrylanguage il
                JOIN country io ON il.CountryCode = io.Code
       WHERE il.Language = 'Spanish'
         AND il.IsOfficial = 'T')
ORDER BY Name DESC
LIMIT 10;
