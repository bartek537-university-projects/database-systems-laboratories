USE world;

-- ZADANIE: wypisz dane państwa, o największej ludności.
SELECT c.Continent,
       c.Name,
       c.Population
FROM country c
WHERE c.Population = (SELECT MAX(ic.Population)
                      FROM country ic);

-- ZADANIE: wypisz dane kraju, który ma populację taką jak średnia plus-minus 2 miliony mieszkańców.
SELECT c.Continent,
       c.Name,
       c.Population
FROM country c
WHERE ABS(c.Population - (SELECT AVG(ic.Population)
                          FROM country ic)) < 2e6;

-- ZADANIE: dołożyć do powyższego stolice.
SELECT c.Continent,
       c.Name,
       t.Name,
       c.Population
FROM country c
         JOIN city t ON t.ID = c.Capital
WHERE ABS(c.Population - (SELECT AVG(ic.Population)
                          FROM country ic)) < 2e6
ORDER BY c.Population;

-- ZADANIE: wypisz dane państwa o największej ludności w Europie.
SELECT c.Name,
       t.Name,
       c.Population
FROM country c
         RIGHT JOIN city t ON t.Id = c.Capital
WHERE c.Continent = 2
  AND c.Population = (SELECT MAX(ic.Population)
                      FROM country ic
                      WHERE ic.Continent = 2);

-- ZADANIE: wypisz kraje na literę "P", ich kontynent, ich powierzchnię
-- i różnicę ich powierzchni i średniej powierzchni państw na "P".
SELECT c.Name,
       c.Continent,
       c.SurfaceArea,
       c.SurfaceArea - (SELECT AVG(ic.SurfaceArea)
                        FROM country ic
                        WHERE ic.Name LIKE 'p%')
           AS Difference
FROM country c
WHERE c.Name LIKE 'p%'
ORDER BY Difference;

-- ZADANIE: (dla podzapytania we FROM) wypisz języki, których nazwa rozpoczyna się literami 'po'.
SELECT l.Language
FROM (SELECT DISTINCT il.Language
      FROM countrylanguage il) as l
WHERE l.Language LIKE 'po%';
-- 11 - 13 ms

SELECT DISTINCT l.Language
FROM countrylanguage l
WHERE l.Language LIKE 'po%';
-- 7 - 9 ms

-- ZADANIE: wypisz nazwy, kontynenty, powierzchnie dla państw,
-- których powierzchnia jest największą na danym kontynencie.
SELECT c.Name,
       c.Continent,
       c.SurfaceArea
FROM country c
         JOIN (SELECT ic.Continent,
                      MAX(ic.SurfaceArea) SurfaceArea
               FROM country ic
               GROUP BY ic.Continent) n
              ON c.Continent = n.Continent
                  AND c.SurfaceArea = n.SurfaceArea;
-- 8 ms

SELECT c.Name,
       c.Continent,
       c.SurfaceArea
FROM country c
WHERE c.SurfaceArea = (SELECT MAX(ic.SurfaceArea)
                       FROM country ic
                       WHERE ic.Continent = c.Continent)
-- 24 ms

-- ZADANIE: wypisz państwa, formy rządów, i długość życia państw,
-- których długość życia jest największa na świecie dla danych form rządów.

SELECT c.Name,
       c.GovernmentForm,
       c.LifeExpectancy
FROM country c
         JOIN (SELECT DISTINCT ic.GovernmentForm,
                               MAX(ic.LifeExpectancy) LifeExpectancy
               FROM country ic
               WHERE ic.LifeExpectancy IS NOT NULL
               GROUP BY (ic.GovernmentForm)) gn ON gn.GovernmentForm = c.GovernmentForm
WHERE c.LifeExpectancy = gn.LifeExpectancy;
-- 9 ms

-- ZADANIE: wypisz kraj, stolicę, powierzchnię, populację i rok uzyskania niepodległości
-- powierzchnia jest większa od połowy średniej powierzchni na kontynencie danego kraju
-- populacja jest większa od średniej populacji państw na daną literę
-- parzystość roku uzyskania niepodległości jest taka jak najmłodszego kraju świata
SELECT c.Name,
       t.Name Capital,
       c.SurfaceArea,
       c.Population,
       c.IndepYear
FROM country c
         JOIN city t ON t.ID = c.Capital
WHERE c.SurfaceArea > (SELECT AVG(ic.SurfaceArea) FROM country ic WHERE ic.Continent = c.Continent) / 2
  AND c.Population > (SELECT AVG(ic.Population) FROM country ic WHERE LEFT(ic.Name, 1) = LEFT(c.Name, 1))
  AND ABS(c.IndepYear % 2) = ABS((SELECT MAX(ic.IndepYear) FROM country ic) % 2);

-- ZADANIE: wypisz populacje i nazwy miast państwa,
-- których populacja jest największa w każdym z państw
SELECT c.Name,
       t.Name,
       t.Population
FROM city t
         JOIN country c ON c.Code = t.CountryCode
WHERE t.Population = (SELECT MAX(it.Population) FROM city it WHERE it.CountryCode = t.CountryCode)
ORDER BY t.Population;
-- 375-425 ms

SELECT c.Name,
       t.Name,
       t.Population
FROM country c
         JOIN (SELECT it.CountryCode, MAX(it.Population) MaxCityPopulation
               FROM city it
               GROUP BY it.CountryCode) m ON m.CountryCode = c.Code
         JOIN city t ON t.CountryCode = c.Code AND t.Population = m.MaxCityPopulation
ORDER BY t.Population;
-- 15-20 ms
