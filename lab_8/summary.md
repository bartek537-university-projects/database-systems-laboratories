## Podzapytania

- `ALL` Sprawdza, czy wszystkie wartości zwrócone z podzapytania spełniają warunek.
  ```sql
  SELECT i.Name, i.Population
  FROM city i
  WHERE i.Population > ALL (SELECT o.Population FROM country o WHERE o.Continent = 'Oceania');
  ```
- `ANY` (`SOME`) Sprawdza, czy jakakolwiek wartość zwrócona z podzapytania spełnia warunek.
  ```sql
  SELECT o.Name
  FROM country o
  WHERE o.Continent = 'Europe'
    AND o.Population < ANY (SELECT i.Population
                            FROM country o
                                     JOIN city i ON i.ID = o.Capital
                            WHERE o.Continent = 'Europe');
  ```
- `IN` Sprawdza, czy dana wartość zawiera się w podzapytaniu lub liście wartości.
  ```sql
  SELECT 'Poland' IN (SELECT Name from country);
  SELECT 'Poland' = ANY (SELECT Name from country); -- Alternatywny zapis z wykorzystaniem operatora `ANY`.
  ```
- `[NOT] EXISTS` Sprawdza, czy podzapytanie zwraca jakiekolwiek rekordy.
  ```sql
  SELECT o.Name
  FROM country o
  WHERE NOT EXISTS(SELECT ii.ID FROM city ii WHERE ii.CountryCode = o.Code);
  ```

## Operacje na tekście

- `LIKE BINARY` Działa jak `LIKE` z uwzględnieniem wielkości liter.
  ```sql
  SELECT Name
  FROM country
  WHERE Name LIKE BINARY '%P%';
  -- W odróżnieniu od `LIKE`, zwrócone zostaną między innymi
  -- 'Poland' oraz 'French Polynesia', ale nie 'Singapore'.
  ```

## Funkcje okna

- `WITH ROLLUP` Wstawia dodatkowe rekordy po każdym zamknięciu się którejś z grup,
  zawierające wywołanie agregata dla całej tej grupy.
  ```sql
  SELECT Continent,
         Region,
         COUNT(*)
  FROM country
  GROUP BY Continent, Region
  WITH ROLLUP;
  
  # +-------------+-------------------------+--------+
  # |Continent    |Region                   |COUNT(*)|
  # +-------------+-------------------------+--------+
  # |...          |.........................|...     |
  # |Oceania      |Australia and New Zealand|5       |
  # |Oceania      |Melanesia                |5       |
  # |Oceania      |Micronesia               |7       |
  # |Oceania      |Micronesia/Caribbean     |1       |
  # |Oceania      |Polynesia                |10      |
  # |Oceania      |null                     |28      | -- Koniec grupy Region dla Oceanii
  # |Antarctica   |Antarctica               |5       |
  # |Antarctica   |null                     |5       | -- Koniec grupy Region dla Antarktyki
  # |South America|South America            |14      |
  # |South America|null                     |14      | -- Koniec grupy Region dla Południowej Ameryki
  # |null         |null                     |239     | -- Koniec grupy Continent dla całego zapytania
  # +-------------+-------------------------+--------+
  ```
- `ROW_NUMBER() OVER (ORDER BY ...)` Numeruje kolejne wiersze.
  ```sql
  SELECT Continent,
         Region,
         ROW_NUMBER() OVER (ORDER BY Continent, Region DESC)
  FROM country
  GROUP BY Continent, Region;
  
  # +-------------+-------------------------+--------------------------------------+
  # |Continent    |Region                   |ROW_NUMBER() OVER (ORDER BY Continent)|
  # +-------------+-------------------------+--------------------------------------+
  # |Asia         |Southern and Central Asia|1                                     |
  # |Asia         |Middle East              |2                                     |
  # |Asia         |Eastern Asia             |3                                     |
  # |Asia         |Southeast Asia           |4                                     |
  # |Europe       |Eastern Europe           |5                                     |
  # |Europe       |British Islands          |6                                     |
  # |Europe       |Baltic Countries         |7                                     |
  # |Europe       |Nordic Countries         |8                                     |
  # |Europe       |Western Europe           |9                                     |
  # |Europe       |Southern Europe          |10                                    |
  # |North America|Caribbean                |11                                    |
  # |North America|Central America          |12                                    |
  # |...          |...                      |...                                   |
  # +-------------+-------------------------+--------------------------------------+
  ```
- `RANK() OVER (ORDER BY ...)` Numeruje bloki danych.
  ```sql
  SELECT Continent,
         Region,
         RANK() OVER (ORDER BY Continent)
  FROM country
  GROUP BY Continent, Region;
  
  # +-------------+-------------------------+--------------------------------+
  # |Continent    |Region                   |RANK() OVER (ORDER BY Continent)|
  # +-------------+-------------------------+--------------------------------+
  # |Asia         |Southern and Central Asia|1                               |
  # |Asia         |Middle East              |1                               |
  # |Asia         |Eastern Asia             |1                               |
  # |Asia         |Southeast Asia           |1                               |
  # |Europe       |Eastern Europe           |5                               |
  # |Europe       |British Islands          |5                               |
  # |Europe       |Baltic Countries         |5                               |
  # |Europe       |Nordic Countries         |5                               |
  # |Europe       |Western Europe           |5                               |
  # |Europe       |Southern Europe          |5                               |
  # |North America|Caribbean                |11                              |
  # |North America|Central America          |11                              |
  # |...          |...                      |...                             |
  # +-------------+-------------------------+--------------------------------+
  ```
- `DENSE_RANK() OVER (ORDER BY ...)` Działa podobnie jak wyżej, ale nie pomija indeksów wykorzystanych wewnątrz bloków.
  ```sql
  SELECT Continent,
         Region,
         DENSE_RANK() OVER (ORDER BY Continent)
  FROM country
  GROUP BY Continent, Region;
  
  # +-------------+-------------------------+--------------------------------------+
  # |Continent    |Region                   |DENSE_RANK() OVER (ORDER BY Continent)|
  # +-------------+-------------------------+--------------------------------------+
  # |Asia         |Southern and Central Asia|1                                     |
  # |Asia         |Middle East              |1                                     |
  # |Asia         |Eastern Asia             |1                                     |
  # |Asia         |Southeast Asia           |1                                     |
  # |Europe       |Eastern Europe           |2                                     |
  # |Europe       |British Islands          |2                                     |
  # |Europe       |Baltic Countries         |2                                     |
  # |Europe       |Nordic Countries         |2                                     |
  # |Europe       |Western Europe           |2                                     |
  # |Europe       |Southern Europe          |2                                     |
  # |North America|Caribbean                |3                                     |
  # |North America|Central America          |3                                     |
  # |...          |...                      |...                                   |
  # +-------------+-------------------------+--------------------------------------+
  ```
- `RANK() OVER (PARTITION BY .. ORDER BY ...)` Numeruje wewnątrz bloków danych.
  ```sql
  SELECT Continent,
         Region,
         RANK() OVER (PARTITION BY Continent ORDER BY Region)
  FROM country
  GROUP BY Continent, Region;
  
  # +-------------+-------------------------+----------------------------------------------------+
  # |Continent    |Region                   |RANK() OVER (PARTITION BY Continent ORDER BY Region)|
  # +-------------+-------------------------+----------------------------------------------------+
  # |Asia         |Eastern Asia             |1                                                   |
  # |Asia         |Middle East              |2                                                   |
  # |Asia         |Southeast Asia           |3                                                   |
  # |Asia         |Southern and Central Asia|4                                                   |
  # |Europe       |Baltic Countries         |1                                                   |
  # |Europe       |British Islands          |2                                                   |
  # |Europe       |Eastern Europe           |3                                                   |
  # |Europe       |Nordic Countries         |4                                                   |
  # |Europe       |Southern Europe          |5                                                   |
  # |Europe       |Western Europe           |6                                                   |
  # |North America|Caribbean                |1                                                   |
  # |North America|Central America          |2                                                   |
  # |...          |...                      |...                                                 |
  # +-------------+-------------------------+----------------------------------------------------+
  ```

