## `NULL`

- `IS NULL`
  ```sql
  SELECT c.Name, c.GNPOld
  FROM country c
  WHERE c.GNPOld IS NULL;
  # WHERE c.GNPOld = NULL; -- Nie zadziała
  # WHERE c.GNPOld = "NULL"; -- Nie zadziała
  # WHERE c.GNPOld = "0"; -- Nie zadziała
  ```
- Operacje na `NULL`
  ```sql
  SELECT NULL * 10, NULL + 5, SQRT(NULL); -- NULL, NULL, NULL
  ```
- Niepoprawne operacje matematyczne zwracają `NULL`
  ```sql
  SELECT 3 / 0, SQRT(-2); -- NULL, NULL
  ```
- `IFNULL`
  ```sql
  SELECT c.Name, IFNULL(c.GNPOld, 'Nieznane')
  FROM country c
  LIMIT 10;
  ```

## Data i czas

| typ         | format                | opis                                                                    |
|-------------|-----------------------|-------------------------------------------------------------------------|
| `DATE`      | `YYYY-MM-DD`          | Data lokalna                                                            |
| `TIME`      | `HH:MM:SS`            | Czas lokalny                                                            |
| `DATETIME`  | `YYYY-MM-DD HH:MM:SS` | Data i czas lokalny                                                     |
| `TIMESTAMP` | `YYYY-MM-DD HH:MM:SS` | Moment w czasie, do UTC w trakcie wstawiania (ze strefy czasowej sesji) |

- `DEFAULT CURRENT_TIMESTAMP`
  ```sql
  CREATE TABLE ...
  (
      timestamp_when TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );
  ```
- `NOW` Zwraca obecny moment w czasie (timestamp).
  ```sql
  SELECT NOW(); -- 2026-03-25 09:20:53
  ```
- `DATE_FORMAT`, `TIME_FORMAT` Formatują datę i czas (niezależnie od funkcji)
  ```sql
  SELECT DATE_FORMAT(o.timestamp_when, '%M %d, %y at %h:%i:%s %p'), -- March 25, 26 at 09:13:45 AM
    TIME_FORMAT(o.timestamp_when, '%M %d, %y at %h:%i:%s %p') -- March 25, 26 at 09:13:45 AM
  FROM orders o
  LIMIT 1;
  ```
- `YEAR`, `MONTH`, `DAY`, `HOUR`, `MINUTE` `SECOND` Wybierają element daty.
  ```sql
  WITH t AS (SELECT NOW() n)
  SELECT YEAR(n), MONTH(n), DAY(n), HOUR(n), MINUTE(n), SECOND(n) -- 2026, 3, 25, 9, 50, 28
  FROM t;
  ```

## Operacje na tekście

- `LENGTH` Zwraca długość tekstu.
  ```sql
  SELECT LENGTH('polska gurom'); -- 12
  ```
- `CONCAT` Łączy ze sobą podane teksty.
  ```sql
  SELECT CONCAT('polska', ' ', 'gurom'); -- 'polska gurom'
  ```
- `LEFT` i `RIGHT` pobierają z tekstu wskazaną liczbę znaków z danej strony.
  ```sql
  SELECT LEFT('myszojeleń', 5), RIGHT('myszojeleń', 5); -- 'myszo', 'jeleń'
- `SUBSTR` wybiera z tekstu litery od wskazanej pozycji.
  ```sql
  SELECT SUBSTR('zielonydywanlatający', 8, 5); -- 'dywan' (od 8 pozycji 5 liter)
  ```
  ```sql
  SELECT SUBSTR('zielonydywanlatający', 8); -- 'dywanlatający' (wszystkie znaki od 8 pozycji)
  ```
- `UPPER` i `LOWER` zmieniają wielkość liter w tekście.
  ```sql
  SELECT UPPER('John'), LOWER('Pork'); -- 'JOHN', 'pork'
  ```
- `LTRIM`, `RTRIM` usuwają białe znaki z danej strony
  ```sql
  SELECT LTRIM('    w z i    uuu m     '), RTRIM('    w z i    uuu m     '); -- 'w z i    uuu m     ', '    w z i    uuu m'
  ```
  `TRIM` usuwa białe znaki z obydwu stron
  ```sql
  SELECT TRIM('    w z i    uuu m     '); -- 'w z i    uuu m'
  ```

## Operacje warunkowe

- `IF`
  ```sql
  SELECT IF(2 + 4 = 6, 'To prawda', 'To nieprawda'); -- 'To prawda'  
  ```