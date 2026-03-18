- `SELECT`
  ```sql
  SELECT 1+1, POW(2, 10), SQRT(2), EXP(3), PI();
  ```
  Dla kolumn można wprowadzać aliasy.
  ```sql
  SELECT 1+1 Suma, POW(2, 10) 'Potęga 10', SQRT(2) AS 'Pierwiastek';
  ```
  Kilka kolumn może mieć ten sam alias, co jest dozwolone.
  ```sql
  SELECT first_name 'Nazwa', last_name 'Nazwa', city 'Nazwa'
  FROM person;
  ```
- `ORDER BY`
  ```sql
  SELECT first_name, last_name
  FROM person
  ORDER BY last_name ASC, first_name DESC; -- ASC można pomijać.
  ```
  ```sql
  SELECT first_name, last_name
  FROM person
  ORDER BY 1, 2 DESC; -- Sortowanie po numerze kolumny, indeksowanych od 1.
  ```
  W przypadku typu enum, rekordy będą sortowane zgodnie z ustawioną kolejnością (nie alfabetycznie).\
  Gdy kilka kolumn, które chcemy posortować ma ten sam alias, zostanie wyświetlony błąd o braku jednoznaczności.
- `WHERE`
  Warunki ewaluowane są po kolei, co oznacza, że w poniższym przykładzie wystarczy, że osoba mieszka w Łodzi.
  Wielkość liter nie ma znaczenia.
    - Kolejność wykonywania działań
      ```sql
      SELECT *
      FROM person
      WHERE LENGTH(first_name) < 4 AND age > 18
         OR city = 'Łódź';
      ```
    - `BETWEEN .. AND ..`
      ```sql
      SELECT *
      FROM person
      WHERE age BETWEEN 18 AND 24; -- Obustronnie domknięty
      ```
    - `LIKE ..`

      | Symbol | Opis                 |
      |--------|----------------------|
      | %      | Dowolna ilość znaków |
      | _      | Dokładnie jeden znak |

      ```sql
      .. WHERE first_name LIKE 'A'; -- Równoznaczne z first_name = 'A'
      .. WHERE first_name LIKE 'A%'; -- Zaczyna się od A.
      .. WHERE first_name LIKE '%A'; -- Kończy się na A.
      .. WHERE first_name LIKE '%A%'; -- Zawiera A w dowolnym miejscu (nawet na początku lub końcu).
      .. WHERE first_name LIKE '%A_'; -- Zawiera na końcu A, które poprzedza jeden znak.
      ```
      ```sql
      .. WHERE first_name NOT LIKE '%A%'; -- Nie zawiera literki A.
      ```
    - `IN (..)`
      ```sql
      SELECT *
      FROM person
      WHERE first_name IN ('Ewa', 'Adam');
      ```
      ```sql
      SELECT *
      FROM person
      WHERE first_name NOT IN ('Alicja', 'Aneta');
      ```
- `LIMIT`
  ```sql
  SELECT *
  FROM person
  LIMIT 2, 1; -- Pomijamy 2 rekordy i wybieramy 1 następny.
  ```
