CREATE DATABASE Library_Management_System;
GO
USE Library_Management_System;
GO

CREATE TABLE Members(
Member_ID INT PRIMARY KEY,
Member_Name NVARCHAR(20) NOT NULL,
Email NVARCHAR(50) NOT NULL UNIQUE,
Phone_Num NVARCHAR(15) NOT NULL,
);

CREATE TABLE Books(
Book_ID INT PRIMARY KEY,
Book_name NVARCHAR(150) NOT NULL,
Author NVARCHAR(50) NOT NULL,
ISBN NVARCHAR(20) UNIQUE,
Status NVARCHAR(20) DEFAULT 'Available'
);

CREATE TABLE Borrow_Records(
Borrow_Num INT PRIMARY KEY,
Member_ID INT,
Book_ID INT,
Borrow_Date DATE NOT NULL,
Return_Date DATE NOT NULL,
Fine_Value DECIMAL(5,2) DEFAULT 0,
FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);


INSERT INTO Members (Member_ID, Member_Name, Email, Phone_Num)
VALUES ('1', 'Ziad', 'Ziad@gmail.com', '011'),
       ('2', 'Zoz', 'zoz@gmail.com', '012');

INSERT INTO Books (Book_ID, Book_name, Author, ISBN)
VALUES ('1', 'python', 'Devolper', '1234567890'),
       ('2', 'c++', 'Dev2', '02134567'),
	   ('3', 'Data Base', 'Dev5', '0218437');

GO

CREATE PROCEDURE Borrow_Book
    @Member_ID INT,
    @Book_ID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Books WHERE Book_ID = @Book_ID AND Status = 'Available')
    BEGIN
        INSERT INTO Borrow_Records (Member_ID, Book_ID, Borrow_Date)
        VALUES (@Member_ID, @Book_ID, GETDATE());

        UPDATE Books
        SET Status = 'Borrowed'
        WHERE Book_ID = @Book_ID;

        PRINT 'Book Borrowed';
    END
    ELSE
    BEGIN
        PRINT 'Book Is Not Available';
    END
END;

GO

CREATE PROCEDURE Return_Book
    @Borrow_ID INT
AS
BEGIN
    DECLARE @Book_ID INT;
    DECLARE @Due_Date DATE;
    DECLARE @Fine DECIMAL(5,2);

    SELECT @Book_ID = Book_ID, @Due_Date = Borrow_Date FROM Borrow_Records WHERE @Borrow_ID = @Borrow_ID;

    --Assuming 14-day borrowing period
    SET @Fine = CASE 
                    WHEN DATEDIFF(DAY, @Due_Date, GETDATE()) > 14 
                    THEN (DATEDIFF(DAY, @Due_Date, GETDATE()) - 14) * 2 
                    ELSE 0 
                END;

    UPDATE Borrow_Records
    SET Return_Date = GETDATE(), Fine_Value = @Fine
    WHERE @Borrow_ID = @Borrow_ID;

    UPDATE Books
    SET Status = 'Available'
    WHERE Book_ID = @Book_ID;

    PRINT 'Book Returned' + CAST(@Fine AS NVARCHAR);
END;

