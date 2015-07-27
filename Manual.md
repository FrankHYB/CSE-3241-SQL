#Table Explanation
1. BOOK
  - Entity for a book in real life.
  - Explanation of attributes:
    - `ISBN` : The ISBN of a book, primary key for this table, stored as `CHARACTER` with fixed length of 13 (standard length of ISBN).
    - `Title` : The title of a book, stored as `VARCHAR` with maximum length of 255.
    - `Year` : Year the book was published, stored as `CHARACTER` with fixed length of 4.
    - `Price` : Price of the book, stored as `DOUBLE`.
- AUTHOR
  - Entity for the author of a book.
  - Explanation of attributes:
    - `Name` : The name of this author, primary key for this table, stored as `VARCHAR` with maximum length of 100.
- CATEGORY
  - Entity for the category a book belongs to.
  - Explanation of attributes:
    - `Name` : The name of this category, stored as `VARCHAR` with maximum length of 100.
- PUBLISHER
  - Entity for the publisher of a book.
  - Explanation of attributes:
    - `Name` : The name of this publisher, stored as `VARCHAR` with maximum length of 100.
- BOOK_AUTHOR
  - Entity for the relationship between a book and an author.
  - Explanation of attributes:
    - `Book_ISBN` : The ISBN of the book.
    - `Author_Id` : The id of the author.
    - The primary key for this table is both `Book_ISBN` and `Author_Id`.
- BOOK_CATEGORY
  - Entity for the relationship between a book and a category.
  - Explanation of attributes:
    - `Book_ISBN` : The ISBN of the book.
    - `Category_Id` : The id of the category.
    - The primary key for this table is both `Book_ISBN` and `Category_Id`.
- BOOK_PUBLISHER
  - Entity for the relationship between a book and a publisher.
  - Explanation of attributes:
    - `Book_ISBN` : The ISBN of the book.
    - `Publisher_Id` : The id of the publisher.
    - The primary key for this table is both `Book_ISBN` and `Publisher_Id`.
- CUSTOMER
  - Entity for a customer in real life.
  - Explanation of attributes:
   - `Id` : The id of this customer, primary key for this table, stored as `INTEGER`.
   - `First_Name` : First name of this customer, stored as `VARCHAR` with maximum length of 20.
   - `Last_Name` : Last name of this customer, stored as `VARCHAR` with maximum length of 20.
   - 'Email' : Email address of this customer, required to be unique, stored as `VARCHAR` with maximum length of 50.
   - `Pass_Hash` : SHA-1 salted password using PBKDF2 with 1000 iterations, stored as `CHARACTER` with fixed length of 66.
   - `Address_Id` : The id of this customer's address, this is a foreign key referencing the `Id` in `ADDRESS`.
   - `Credit_Card_Number` : The credit card number of this customer, this is a foreign key referencing the `Credit_Card_Number` in `CREDIT_CARD`.
- ORDERS
  - Entity for purchase of a book made by a single customer.
  - Explanation of attributes:
   - `Id` : The identifier of this purchase, primary key for this table, stored as `INTEGER`.
   - `Customer_Id` : Id of the customer who made this purchase, this is a foreign key referencing the `Id` in `CUSTOMER`.
   - `Book_ISBN` : ISBN of the book purchased by the customer, this is a foreign key referencing the `ISBN` in `BOOk`.
   - `Quantity` : The quantity of the book purchased by the customer, stored as `INTEGER`.
   - `Purchase_Date` : The date and time when the customer made this purchase, store as `DATETIME`.
- RATING
  - Entity for a rating customer made about a certain book.
  - Explanation of attributes:
    - `Customer_Id` : The Id of the customer who rated this book, this is a foreign key referencing the `Id` in `CUSTOMER`.
    - `Book_ISBN` : The ISBN of the book reviewed by the customer, this is a foreign key referencing the `ISBN` in `BOOK`.
    - `Customer_Id` and `Book_ISBN` are combined as the primary key for this table.
    - `Star_Count` : Number of stars this customer rated the book, stored as `INTEGER` and must be between 1 and 5.
    - `Comment` : The comment this customer made about this book, stored as `VARCHAR` with maximum length of 400.
- BOOK_STOCK
  - Entity for the inventory of a book stored in a warehouse.
  - `Book_ISBN` : The ISBN of the book, this is a foreign key referencing the `ISBN` of `BOOK`.
  - `Warehouse_Id` : The id of the warehouse, this is a foreign key referencing the `Id` of `WAREHOUSE`.
  - `Quantity` : The quantity of this book stored in this warehouse, stored as `INTEGER`.
- CREDIT_CARD
  - Entity for a credit card used by customers.
  - Explanation of attributes:
   - `Credit_Card_Number` : The credit card's number, primary key for this table, stored as `INTEGER`.
   - `CVV_Code` : The CVV code for this credit card, stored as `INTEGER`.
   - `Billing_Address_Id` : The id of billing address for this credit card, this is a foreign key referencing the `Id` of `Address`.
- WAREHOUSE
  - Entity for the place where a book is stored.
  - Explanation of attributes:
    - `Id` : Primary key for this table.
    - `Address_Id` : The id of the address this warehouse is located at, this is a foreign key referencing the `Id` of `Address`.
- ADDRESS
  - Entity for the address something is located at.
  - Explanation of attributes:
    - `Id` : Primary key for this table, stored as `INTEGER`.
    - `Name` : Name for this address, stored as `VARCHAR` with maximum length of 50.
    - `Street_Address` : The street address of this place, stored as `VARCHAR` with maximum length of 200.
    - `City` : City this place belongs to, stored as `VARCHAR` with maximum length of 100.
    - `State_Code` : Postal code of the state this address belongs to, this is a foreign key referencing `Code` in `ADDRESS`.
    - `Zip` : Zip code of this place, stored as `CHARACTER` with fixed length of 5.
- STATE
  - Entity for all the US States.
  - Explanation of attributes:
    - `Code` : Postal code for this state, primary key for this table, stored as `CHARACTER` with fixed length of 2.
    - `Name` : Name of this state, stored as `VARCHAR` with maximum length of 40.

#Sample Queries

#Instructions on how to insert data
- Inserting order requirement
  - Insert Book and its corresponding author, category or publisher before inserting the relationship between them into the join tables (`BOOK_AUTHOR`, `BOOK_CATEGORY`,  `BOOK_PUBLISHER`).
  - Create the credit card and address entity before creating the customer entity.
- Examples
  - Insert a new book record to the `BOOK` table:
  ```sql
  INSERT INTO BOOK (ISBN, Title, Year, Price)
  VALUES ('9781400032716', 'The Curious Incident of the Dog in the Night-Time', '2003', 7.68);
  ```
  - Insert a new author record into the `AUTHOR` table:
  ```sql
  INSERT INTO AUTHOR (Name) VALUES ('Mark Haddon');
  ```
  - Insert a new category record into the `CATEGORY` table:
  ```sql
  INSERT INTO CATEGORY (Name) VALUES ('Family Life');
  ```
  - Insert a new publisher record into the `PUBLISHER` table:
  ```sql
  INSERT INTO PUBLISHER (Name) VALUES ('Vintage');
  ```
  - Insert a new record of relationship between `BOOK` and `AUTHOR` into `BOOK_AUTHOR`:
  ```sql
  INSERT INTO BOOK_AUTHOR (Book_ISBN, Author_Name) VALUES ('9781400032716', 'Mark Haddon');
  ```
  - Insert a new record of relationship between `BOOK` and `CATEGORY` into `BOOK_CATEGORY`:
  ```sql
  INSERT INTO BOOK_CATEGORY (Book_ISBN, Category_Name) VALUES ('9781400032716', 'Family Life');
  ```

  - Insert a new record of relationship between `BOOK` and `PUBLISHER` into `BOOK_PUBLISHER`:
  ```sql
  INSERT INTO BOOK_PUBLISHER (Book_ISBN, Publisher_Name) VALUES ('9781400032716', 'Vintage');
  ```

#Instruction on how to delete data
- There are no special requirement for deleting data from the database, the database will make sure that there are no delete anomalies.
- Examples:
    - Delete a book record from `BOOK`:
    ```sql
    DELETE FROM BOOK WHERE Book_ISBN = '9781400032716';
    ```

    - Delete a author record from `AUTHOR`:
    ```sql
    DELETE FROM AUTHOR WHERE Name = 'Mark Haddon';
    ```

    - Delete a category record from `CATEGORY`:
    ```sql
    DELETE FROM CATEGORY WHERE Name = 'Family Life';
    ```

    - Delete a publisher record from `PUBLISHER`:
    ```sql
    DELETE FROM PUBLISHER WHERE Name = 'Vintage';
    ```

    - Delete a record of relationship between `BOOK` and `AUTHOR` from `BOOK_AUTHOR`:
    ```sql
    DELETE FROM BOOK_AUTHOR WHERE Book_ISBN = '9781400032716';
    DELETE FROM BOOK_AUTHOR WHERE Author_Name = 'Mark Haddon';
    ```
    - Delete a record of relationship between `BOOK` and `CATEGORY` from `BOOK_CATEGORY`:
    ```sql
    DELETE FROM BOOK_CATEGORY WHERE Book_ISBN = '9781400032716';
    DELETE FROM BOOK_CATEGORY WHERE Category_Name = 'Family Life';
    ```

    - Delete a record of relationship between `BOOK` and `PUBLISHER` from `BOOK_PUBLISHER`:
    ```sql
    DELETE FROM BOOK_PUBLISHER WHERE Book_ISBN = '9781400032716';
    DELETE FROM BOOK_PUBLISHER WHERE Publisher_Name = 'Vintage';
    ```
