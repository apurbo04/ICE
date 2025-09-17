CREATE PROC sp_show
AS
BEGIN
SELECT "Authors Last Name" = au_lname From authors where au_id ='BU1032'
END
GO

EXEC sp_show

DROP PROC sp_show
GO

-- dis.3.decision making/ looping constructs
CREATE PROC sp_updatePrice @titleid char(15)
AS
BEGIN
	DECLARE @price MONEY
	SELECT @price = price from TITLES 
	WHERE title_id=@titleid
	set @price = @price + 0.1*@price
	IF @price<=20
	UPDATE 
	titles SET price = @price 
	WHERE title_id = @titleid
END
GO

EXEC sp_updatePrice 'BU7832'
GO


-- T.1.Write a stored procedure that prints out item categories, total number of items available and
-- average price of that category in the following format.

create proc sp_TaskOne
as
begin
select "Category" = item_category, 
"Total number of items" = count(item_id), 
"Average Price" = AVG(item_price) 
from item group by item_category
end

-- task.2.Write a stored procedure that
-- a) accepts as two inputs, i.e., i) category name and ii) price value
-- b) And shows the item details under that category that are cheaper than the acceptedprice value

create proc sp_TaskTwo @categoryname char(10), @pricevalue real
as
begin
select * from item 
where item_category=@categoryname 
and item_price < @pricevalue
end

-- task.3.Write a stored procedure that
-- a) Accepts as input i) category name and ii) desired average price value
-- b) And increase the price of each item under that category by 10% until the new average price crosses the desired average price value.

-- a)
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

-- b) Stored Procedure to increase price until desired average
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