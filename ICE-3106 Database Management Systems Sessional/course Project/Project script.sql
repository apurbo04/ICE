-- Library Database SQL Script
-- Create Database
CREATE DATABASE LibraryManagement5;
GO

USE LibraryManagement5;
GO

-- Create Tables
CREATE TABLE ReaderDetails
(
    Reader_ID CHAR(6) PRIMARY KEY CHECK (Reader_ID LIKE 'RE____'),
    Name VARCHAR(50) NOT NULL,
    Reader_Address VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(15) CHECK (Phone_Number LIKE '01%'),
    Gender CHAR(1) CHECK (Gender IN ('M','F'))
);

CREATE TABLE BookCollection
(
    Book_ID CHAR(6) PRIMARY KEY CHECK (Book_ID LIKE 'BK____'),
    Book_Name VARCHAR(100) NOT NULL,
    BorrowedDate DATE,
    ReturnDate DATE,
    Quantity_available INT CHECK(Quantity_available >= 0)
);

CREATE TABLE Borrow
(
    Borrowed_ID INT PRIMARY KEY IDENTITY(1,1),
    Reader_ID CHAR(6) NOT NULL,
    Book_ID CHAR(6) NOT NULL,
    Enrollment_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Reader FOREIGN KEY (Reader_ID) REFERENCES ReaderDetails(Reader_ID),
    CONSTRAINT FK_Book FOREIGN KEY (Book_ID) REFERENCES BookCollection(Book_ID)
);
GO

-- Insert Dummy Data
INSERT INTO ReaderDetails (Reader_ID, Name, Reader_Address, Phone_Number, Gender)
VALUES
('RE0001', 'Rahim Uddin', 'Dhaka', '01712345678', 'M'),
('RE0002', 'Nusrat Jahan', 'Chittagong', '01887654321', 'F'),
('RE0003', 'Karim Ahmed', 'Rajshahi', '01911112222', 'M'),
('RE0004', 'Afsana Begum', 'Khulna', '01655554444', 'F'),
('RE0005', 'Tanvir Hasan', 'Sylhet', '01599998888', 'M');

INSERT INTO BookCollection (Book_ID, Book_Name, BorrowedDate, ReturnDate, Quantity_available)
VALUES
('BK0001', 'Pride and Prejudice by Jane Austen', '2025-10-01', '2025-10-15', 10),
('BK0002', 'The Great Gatsby by F. Scott Fitzgerald', '2025-10-01', '2025-10-15', 50),
('BK0003', 'The Hunger Games by Suzanne Collins', '2025-10-01', '2025-10-15', 100),
('BK0004', 'To Kill a Mockingbird by Harper Lee', '2025-10-01', '2025-10-15', 30),
('BK0005', '1984 by George Orwell', '2025-10-01', '2025-10-15', 75);

INSERT INTO Borrow (Reader_ID, Book_ID)
VALUES
('RE0001', 'BK0001'),
('RE0002', 'BK0002'),
('RE0003', 'BK0003'),
('RE0004', 'BK0004'),
('RE0005', 'BK0005');
GO

-- View Data
SELECT * FROM ReaderDetails;
SELECT * FROM BookCollection;
SELECT * FROM Borrow;
GO

-- Update Phone Number of Reader
UPDATE ReaderDetails
SET Phone_Number = '01699998888'
WHERE Reader_ID = 'RE0001';
SELECT * FROM ReaderDetails;
GO

-- Simple procedure: borrow one copy of a book
CREATE PROCEDURE usp_BorrowBook_Simple
    @ReaderID CHAR(6),
    @BookID CHAR(6)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1) validate reader
    IF NOT EXISTS (SELECT 1 FROM ReaderDetails WHERE Reader_ID = @ReaderID)
    BEGIN
        PRINT 'Reader not found.';
        RETURN;
    END

    -- 2) validate book
    IF NOT EXISTS (SELECT 1 FROM BookCollection WHERE Book_ID = @BookID)
    BEGIN
        PRINT 'Book not found.';
        RETURN;
    END

    -- 3) check availability
    DECLARE @Qty INT;
    SELECT @Qty = Quantity_available FROM BookCollection WHERE Book_ID = @BookID;

    IF @Qty IS NULL OR @Qty <= 0
    BEGIN
        PRINT 'Book not available.';
        RETURN;
    END

    -- 4) insert borrow record
    INSERT INTO Borrow (Reader_ID, Book_ID)
    VALUES (@ReaderID, @BookID);

    -- 5) decrement quantity
    UPDATE BookCollection
    SET Quantity_available = Quantity_available - 1
    WHERE Book_ID = @BookID;

    -- 6) return inserted Borrowed_ID and new quantity
    SELECT SCOPE_IDENTITY() AS Borrowed_ID,
           (SELECT Quantity_available FROM BookCollection WHERE Book_ID = @BookID) AS NewQuantity;
END
GO


-- check current quantity for BK0001
SELECT Book_ID, Book_Name, Quantity_available FROM BookCollection WHERE Book_ID = 'BK0001';

-- Borrow the book
EXEC usp_BorrowBook_Simple @ReaderID = 'RE0001', @BookID = 'BK0001';

-- verify change
SELECT Book_ID, Book_Name, Quantity_available FROM BookCollection WHERE Book_ID = 'BK0001';
SELECT * FROM Borrow WHERE Reader_ID = 'RE0001' AND Book_ID = 'BK0001';
GO



-- Trigger to Update Quantity Available
CREATE TRIGGER trg_UpdateQuantity
ON Borrow
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE B
    SET B.Quantity_available = B.Quantity_available - I.Quantity
    FROM BookCollection B
    INNER JOIN (
        SELECT Book_ID, COUNT(*) AS Quantity
        FROM inserted
        GROUP BY Book_ID
    ) I ON B.Book_ID = I.Book_ID;
END;
GO


-- Insert new borrow record
INSERT INTO Borrow (Reader_ID, Book_ID)
VALUES ('RE0001', 'BK0001');

-- Check updated book collection
SELECT * FROM BookCollection;
