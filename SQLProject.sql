USE LibraryMS
SELECT * FROM LibraryMS;

CREATE TABLE Book_Loans (
	BookID INT NOT NULL CONSTRAINT fk_book_id2 FOREIGN KEY REFERENCES Book(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT NOT NULL CONSTRAINT fk_Brand_id FOREIGN KEY REFERENCES Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	CardNo INT NOT NULL CONSTRAINT fk_Card_No FOREIGN KEY REFERENCES Borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	DateOut DATE NOT NULL,
	DueDate DATE NOT NULL
);

CREATE TABLE Library_Branch (
	BranchID INT PRIMARY KEY NOT NULL IDENTITY,
	Branch_Name VARCHAR(70) NOT NULL,
	Address VARCHAR(70) NOT NULL
);

SELECT * FROM Publisher;

CREATE TABLE Borrower (
	CardNO INT PRIMARY KEY NOT NULL IDENTITY(5000,1),
	Name VARCHAR(70) NOT NULL,
	Address VARCHAR(70) NOT NULL,
	Phone VARCHAR(20) NOT NULL
);

CREATE TABLE Book_Copies (
	BookID INT NOT NULL CONSTRAINT fk_book_id3 FOREIGN KEY REFERENCES Book(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT NOT NULL CONSTRAINT fk_branch_id2 FOREIGN KEY REFERENCES Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	Address VARCHAR(70) NOT NULL
);

INSERT INTO Book
	(Title, PublisherName)
	VALUES
	('Mountain Last', 'Win-Re')
;

INSERT INTO Publisher
	(Name, Address, Phone)
	VALUES
	('Scribner', '2626 Rally Rd', '125-843-0180') 
;	

INSERT INTO Book_Authors
	(BookID, AuthorName)
	VALUES
	('4', 'Matt Brandyl'),
	('2', 'Jerry Torbin'),
	('3', 'Candy Flare'),
	('5', 'Vinny Brady'),
	('6', 'Patty Cobins'),
	('7', 'Robin Voher'),
	('8', 'Joe Marks'),
	('9', 'Danny Robers'),
	('10', 'Lisa Tessly'),
	('11', 'Aaron Odges'),
	('12', 'Adam Row'),
	('13', 'Jeff Kecker'),
	('14', 'Ian Wolfere'),
	('15', 'Justin Gobbs'),
	('16', 'Josh Downs'),
	('17', 'Katie Brower'),
	('18', 'Valerie Gunst'),
	('19', 'Howard Dornist'),
	('20', 'Jessica Sable'),
	('21', 'Gina Hopkins'),
	('22', 'Robert Edwin'),
	('23', 'Walter Williams'),
	('26', 'Kirk Douglas')

;

INSERT INTO Library_Branch
	(Branch_Name, Address)
	VALUES
	('Honors', '154 Hillman Ln'),
	('Frader', '7845 Apple Rd')
;


SELECT * FROM Book_Copies

INSERT INTO Book_Copies
	(BookID, BranchID, No_of_Copies)
	VALUES
	('25', '1', '3'),
	('24', '1', '2')
;

INSERT INTO Borrower
	(Name, Address, Phone)
	VALUES
	('Jason Argett', '2559 Orville Av', '900-325-8637')
;

INSERT INTO Book_Loans
	(BookID, BranchID, CardNo, DateOut, DueDate)
	VALUES
	('6','2','5005','2018-01-18','2018-02-06');
	('23','2','5005','2018-02-01','2018-02-19'),
	('22','2','5005','2018-02-01','2018-02-19'),
	('20','2','5005','2018-02-01','2018-02-19'),
	('18','2','5005','2018-02-01','2018-02-19'),
	('17','2','5005','2018-02-01','2018-02-19'),
	('13','2','5006','2018-01-30','2018-02-17'),
	('13','2','5006','2018-01-30','2018-02-17'),
	('11','2','5006','2018-01-30','2018-02-17'),
	('9','2','5006','2018-01-30','2018-02-17'),
	('6','2','5006','2018-01-30','2018-02-17'),
	('4','2','5007','2018-01-02','2018-01-20'),
	('18','2','5007','2018-01-02','2018-01-20'),
	('16','1','5007','2018-01-02','2018-01-20'),
	('15','1','5007','2018-01-04','2018-01-22'),
	('14','1','5007','2018-01-04','2018-01-22'),
	('12','1','5008','2018-02-01','2018-02-19'),
	('10','1','5008','2018-02-01','2018-02-19'),
	('8','1','5008','2018-01-30','2018-02-17'),
	('7','1','5008','2018-01-30','2018-02-17'),
	('5','1','5008','2018-01-28','2018-02-15'),
	('3','1','5009','2018-02-04','2018-02-22'),
	('2','1','5009','2018-02-04','2018-02-22'),
	('7','1','5009','2018-02-03','2018-02-21'),
	('8','1','5009','2018-02-03','2018-02-21'),
	('24','3','5000','2018-01-21','2018-02-08'),
	('25','3','5000','2018-01-23','2018-02-10'),
	('21','3','5000','2018-01-23','2018-02-10'),
	('5','4','5000','2018-02-03','2018-02-21'),
	('25','4','5000','2018-02-03','2018-02-21'),
	('24','4','5000','2018-02-03','2018-02-21');
	




USE LibraryMS
GO

CREATE PROC PROC01
AS

SELECT 
	Library_Branch.Branch_Name,
	Book.Title, 
	Book_Copies.No_of_Copies 
FROM 
	Book_Copies
	INNER JOIN Book ON Book.BookID = Book_Copies.BookID
	INNER JOIN Library_Branch ON Library_Branch.BranchID = Book_Copies.BranchID
WHERE 
	Book.Title = 'The Lost Tribe' AND
	Library_Branch.Branch_Name = 'Sharpstown'
;
GO

EXEC PROC01


USE LibraryMS
GO

CREATE PROC PROC02
AS

SELECT 
	Library_Branch.Branch_Name,
	Book.Title,
	Book_Copies.No_of_Copies

FROM 
	Book_Copies
	INNER JOIN Library_Branch ON Library_Branch.BranchID = Book_Copies.BranchID 
	INNER JOIN Book ON Book.BookID = Book_Copies.BookID
WHERE 
	Book.Title = 'The Lost Tribe'
;
GO

EXEC PROC02


USE LibraryMS
GO

CREATE PROC PROC3
AS

SELECT 
	Borrower.name
FROM 
	Borrower
	LEFT JOIN Book_Loans ON Book_Loans.CardNo = Borrower.CardNO
WHERE 
	Book_Loans.CardNo is NULL    
;
GO   

EXEC PROC3


USE LibraryMS
GO

CREATE PROC PROC4
AS

SELECT 
	Book.Title, 
	Borrower.Name, 
	Borrower.Address
FROM
	Book_Loans
	INNER JOIN Book ON Book.BookID = Book_Loans.BookID
	INNER JOIN Borrower ON Borrower.CardNO = Book_Loans.CardNo 
	INNER JOIN Library_Branch ON Library_Branch.BranchID = Book_Loans.BranchID 
WHERE
	Library_Branch.Branch_Name = 'Sharpstown' AND
	Book_Loans.DueDate = CONVERT(DATE, GETDATE())
;
GO	

EXEC PROC4


USE LibraryMS
GO

CREATE PROC PROC5
AS

SELECT 
	Library_Branch.Branch_Name,
	COUNT(*) AS Books_Borrowed
FROM 
	Library_Branch
	INNER JOIN Book_Loans ON Book_Loans.BranchID = Library_Branch.BranchID
GROUP BY 
	Library_Branch.Branch_Name, 
	Book_Loans.BranchID HAVING COUNT(*) > 0
;
GO

EXEC PROC5


USE LibraryMS
GO

CREATE PROC PROC6
AS

SELECT 
	Borrower.Name,
	Borrower.Address,
	COUNT(*) AS Books_Borrowed
FROM 
	Borrower
	INNER JOIN Book_Loans ON Book_Loans.CardNo = Borrower.CardNO
GROUP BY 
	Borrower.Name,
	Borrower.Address, 
	Book_Loans.CardNo HAVING COUNT(*) > 5  
;
GO

EXEC PROC6


USE LibraryMS
GO

CREATE PROC PROC7
AS

SELECT 
	Book.Title, 
	Book_Copies.No_of_Copies
FROM 
	Book
	INNER JOIN Book_Authors ON Book_Authors.BookID = Book.BookID
	INNER JOIN Book_Copies ON Book_Copies.BookID = Book.BookID
	INNER JOIN Library_Branch ON Library_Branch.BranchID = Book_Copies.BranchID
WHERE 
	Book_Authors.AuthorName = 'Stephen King' AND
	Library_Branch.Branch_Name = 'Central'
;
GO		

EXEC PROC7
	


