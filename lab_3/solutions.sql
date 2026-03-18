-- Zadanie 1. Najmniejsze państwo Azji.
SELECT c.Name, c.SurfaceArea
FROM country c
WHERE c.Continent = 'Asia'
ORDER BY c.SurfaceArea
LIMIT 1;

-- Zadanie 2. Największych 5 państw świata.
SELECT c.Name, c.SurfaceArea
FROM country c
ORDER BY c.SurfaceArea DESC
LIMIT 5;

-- Zadanie 3. Najmniejszych 10 państw świata.
SELECT c.Name, c.SurfaceArea
FROM country c
ORDER BY c.SurfaceArea
LIMIT 10;

-- Zadanie 4. Najmniejszych 10 państw w Europie.
SELECT c.Name, c.SurfaceArea
FROM country c
WHERE c.Continent = 'Europe'
ORDER BY c.SurfaceArea
LIMIT 10;

-- Zadanie 5. Państwa o zadanej powierzchni w Europie.
SELECT c.Name 'Państwo', c.SurfaceArea `Pole powierzchni`
FROM country c
WHERE c.Continent = 'Europe'
  AND c.SurfaceArea BETWEEN 40000 AND 100000;

-- Zadanie 6. Miasta zaczynające się od 'Z' i kończące na 'k'.
SELECT i.Name
FROM city i
WHERE i.Name LIKE 'Z%K';

-- Zadanie 7. Miasta zaczynające się od 'W' mające powyżej 1 mln mieszkańców.
SELECT i.Name, i.Population
FROM city i
WHERE i.Name LIKE 'W%'
  AND i.Population > 1000000;

-- Zadanie 8. Miasta mające poniżej 500 lub powyżej 9 mln mieszkańców.
SELECT i.Name, i.Population
FROM city i
WHERE i.Population < 500
   OR i.Population > 9000000;

-- Zadanie 9. Państwa świata posortowane według kontynentu i pola powierzchni malejąco.
SELECT c.Name, c.Continent, c.SurfaceArea
FROM country c
ORDER BY c.Continent, c.SurfaceArea DESC;

-- Zadanie 10. Najgęściej zaludnionych 10 państw.
SELECT c.Name, c.Population / c.SurfaceArea `Gęstość zaludnienia`
FROM country c
ORDER BY `Gęstość zaludnienia` DESC
LIMIT 10;

-- Zadanie 11. Najgęściej zaludnione 10 państw, których powierzchnia jest większa od 10 tys. km kw.
SELECT c.Name, c.Population / c.SurfaceArea PopulationDensity
FROM country c
WHERE c.SurfaceArea > 10000
ORDER BY PopulationDensity DESC
LIMIT 10;

-- Zadanie 12. Najmniej gęsto zaludnione 4 państwa.
SELECT c.Name, c.Population / c.SurfaceArea PopulationDensity
FROM country c
ORDER BY PopulationDensity
LIMIT 4;

-- Zadanie 13. Najmniej gęsto zaludnione 10 państw, z pominięciem niezamieszkałych przez ludzi.
SELECT c.Name, c.Population / c.SurfaceArea PopulationDensity
FROM country c
WHERE c.Population > 0
ORDER BY PopulationDensity
LIMIT 10;

-- Zadanie 14. Kraje, które nie uzyskały niepodległości.
SELECT c.*
FROM country c
WHERE c.IndepYear IS NULL;

-- Zadanie 15. Największy, niepodległy kraj.
SELECT c.Name, c.SurfaceArea, c.IndepYear
FROM country c
WHERE c.IndepYear IS NOT NULL
ORDER BY c.SurfaceArea DESC
LIMIT 1;

-- Zadanie 16. Kraje azjatyckie, które uzyskały niepodległość p.n.e..
SELECT c.*
FROM country c
WHERE c.Continent = 'Asia'
  AND c.IndepYear < 0;

-- Zadanie 17. Państwa posiadające powyżej 5 mln mieszkańców,
-- które uzyskały niepodległość p.n.e, lub nie uzyskały jej wcale.
SELECT c.Name, c.Population, c.IndepYear
FROM country c
WHERE c.Population > 5000000
  AND (IndepYear < 0 OR IndepYear IS NULL);

-- Zadanie 18. Najmniejsze miasto w Polsce.
SELECT i.Name, i.Population
FROM city i
WHERE i.CountryCode = 'pol'
ORDER BY i.Population
LIMIT 1;