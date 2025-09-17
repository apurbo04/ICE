-- PUBS Database Queries SQL Script

USE PUBS;
GO

-- a. Show book title, author name (first initial + last name), publisher name
select * from titles
select * from authors

select au_fname, au_lname, CONCAT(LEFT(au_fname,1),'.',au_lname) as full_name,
title FROM authors
JOIN titleauthor ON authors.au_id=titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id


GO

-- b. Titles with total quantity sold > 40, sorted ascending
SELECT 
    t.title AS Book_Title,
    SUM(s.qty) AS Total_Qty_Sold
FROM titles t
JOIN sales s ON t.title_id = s.title_id
GROUP BY t.title
HAVING SUM(s.qty) > 40  --HAVING is like a WHERE, but it works after grouping.
ORDER BY Total_Qty_Sold ASC;  --order by is sorting

GO


-- c.1
CREATE PROCEDURE InPriceUntilAvg
@CategoryName VARCHAR(50),
@AvgPrice DECIMAL(10,2)
AS

BEGIN
    SELECT 
        t.title AS Book_Title,
        t.type AS Category,
        AVG(t.price) AS Avg_price
    FROM titles t
    WHERE t.type = @CategoryName
    GROUP BY t.title,t.type
    HAVING AVG(t.price) <= @AvgPrice;
END
GO

EXEC InPriceUntilAvg
@CategoryName = 'Business',
@AvgPrice = 20.22;

GO

-- c. Stored Procedure to increase price until desired average
CREATE PROCEDURE AdjustCategoryPrices
    @CategoryName VARCHAR(50),
    @DesiredAvg DECIMAL(10,2)
AS
BEGIN
    DECLARE @CurrentAvg DECIMAL(10,2);

    -- get the initial avg price of the categore
    SELECT @CurrentAvg = AVG(price)
    FROM titles 
    where type = @CategoryName;
    while @CurrentAvg < @DesiredAvg
    BEGIN
        -- Increase all prices in that category by 10%
        UPDATE titles 
        SET price = price*10
        where type = @CategoryName;

        -- recalculate the new avg
        select @CurrentAvg = AVG(price)
        From titles 
        where type = @CategoryName;
    END

    -- show final result after adjustment
    SELECT 
        t.title AS Book_Title,
        t.type AS Category,
        t.price AS Final_Price
    FROM titles t
    WHERE t.type = @CategoryName;
END
GO

EXEC AdjustCategoryPrices 
    @CategoryName = 'Business', 
    @DesiredAvg = 10.00;

GO



CREATE PROCEDURE IncreasePriceUntilAvg
    @CategoryName VARCHAR(50),
    @DesiredAvgPrice FLOAT
AS
BEGIN
    DECLARE @CurrentAvg FLOAT;

    -- Compute current average price
    SELECT @CurrentAvg = AVG(price)
    FROM titles
    WHERE type = @CategoryName;

    -- Loop until current average >= desired
    WHILE @CurrentAvg < @DesiredAvgPrice
    BEGIN
        -- Increase each price by 10%
        UPDATE titles
        SET price = price * 1.10
        WHERE type = @CategoryName;

        -- Recalculate current average
        SELECT @CurrentAvg = AVG(price)
        FROM titles
        WHERE type = @CategoryName;
    END
END;
GO

-- Example execution of the procedure
EXEC IncreasePriceUntilAvg 'Business', 20.22;