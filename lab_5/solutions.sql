USE world;

-- Zadanie 1. Ilość państw każdego kontynentu.
SELECT c.Continent, COUNT(*) country_count
FROM country c
GROUP BY c.Continent;

-- Zadanie 2. Ilość państw każdego kontynentu, posortowana po ilości państw.
SELECT c.Continent, COUNT(*) country_count
FROM country c
GROUP BY c.Continent
ORDER BY COUNT(*);
# ORDER BY country_count;
# ORDER BY 2;

-- Zadanie 3. Sumaryczna powierzchnia państw oraz wielkość populacji każdego kontynentu.
SELECT c.Continent,
       SUM(c.SurfaceArea) surface_area,
       SUM(c.Population)  population
FROM country c
GROUP BY c.Continent
ORDER BY population DESC;

-- Zadanie 4. Ilość państw, średnia powierzchnia i wielkość populacji każdego kontynentu.
SELECT c.Continent,
       COUNT(*)           country_count,
       AVG(c.SurfaceArea) avg_surface_area,
       AVG(c.Population)  avg_population
FROM country c
GROUP BY c.Continent;

-- Zadanie 5. Najpopularniejszy ustrój państw w Europie.
SELECT c.GovernmentForm government_form,
       COUNT(*)         country_count
FROM country c
WHERE c.Continent = 'Europe'
  AND c.Population > 1e6
GROUP BY c.GovernmentForm
LIMIT 1;

-- Zadanie 6. Państwo posiadające najwięcej miast.
SELECT c.Code   country_code,
       COUNT(*) city_count
FROM country c
         JOIN city t ON c.Code = t.CountryCode
GROUP BY c.Code
ORDER BY city_count DESC
LIMIT 1;

-- Zadanie 7. Najpopularniejsze języki świata.
SELECT l.Language
FROM countrylanguage l
         JOIN country c ON l.CountryCode = c.Code
GROUP BY l.Language
ORDER BY COUNT(c.Code) DESC
LIMIT 10;

-- Zadanie 8. Popularne ustroje państwowe na świecie.
SELECT c.GovernmentForm
FROM country c
GROUP BY c.GovernmentForm
HAVING COUNT(*) >= 10;

-- Zadanie 9. Rok z największą ilością państw odzyskujących niepodległość.
SELECT c.IndepYear   independence_year,
       COUNT(c.Name) country_count
FROM country c
WHERE c.IndepYear IS NOT NULL
GROUP BY c.IndepYear
ORDER BY country_count DESC
LIMIT 1;

-- Zadanie 10. Lata, w których wiele państw odzyskało niepodległość.
SELECT c.IndepYear   independence_year,
       COUNT(c.Name) country_count
FROM country c
WHERE c.IndepYear IS NOT NULL
GROUP BY c.IndepYear
HAVING country_count >= 5
ORDER BY country_count DESC;
