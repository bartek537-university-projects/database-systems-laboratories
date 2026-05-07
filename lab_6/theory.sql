SELECT city.Name,
       country.Name
FROM city,
     country;

SELECT city.Name,
       country.Name
FROM city
         CROSS JOIN country;

SELECT city.Name, country.Name
FROM city,
     country
WHERE city.CountryCode = country.Code;

SELECT c.region,
       GROUP_CONCAT(c.name)
FROM country c
GROUP BY c.region;

SELECT l.Language,
       ANY_VALUE(c.Name)
FROM countrylanguage l
         JOIN country c ON c.Code = l.CountryCode
GROUP BY l.Language;

SELECT REPLACE('zdo', 'z', 'do'); # dodo
SELECT TRUNCATE(3.1315, 2); # 3.13
SELECT LPAD('1', 4, 'x'); # xxx1