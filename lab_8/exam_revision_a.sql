# Zadanie 1.
CREATE DATABASE Biblioteka;
USE Biblioteka;

# Zadanie 2.
CREATE TABLE Ksiazki
(
    idksiazki INT AUTO_INCREMENT,
    tytul     VARCHAR(60)                                                               NOT NULL,
    autor     VARCHAR(50)                                                               NOT NULL,
    gatunek   ENUM ('Kryminał', 'Fantastyka', 'Romans', 'Historia', 'Popularnonaukowa') NOT NULL,
    rok       SMALLINT(6),
    cena      DECIMAL(4, 2) UNSIGNED,
    PRIMARY KEY (idksiazki)
);

# Zadanie 3.
INSERT INTO Ksiazki(idksiazki, tytul, autor, gatunek, rok, cena)
VALUES (1, 'Wiedźmin', 'Andrzej Sapkowski', 'Fantastyka', 1993, 5.00),
       (2, 'Zbronia i kara', 'Fiodor Dostojewski', 'Kryminał', 1866, 4.50),
       (3, 'Ogniem i mieczem', 'Henryk Sienkiewicz', 'Historia', 1884, 4.00),
       (4, 'Krótka historia czasu', 'Stephen Hawking', 'Popularnonaukowa', 1988, 6.00),
       (5, 'Duma i uprzedzenie', 'Jane Austen', 'Romans', 1813, 3.50),
       (6, 'Solaris', 'Stanisław Lem', 'Fantastyka', 1961, 5.50);

# Zadanie 4.
CREATE TABLE Wypozyczenia
(
    idwypozyczenia    INT AUTO_INCREMENT,
    idksiazki         INT                         NOT NULL,
    imie_nazwisko     VARCHAR(60)                 NOT NULL,
    data_wypozyczenia DATE DEFAULT (CURRENT_DATE) NOT NULL,
    data_zwrotu       DATE,
    PRIMARY KEY (idwypozyczenia),
    FOREIGN KEY (idksiazki) REFERENCES Ksiazki (idksiazki)
);

# Zadanie 5.
INSERT INTO Wypozyczenia(idwypozyczenia, idksiazki, imie_nazwisko, data_wypozyczenia, data_zwrotu)
VALUES (1, 1, 'Jan Kowalski', '2024-03-01', '2024-03-15'),
       (2, 3, 'Anna Nowak', '2024-03-05', NULL),
       (3, 2, 'Piotr Wiśniewski', '2024-03-10', NULL),
       (4, 6, 'Jan Kowalski', '2024-03-12', '2024-03-20'),
       (5, 4, 'Maria Zielińska', '2024-03-14', NULL);

# Zadanie 6.
UPDATE Ksiazki
SET cena = cena * 1.2
WHERE gatunek = 'Fantastyka';

# Zadanie 7.
DELETE
FROM Ksiazki
WHERE tytul = 'Duma i uprzedzenie';
# W tabeli Wypozyczenia zdefiniowano klucz obcy, odwołujący się do tabeli Ksiazki.
# Z tego powodu, gdy będziemy chcieli usunąć książkę, do której istnieją odwołania w wypożyczeniach,
# zostanie wygenerowany komunikat o błędzie. Tak się właśnie stanie w przypadku próby usunięcia rekordu 'Wiedźmin'.

# Zadanie 8.
ALTER TABLE Wypozyczenia
    ADD COLUMN przedluzone BOOLEAN DEFAULT FALSE;

# Zadanie 9.
DROP DATABASE Biblioteka;

USE world;

# Zadanie 10.
SELECT Name Kraj
FROM country
WHERE Continent = 'Europe'
  AND SurfaceArea < 1000
  AND Population > 10000;

# Zadanie 11.
SELECT Name Miasto, Population
FROM city
WHERE Name LIKE '%ville'
  AND (Population IS NULL OR Population = 0);

# Zadanie 12.
SELECT Name Kraj
FROM country
WHERE Continent = 'Africa'
  AND LENGTH(Name) = 7
  AND BINARY Name LIKE 'S%';

# Zadanie 13.
SELECT Name Nazwa
FROM (SELECT Name
      FROM country
      UNION
      SELECT Name
      FROM city) Names
WHERE Name LIKE 'P%'
ORDER BY Name;

# Zadanie 14.
SELECT Continent,
       COUNT(*) LiczbaKrajow
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

# Zadanie 15.
SELECT Region          Region,
       MAX(Population) MaxPopulacja
FROM country
GROUP BY Region
HAVING MAX(Population) > 100000000;

# Zadanie 16.
SELECT i.Name Miasto,
       o.Name Kraj
FROM city i
         JOIN country o ON o.Code = i.CountryCode
WHERE o.Continent = 'South America'
  AND o.Population <> 0
  AND o.GNP * 1000000 / o.Population > 3000;

# Zadanie 17.
SELECT o.Name     Kraj,
       l.Language Jezyk
FROM country o
         JOIN countrylanguage l ON l.IsOfficial = 'T' AND l.CountryCode = o.Code
WHERE o.Continent = 'Asia';

# Zadanie 18.
SELECT o.Name Kraj
FROM country o
WHERE o.Population > (SELECT AVG(io.Population) FROM country io WHERE io.Continent = o.Continent)
ORDER BY o.Population DESC
LIMIT 10;

# Zadanie 19.
SELECT o.Name Kraj
FROM country o
WHERE NOT EXISTS(SELECT ii.ID FROM city ii WHERE ii.CountryCode = o.Code);

# Zadanie 20.
SELECT o.Name Kraj
FROM country o
WHERE o.LifeExpectancy > ALL
      (SELECT io.LifeExpectancy
       FROM country io
       WHERE io.Continent = 'Africa'
         AND io.LifeExpectancy IS NOT NULL)
ORDER BY o.LifeExpectancy;