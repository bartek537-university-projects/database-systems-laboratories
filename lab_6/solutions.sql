USE world;

-- Państwa europejskie oraz ich stolice, z odpowiednimi liczbami mieszkańców.
SELECT c.Name       country_name,
       t.Name       city_name,
       c.Population country_population,
       t.Population city_population
FROM country c
         JOIN city t ON c.Capital = t.ID
WHERE Continent = 'Europe';

-- Miasto Europy o największej liczbie mieszkańców.
SELECT t.Name, t.Population
FROM city t
         JOIN country c ON t.CountryCode = c.Code
WHERE c.Continent = 'Europe'
ORDER BY t.Population DESC
LIMIT 1;

-- Populacje największych miast na każdym kontynencie
SELECT c.Continent,
       MAX(t.Population) highest_city_population
FROM country c
         JOIN city t ON t.CountryCode = c.Code
GROUP BY c.Continent;

-- Ilość miast na każdym kontynencie.
SELECT c.Continent,
       COUNT(*) city_count
FROM country c
         JOIN city t ON t.CountryCode = c.Code
GROUP BY c.Continent;

-- Nazwy stolic pokrywające się z nazwą państwa.
SELECT t.Name
FROM city t
         JOIN country c ON c.Code = t.CountryCode
WHERE c.Name = t.Name;

-- Nazwy państw, w których występują języki o takiej samej nazwie.
SELECT c.Name, l.Language
FROM country c
         LEFT JOIN countrylanguage l ON l.CountryCode = c.Code
WHERE c.Name = l.Language
   OR l.Language IS NULL;

-- Miasta, w których mówi się w języku polskim.
SELECT t.Name city_name, t.District
FROM city t
         LEFT JOIN countrylanguage l ON l.CountryCode = t.CountryCode
WHERE l.Language = 'Polish'
ORDER BY city_name;

-- Języki używane w co najmniej 5 krajach.
SELECT l.Language           language_name,
       COUNT(l.CountryCode) country_count
FROM countrylanguage l
GROUP BY l.Language
HAVING country_count > 5
ORDER BY country_count DESC;

-- Języki z ilością miast.
SELECT l.Language language_name,
       COUNT(*)   city_count,
       GROUP_CONCAT(t.Name)
FROM countrylanguage l
         JOIN city t ON t.CountryCode = l.CountryCode
GROUP BY l.Language;

-- Najczęściej używane języki na świecie.
SELECT l.Language,
       SUM(c.Population) speaker_count
FROM countrylanguage l
         JOIN country c ON c.Code = l.CountryCode
GROUP BY l.Language
ORDER BY speaker_count DESC
LIMIT 10;