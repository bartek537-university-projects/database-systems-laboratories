## Operacje na zbiorach

- `UNION [DISTINCT]`, `UNION ALL` Łączą wyniki kilku zapytań.
  ```sql
  SELECT c.Code, c.Population -- Kod, Populacja
  FROM country c
  WHERE c.Population > 1e8
  UNION
  SELECT c.Population, c.Name -- Populacja, Kod
  FROM country c
  WHERE c.Population < 100;
  ```
    - Kolumny mogą być różnych typów, ale ich ilość musi się pokrywać.
    - `UNION [DISTINCT]` domyślnie usuwa powtarzające się wiersze.
      Aby temu zapobiec, można wykorzystać polecenie `UNION ALL`.
- `INTERSECT`
- `EXCEPT`

## Agregacje

- `GROUP BY` Wskazuje kolumny, po których zostaną zgrupowane dane.
  ```sql
  SELECT c.Continent, COUNT(*) country_count
  FROM country c
  GROUP BY c.Continent
  ORDER BY COUNT(*);
  -- ORDER BY country_count; -- Równoważny zapis.
  -- ORDER BY 2; -- Równoważny zapis (2 kolumna).
  ```
  W klauzuli `SELECT` mogą się znajdować jedynie te kolumny, po których następuje grupowanie
  lub na których określono agregacje.
- `HAVING` Określa filtr na zgrupowanych wynikach — odpowiednik `WHERE` dla wyników agregacji.
  ```sql
  SELECT c.IndepYear independence_year,
        COUNT(c.Name) country_count
  FROM country c
  WHERE c.IndepYear IS NOT NULL
  GROUP BY c.IndepYear
  HAVING country_count >= 5
  ORDER BY country_count DESC;
  ```
- `MAX`, `MIN`, `SUM`, `AVG`, `COUNT`
  ```sql
  SELECT MIN(c.Population), -- 0
        MAX(c.Population),  -- 1277558000
        SUM(c.Population),  -- 6078749450
        AVG(c.Population),  -- 25434098.1172
        COUNT(c.Population) -- 239
  FROM country c;
  ```
  Uwaga dla `COUNT`.
  ```sql
  COUNT(*)
  COUNT(c.NullableColumn) -- Zlicza wartości niepuste (NOT NULL) w kolumnie.
  ```
- `SUM(DISTINCT)`, `AVG(DISTINCT)`, `COUNT(DISTINCT)` Wykonuje operacje na unikatowych wartościach zbioru.
  ```sql
  SELECT SUM(DISTINCT c.Population),  -- 6078547450
         AVG(DISTINCT c.Population),  -- 26896227.6549
         COUNT(DISTINCT c.Population) -- 226
  FROM country c;
  ```
  



