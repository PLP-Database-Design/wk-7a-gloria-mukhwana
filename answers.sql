                -- QUESTION ONE
WITH RECURSIVE cte AS (
SELECT 
OrderID,
CustomerName,
Products,
1 AS position,
SUBSTRING_INDEX(Products, ',', 1) AS Product
FROM ProductDetail
    
UNION ALL
    
SELECT 
OrderID,
CustomerName,
Products,
position + 1,
TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', position + 1), ',', -1))
FROM cte
WHERE position < LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1
)
SELECT OrderID, CustomerName, Product
FROM cte
ORDER BY OrderID, position;



            -- QUESTION TWO
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;

ALTER TABLE Orders ADD PRIMARY KEY (OrderID);

ALTER TABLE OrderItems ADD PRIMARY KEY (OrderID, Product);
ALTER TABLE OrderItems ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
