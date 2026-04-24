# Zadanie 1
CREATE DATABASE Bartosz_Bieniek;

USE Bartosz_Bieniek;

# Zadanie 2
CREATE TABLE wypieki
(
    id    INT         NOT NULL AUTO_INCREMENT,
    nazwa ENUM ('chleb', 'bułka', 'chałka'),
    mąka  VARCHAR(20) NOT NULL,
    data  DATETIME,

    PRIMARY KEY (id)
);

DESCRIBE wypieki;
# +-----+------------------------------+----+---+-------+--------------+
# |Field|Type                          |Null|Key|Default|Extra         |
# +-----+------------------------------+----+---+-------+--------------+
# |id   |int                           |NO  |PRI|null   |auto_increment|
# |nazwa|enum('chleb','bułka','chałka')|YES |   |null   |              |
# |mąka |varchar(20)                   |NO  |   |null   |              |
# |data |datetime                      |YES |   |null   |              |
# +-----+------------------------------+----+---+-------+--------------+

# Zadanie 3.
CREATE TABLE t2
(
    co    INT NOT NULL,
    ile   INT,
    gdzie TEXT,

    FOREIGN KEY (co) REFERENCES wypieki (id)
) ENGINE 'innodb';

DESCRIBE t2;
# +-----+----+----+---+-------+-----+
# |Field|Type|Null|Key|Default|Extra|
# +-----+----+----+---+-------+-----+
# |co   |int |NO  |MUL|null   |     |
# |ile  |int |YES |   |null   |     |
# |gdzie|text|YES |   |null   |     |
# +-----+----+----+---+-------+-----+

# Zadanie 4.
INSERT INTO wypieki
VALUES (1, 'bułka', 'pszenna 650', '2017-04-26 7:30:00'),
       (2, 'chałka', 'pszenna 400', SUBDATE(CURRENT_DATE, 1)),
       (3, 'chleb', 'żytnia 750', NOW()),
       (5, 'chleb', 'żytnia 500', NOW());

SELECT *
FROM wypieki;
# +--+------+-----------+-------------------+
# |id|nazwa |mąka       |data               |
# +--+------+-----------+-------------------+
# |1 |bułka |pszenna 650|2017-04-26 07:30:00|
# |2 |chałka|pszenna 400|2026-04-23 00:00:00|
# |3 |chleb |żytnia 750 |2026-04-24 16:12:51|
# |5 |chleb |żytnia 500 |2026-04-24 16:12:51|
# +--+------+-----------+-------------------+

# Zadanie 5.
ALTER TABLE t2
    DROP FOREIGN KEY t2_ibfk_1;

# Zadanie 6.
UPDATE wypieki
SET mąka = 'kukurydziana'
WHERE id >= 3;

SELECT *
FROM wypieki;
# +--+------+------------+-------------------+
# |id|nazwa |mąka        |data               |
# +--+------+------------+-------------------+
# |1 |bułka |pszenna 650 |2017-04-26 07:30:00|
# |2 |chałka|pszenna 400 |2026-04-23 00:00:00|
# |3 |chleb |kukurydziana|2026-04-24 16:12:51|
# |5 |chleb |kukurydziana|2026-04-24 16:12:51|
# +--+------+------------+-------------------+

# Zadanie 7.
ALTER TABLE t2
    DROP COLUMN gdzie;

DESCRIBE t2;
# +-----+----+----+---+-------+-----+
# |Field|Type|Null|Key|Default|Extra|
# +-----+----+----+---+-------+-----+
# |co   |int |NO  |MUL|null   |     |
# |ile  |int |YES |   |null   |     |
# +-----+----+----+---+-------+-----+

# Zadanie 8. (Niemożliwe)
UPDATE wypieki
SET id = 101
WHERE nazwa = 'chleb';
# `id` jest kluczem głównym, a więc znajdujące się w niej wartości nie mogą się powtarzać.
# W tabeli istnieją dwa rekordy o nazwie 'chleb', co doprowadziłoby
# do ustawienia `id` = 101 dla dwóch wpisów - wykonując zapytanie zwrócony zostanie komunikat o błędzie.

# Zadanie 9.
DROP DATABASE Bartosz_Bieniek;

USE world;

# Zadanie 10.
SELECT t.Name        miasto,
       t.Population  ile,
       t.CountryCode kod
FROM city t
WHERE (t.Name LIKE 'U%' OR t.Name LIKE '%x')
  AND (t.Population BETWEEN 600000 AND 2e7)
ORDER BY t.CountryCode, Population DESC;

# Zadanie 11.
SELECT c.GovernmentForm rządy,
       COUNT(*)         ile
FROM country c
WHERE c.GovernmentForm NOT LIKE '% %'
GROUP BY c.GovernmentForm;
# +-------------+-------+---+
# |miasto       |ile    |kod|
# +-------------+-------+---+
# |Urumti [rmqi]|1310100|CHN|
# |Ujung Pandang|1060257|IDN|
# |Ulsan        |1084891|KOR|
# |Ulan Bator   |773700 |MNG|
# |Ufa          |1091200|RUS|
# |Uljanovsk    |667400 |RUS|
# |Phoenix      |1321045|USA|
# +-------------+-------+---+

# Zadanie 12.
SELECT DISTINCT c.GovernmentForm
FROM country c
WHERE c.Continent = 'Oceania';
# +----------------------------------------+
# |GovernmentForm                          |
# +----------------------------------------+
# |US Territory                            |
# |Constitutional Monarchy, Federation     |
# |Territory of Australia                  |
# |Nonmetropolitan Territory of New Zealand|
# |Republic                                |
# |Federal Republic                        |
# |Commonwealth of the US                  |
# |Nonmetropolitan Territory of France     |
# |Constitutional Monarchy                 |
# |Dependent Territory of the UK           |
# |Monarchy                                |
# |Dependent Territory of the US           |
# |Parlementary Monarchy                   |
# +----------------------------------------+

# Zadanie 13.
SELECT c.Region,
       SUM(t.Population)
FROM city t
         JOIN country c ON c.Code = t.CountryCode
GROUP BY c.Region
HAVING SUM(t.Population) > 20e6;
# +-------------------------+-----------------+
# |Region                   |SUM(t.Population)|
# +-------------------------+-----------------+
# |Southern and Central Asia|207688970        |
# |Southern Europe          |40016658         |
# |Middle East              |70371374         |
# |South America            |172037859        |
# |Western Europe           |45683298         |
# |Eastern Africa           |24067066         |
# |Western Africa           |33222032         |
# |Eastern Europe           |123384516        |
# |Central America          |65860964         |
# |North America            |91321867         |
# |Southeast Asia           |102067225        |
# |Eastern Asia             |317476534        |
# |Northern Africa          |43449514         |
# |British Islands          |23045714         |
# +-------------------------+-----------------+

# Zadanie 14.
SELECT c.Name,
       t.Name
FROM country c
         JOIN city t ON t.CountryCode = c.Code
WHERE LEFT(c.Name, 2) = LEFT(t.Name, 2)
  AND RIGHT(c.Name, 2) = RIGHT(t.Name, 2)
  AND c.Name <> t.Name;
# +--------+----------+
# |Name    |Name      |
# +--------+----------+
# |Pakistan|Pak Pattan|
# |Taiwan  |Tainan    |
# |Taiwan  |Taoyuan   |
# +--------+----------+

# Zadanie 15.
SELECT c.Continent,
       COUNT(*)
FROM city t
         JOIN country c ON c.Code = t.CountryCode
GROUP BY c.Continent
HAVING COUNT(*) BETWEEN 100 AND 999;
# +-------------+--------+
# |Continent    |COUNT(*)|
# +-------------+--------+
# |North America|581     |
# |Africa       |366     |
# |Europe       |841     |
# |South America|470     |
# +-------------+--------+

# Zadanie 16.
SELECT c.Name,
       l.Language
FROM country c
         LEFT JOIN countrylanguage l ON l.CountryCode = c.Code
WHERE c.Name LIKE 'H%s';
# +---------------------------------+--------------+
# |Name                             |Language      |
# +---------------------------------+--------------+
# |Heard Island and McDonald Islands|null          |
# |Honduras                         |Creole English|
# |Honduras                         |Garifuna      |
# |Honduras                         |Miskito       |
# |Honduras                         |Spanish       |
# +---------------------------------+--------------+

# Zadanie 17.
SELECT c.Name,
       c.LifeExpectancy
FROM country c
WHERE c.LifeExpectancy >= (SELECT AVG(i.LifeExpectancy) FROM country i) + 14;
# +----------+--------------+
# |Name      |LifeExpectancy|
# +----------+--------------+
# |Andorra   |83.5          |
# |Japan     |80.7          |
# |Macao     |81.6          |
# |San Marino|81.1          |
# +----------+--------------+

# Zadanie 18.
SELECT c.Name,
       t.Name,
       c.GNP
FROM country c
         JOIN city t ON t.Id = c.Capital
WHERE c.GNP >= 10 * (SELECT AVG(i.GNP) FROM country i WHERE i.Continent = c.Continent);
# +-------------+----------+----------+
# |Name         |Name      |GNP       |
# +-------------+----------+----------+
# |Australia    |Canberra  |351182.00 |
# |Germany      |Berlin    |2133367.00|
# |Japan        |Tokyo     |3787042.00|
# |United States|Washington|8510700.00|
# |South Africa |Pretoria  |116729.00 |
# +-------------+----------+----------+

# Zadanie 19.
SELECT c.Name,
       t.Name,
       l.Language
FROM country c
         JOIN city t ON t.ID = c.Capital
         JOIN countrylanguage l ON l.CountryCode = c.Code
WHERE l.IsOfficial = 'T'
  AND c.GovernmentForm IN (SELECT i.GovernmentForm FROM country i WHERE i.Continent = 'Antarctica');
# +------------------------+----------------+---------+
# |Name                    |Name            |Language |
# +------------------------+----------------+---------+
# |Anguilla                |The Valley      |English  |
# |Bermuda                 |Hamilton        |English  |
# |Cocos (Keeling) Islands |West Island     |English  |
# |Christmas Island        |Flying Fish Cove|English  |
# |Cayman Islands          |George Town     |English  |
# |Falkland Islands        |Stanley         |English  |
# |Gibraltar               |Gibraltar       |English  |
# |Montserrat              |Plymouth        |English  |
# |New Caledonia           |Nouma           |French   |
# |Norfolk Island          |Kingston        |English  |
# |French Polynesia        |Papeete         |French   |
# |Saint Helena            |Jamestown       |English  |
# |Svalbard and Jan Mayen  |Longyearbyen    |Norwegian|
# |Turks and Caicos Islands|Cockburn Town   |English  |
# |Virgin Islands, British |Road Town       |English  |
# +------------------------+----------------+---------+

# Zadanie 20.
SELECT c.Name,
       c.Continent
FROM country c
WHERE LENGTH(c.Name) = LENGTH(c.Continent)
  AND LEFT(c.Name, 1) IN (SELECT DISTINCT RIGHT(it.Name, 1)
                          FROM country ic
                                   JOIN city it ON it.ID = ic.Capital
                          WHERE ic.Continent = 'Europe');
# +-------------+-------------+
# |Name         |Continent    |
# +-------------+-------------+
# |Angola       |Africa       |
# |Antarctica   |Antarctica   |
# |Iran         |Asia         |
# |Iraq         |Asia         |
# |Monaco       |Europe       |
# |Malawi       |Africa       |
# |Norway       |Europe       |
# |Oman         |Asia         |
# |Runion       |Africa       |
# |Rwanda       |Africa       |
# |Sweden       |Europe       |
# |Tokelau      |Oceania      |
# |Uganda       |Africa       |
# |United States|North America|
# |Vanuatu      |Oceania      |
# |Zambia       |Africa       |
# +-------------+-------------+