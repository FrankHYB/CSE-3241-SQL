/**
 * A view that contains all the ratings for a book.
 */
CREATE VIEW BOOK_RATING AS
  SELECT
    Title,
    (First_Name || ' ' || Last_Name) AS Customer_Name,
    Star_Count,
    Comment
  FROM BOOK
    JOIN RATING ON BOOK.ISBN = RATING.Book_ISBN
    JOIN CUSTOMER ON CUSTOMER.Id = RATING.Customer_Id;

/**
 * The most gorgeous state from which people spend the most money.
 */
CREATE VIEW MOST_GORGEOUS_STATE AS
  SELECT STATE.Name
  FROM ORDERS
    JOIN BOOK ON Book.ISBN = ORDERS.Book_ISBN
    JOIN CUSTOMER ON CUSTOMER.Id = ORDERS.Customer_Id
    JOIN ADDRESS ON ADDRESS.Id = CUSTOMER.Address_Id
    JOIN STATE ON STATE.Id = ADDRESS.State_Id
  GROUP BY State_Id
  ORDER BY sum(Price * Quantity)
    DESC
  LIMIT 1;

/**
 *
 */