USE world;

-- Państwa niezawierające żadnych miast.
SELECT o.Name
FROM country o
         LEFT JOIN city i ON i.CountryCode = o.Code
WHERE i.ID IS NULL;

SELECT o.Name
FROM country o
WHERE NOT EXISTS(SELECT i.ID
                 FROM city i
                 WHERE i.CountryCode = o.Code);

-- Państwa europejskie mające populację mniejszą od jakiejkolwiek stolicy europejskiej.
SELECT o.Name
FROM country o
WHERE o.Continent = 'Europe'
  AND o.Population < ANY (SELECT i.Population
                          FROM country o
                                   JOIN city i ON i.ID = o.Capital
                          WHERE o.Continent = 'Europe');

-- Miasta mające populację większą od wszystkich państw Oceanii.
SELECT i.Name, i.Population
FROM city i
WHERE i.Population > ALL (SELECT o.Population
                          FROM country o
                          WHERE o.Continent = 'Oceania');

-- Miasta, których dwukrotność populacji jest większa od wszystkich państw Oceanii.
SELECT i.Name, i.Population
FROM city i
WHERE i.Population * 2 > ALL (SELECT o.Population
                              FROM country o
                              WHERE o.Continent = 'Oceania');

-- Łączna populacja najludniejszych państw świata.
SELECT SUM(s.Population)
FROM (SELECT o.Population
      FROM country o
      ORDER BY o.Population DESC
      LIMIT 10) s;

-- Państwa zawierające miasto o populacji większej niż ich stolica.
SELECT o.Name, i.Name, i.Population, m.max_population
FROM country o
         JOIN city i ON i.ID = o.Capital
         JOIN (SELECT so.Code, MAX(si.Population) max_population
               FROM country so
                        JOIN city si ON si.CountryCode = so.Code
               GROUP BY so.Code) m
              ON m.Code = o.Code
WHERE m.max_population > i.Population;

-- Pierwsze litery miast oraz ich ilość.
SELECT LEFT(i.Name, 1) letter,
       COUNT(*)        city_count
FROM city i
GROUP BY letter
ORDER BY letter;

-- Państwa, które nie posiadają miasta zaczynającego się na jedną z 10 najpopularniejszych liter.
SELECT *
FROM country o
WHERE NOT EXISTS(SELECT ii.ID
                 FROM city ii
                 WHERE LEFT(ii.Name, 1) IN (SELECT LEFT(iii.Name, 1) letter
                                            FROM city iii
                                            GROUP BY letter
                                            ORDER BY COUNT(*) DESC
                                            LIMIT 10));
-- [42000][1235] This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'
-- Można to rozwiązać ręcznie, poprzez zapisanie wyników najbardziej zagnieżdżonego podzapytania
-- oraz ich wykorzystanie w podzapytaniu, na przykład `... IN ('S', 'B', ...)`.

-- Ponumerować regiony.
SELECT Continent,
       Region,
       RANK() OVER (PARTITION BY Continent ORDER BY Region)
FROM country
GROUP BY Continent, Region;