## Złączenia tabel

- Iloczyn kartezjański (bez użycia `CROSS JOIN`)
  ```sql
  SELECT city.Name,
         country.Name
  FROM city,
       country;
  ```
- `CROSS JOIN` Iloczyn kartezjański
  ```sql
  SELECT city.Name,
         country.Name
  FROM city
           CROSS JOIN country;
  ```
- `[INNER] JOIN` Łączy dane występujące w obydwu tabelach
  ```sql
  SELECT c.Name       country_name,
         t.Name       city_name,
         c.Population country_population,
         t.Population city_population
  FROM country c
           JOIN city t ON c.Capital = t.ID
  WHERE Continent = 'Europe';
  ```
- `LEFT JOIN`, `RIGHT JOIN` Zachowuje odpowiednio wszystkie rekordy z lewej lub prawej stronę
  ```sql
  SELECT c.Name, l.Language
  FROM country c
           LEFT JOIN countrylanguage l ON l.CountryCode = c.Code
  WHERE c.Name = l.Language
     OR l.Language IS NULL;
  ```
  W wyniku zostaną uwzględnione wszystkie kraje, a brakujące powiązania z językami uzupełnione wartością NULL.
  Języki nieprzypisane do żadnego państwa zostaną pominięte.

## Agregacje

- `GROUP_CONCAT` Agreguje tekst we wskazanej kolumnie do listy oddzielonej przecinkami.
  ```sql
  SELECT l.Language,
         GROUP_CONCAT(c.Name)
  FROM countrylanguage l
           JOIN country c ON c.Code = l.CountryCode
  GROUP BY l.Language;
  
  /*
  Afar,      "Djibouti,Eritrea"
  Afrikaans, "Namibia,South Africa"
  Aimar,     "Peru,Chile,Bolivia"
  */
  ```
- `ANY_VALUE` Agreguje tekst we wskazanej kolumnie przez wybór dowolnej wartości.
  ```sql
  SELECT l.Language,
         ANY_VALUE(c.Name)
  FROM countrylanguage l
           JOIN country c ON c.Code = l.CountryCode
  GROUP BY l.Language;
  
  /*
  Afar,      Djibouti
  Afrikaans, Namibia
  Aimar,     Bolivia
  */
  ```

## Operacje na tekście

- `REPLACE`

```sql
SELECT REPLACE('zdo', 'z', 'do'); /* dodo */
```

- `LPAD` Uzupełnia tekst do określonej długości wybranym znakiem.

```sql
SELECT LPAD('1', 4, 'x'); # xxx1
```

## Operacje na liczbach

- `TRUNCATE`

```sql
SELECT TRUNCATE(3.131592, 3); /* 3.131 */
```
