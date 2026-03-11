## `ALTER TABLE`

- `ADD COLUMN nazwa_kolumny opis_typu...`
  ```sql
  ALTER TABLE phone
    ADD COLUMN phone_id TINYINT UNSIGNED NOT NULL;
  ```
- `MODIFY nazwa_kolumny opis_typu...`
    ```sql
    ALTER TABLE phone
        MODIFY carrier ENUM ('tmobile', 'play') NOT NULL;
    ```
- `CHANGE nazwa_kolumny nowa_nazwa_kolumny opis_typu...`
  ```sql
  ALTER TABLE phone
      CHANGE carrier company ENUM ('tmobile', 'play') NOT NULL;
  ```

W przypadku dodawania i modyfikacji kolumn możemy także wskazać miejsce ich wstawienia, dodając na końcu `FIRST` lub
`AFTER nazwa_innej_kolumny`.

- `DROP COLUMN nazwa_kolumny`
  ```sql
  ALTER TABLE phone
      DROP COLUMN price;
  ```
- `ADD PRIMARY KEY (nazwa_kolumny)`
  ```sql
  ALTER TABLE phone
      ADD PRIMARY KEY (phone_number);
  ```
- `ADD FOREIGN KEY (nazwa_kolumny) nazwa_innej_tabeli (nazwa_innej_kolumny)`
  ```sql
  ALTER TABLE mobile_phone
      ADD FOREIGN KEY (mobile_phone_id) REFERENCES phone (phone_id);
  ```
- `DROP PRIMARY KEY`
  ```sql
  ALTER TABLE mobile_phone
      DROP PRIMARY KEY;
  ```
- `DROP FOREIGN KEY nazwa_constraint`
  ```sql
  ALTER TABLE mobile_phone
      DROP FOREIGN KEY fk_phone;
  ```
- `ALTER nazwa_kolumny SET DEFAULT wartość`
  ```sql
  ALTER TABLE test
      ALTER test_id SET DEFAULT 10;
  ```
- `ALTER nazwa_kolumny DROP DEFAULT`
  ```sql
  ALTER TABLE test
      ALTER test_id DROP DEFAULT;
  ```
- `RENAME nowa_nazwa_tabeli`
  ```sql
  ALTER TABLE test
      RENAME test_table;
  ```
- `AUTO_INCREMENT`
  ```sql
  ALTER TABLE test_table
    AUTO_INCREMENT 15;
  ```
  Zmniejszenie indeksu AUTO_INCREMENT jest możliwe tylko do najwyższej wartości występującej w tabeli. Przykładowo, gdy
  istniały wszystkie rekordy do identyfikatora 15, usuniemy 5 z końca i 5 z początku, po czym przestawimy licznik na 0,
  następnemu rekordowi zostanie nadany identyfikator 10.

## `INSERT`

```sql
INSERT INTO employee (employee_id, first_name, last_name)
    VALUE (17, 'Mikołaj', 'Pilecki');
```

Można pominąć pole AUTO_INCREMENT lub wstawić w nie 0, aby wartość została nadana automatycznie.

## `UPDATE`

```sql
UPDATE employee
SET name = 'Jacek'
WHERE employee_id = 10;
```

```sql
UPDATE employee
SET employee_id = employee_id - 10;
```

## `DELETE`

```sql
DELETE
FROM employee
WHERE employee_id = 17;
```

## `SHOW CREATE TABLE`

Pokazuje kod tworzący od zera wskazaną tabelę.

```sql
SHOW CREATE TABLE employee;
```

```csv
test_table,"CREATE TABLE `test_table` (
  `test_id` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci"
```

