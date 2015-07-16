/**
  * WorksheetTwoSimpleQueries
  */

-- Find the titles of all the books by Pratchett that cost less than $10
SELECT Title
FROM BOOK
  JOIN BOOK_AUTHOR ON BOOK.Id = BOOK_AUTHOR.Book_Id
  JOIN AUTHOR ON AUTHOR.Id = BOOK_AUTHOR.Author_Id
WHERE AUTHOR.Name LIKE '%Pratchett%' AND BOOK.Price < 10;

-- Give all the titles and their dates of purchase made by a single customer
SELECT
  Title,
  Purchase_Date
FROM BOOK
  JOIN ORDERS ON BOOK.Id = ORDERS.Book_Id
WHERE Customer_Id = 1;

-- Find the titles and ISBNs for all books with less than 5 copies in stock
SELECT
  Title,
  ISBN
FROM BOOK
  LEFT OUTER JOIN BOOK_STOCK ON BOOK_STOCK.Book_Id = BOOK.Id
WHERE Quantity < 5;

-- Give all the customers who purchased a book by Pratchett and the titles of Pratchett books they purchased
SELECT
  First_Name,
  Last_Name,
  Title
FROM BOOK
  JOIN BOOK_AUTHOR ON BOOK_AUTHOR.Book_Id = BOOK.Id
  JOIN AUTHOR ON AUTHOR.Id = BOOK_AUTHOR.Author_Id
  JOIN ORDERS ON ORDERS.Book_Id = BOOK.Id
  JOIN CUSTOMER ON CUSTOMER.Id = ORDERS.Customer_Id
WHERE AUTHOR.Name LIKE '%Pratchett%';

-- Find the total number of books purchased by a single customer (you choose how to design the customer)
SELECT sum(Quantity)
FROM ORDERS
WHERE Customer_Id = 1;

-- Find the customer who has purchased the most books and the total number of books they have purchased
SELECT
  First_Name,
  Last_Name,
  sum(Quantity)
FROM CUSTOMER
  JOIN ORDERS ON ORDERS.Customer_Id = CUSTOMER.Id
GROUP BY Customer_Id
ORDER BY Quantity
LIMIT 1;


/**
  * WorksheetTwoAdvancedQueries
  */
-- Provide a list of customer names, along with the total dollar amount each customer has spent
SELECT
  First_Name,
  Last_Name,
  sum(Quantity * Price)
FROM CUSTOMER
  JOIN ORDERS ON ORDERS.Customer_Id = CUSTOMER.Id
  JOIN BOOK ON ORDERS.Book_Id = BOOK.Id
GROUP BY Customer_Id;

-- Provide a list of customer names and e-mail addresses for customers who have spent more than the average customer
SELECT
  First_Name,
  Last_Name,
  Email
FROM CUSTOMER
  JOIN ORDERS ON ORDERS.Customer_Id = CUSTOMER.Id
  JOIN BOOK ON ORDERS.Book_Id = BOOK.Id
GROUP BY Customer_Id
HAVING sum(Price * Quantity) > avg(Price * Quantity);

-- Provide a list of the titles in the database and associated total copies sold to customers, sorted from the title that has sold the most individual copies to the title that has sold the least.
SELECT
  Title,
  sum(Quantity) AS Copies_Sold
FROM ORDERS
  JOIN BOOK ON BOOK.Id = ORDERS.Book_Id
GROUP BY BOOK.Id
ORDER BY Copies_Sold
  DESC;

-- Provide a list of the titles in the database and associated dollar totals for copies sold to customers, sorted from the title that has sold the highest dollar amount to the title that has sold the smallest
SELECT
  Title,
  sum(Price * Quantity) AS Revenue
FROM ORDERS
  JOIN BOOK ON BOOK.Id = ORDERS.Book_Id
GROUP BY BOOK.Id
ORDER BY Revenue
  DESC;

-- Find the most popular author in the database (i.e. the one who has sold the most books)
SELECT AUTHOR.Name
FROM ORDERS
  JOIN BOOK ON BOOK.Id = ORDERS.Book_Id
  JOIN BOOK_AUTHOR ON BOOK_AUTHOR.Book_Id = BOOK.Id
  JOIN AUTHOR ON AUTHOR.Id = BOOK_AUTHOR.Author_Id
GROUP BY AUTHOR.Id
ORDER BY sum(Quantity)
  DESC, AUTHOR.Name
LIMIT 1;

-- Find the most profitable author in the database for this store (i.e. the one who has brought in the most money)
SELECT AUTHOR.Name
FROM ORDERS
  JOIN BOOK ON BOOK.Id = ORDERS.Book_Id
  JOIN BOOK_AUTHOR ON BOOK_AUTHOR.Book_Id = BOOK.Id
  JOIN AUTHOR ON AUTHOR.Id = BOOK_AUTHOR.Author_Id
GROUP BY AUTHOR.Id
ORDER BY sum(Price * Quantity)
  DESC, AUTHOR.Name
LIMIT 1;

-- Provide a list of customer information for customers who purchased anything written by the most profitable author in the database
SELECT *
FROM CUSTOMER
WHERE Id IN (SELECT Customer_Id
             FROM ORDERS
             WHERE Book_Id IN (SELECT Book_Id
                               FROM BOOK_AUTHOR
                               WHERE Author_Id = (SELECT AUTHOR.Id
                                                  FROM ORDERS
                                                    JOIN BOOK ON BOOK.Id = ORDERS.Book_Id
                                                    JOIN BOOK_AUTHOR ON BOOK_AUTHOR.Book_Id = BOOK.Id
                                                    JOIN AUTHOR ON AUTHOR.Id = BOOK_AUTHOR.Author_Id
                                                  GROUP BY AUTHOR.Id
                                                  ORDER BY sum(Price * Quantity)
                                                    DESC, AUTHOR.Name
                                                  LIMIT 1)));

-- Provide the list of authors who wrote the books purchased by the customers who have spent more than the average customer
SELECT AUTHOR.Name
FROM AUTHOR
WHERE Id IN (SELECT Author_Id
             FROM BOOK_AUTHOR
             WHERE Book_Id IN (SELECT Book_Id
                               FROM ORDERS
                               WHERE Customer_Id IN (SELECT CUSTOMER.Id
                                                     FROM CUSTOMER
                                                       JOIN ORDERS ON ORDERS.Customer_Id = CUSTOMER.Id
                                                       JOIN BOOK ON ORDERS.Book_Id = BOOK.Id
                                                     GROUP BY Customer_Id
                                                     HAVING sum(Price * Quantity) > avg(Price * Quantity))));

