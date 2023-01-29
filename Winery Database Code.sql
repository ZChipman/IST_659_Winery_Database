/*
The following drops will assist in making a script
that can be repeated without error.
*/

-- Procedure Drops
DROP PROCEDURE IF EXISTS dbo.ChangeRating;
go

DROP PROCEDURE IF EXISTS dbo.ChangeStatus;
go

-- View Drops
DROP VIEW IF EXISTS dbo.ClientTypes;
go

DROP VIEW IF EXISTS dbo.Top3Wines;
go

DROP VIEW IF EXISTS dbo.AllRatings;
go

DROP VIEW IF EXISTS dbo.OrderForms;
go

-- Funnction Drops
DROP FUNCTION IF EXISTS dbo.WineSalesFunction;
go

-- Table Drops
DROP TABLE IF EXISTS OrderForm;
go

DROP TABLE IF EXISTS WineClient;
go

DROP TABLE IF EXISTS Wine;
go

DROP TABLE IF EXISTS VineyardVintage;
go

DROP TABLE IF EXISTS VineyardVarietal;
go

DROP TABLE IF EXISTS OrderStatus;
go

DROP TABLE IF EXISTS Clients;
go

DROP TABLE IF EXISTS Barrel;
go

DROP TABLE IF EXISTS Vintage;
go

DROP TABLE IF EXISTS Varietal;
go

DROP TABLE IF EXISTS Vineyard;
go

-- create all tables in order of their dependencies

CREATE TABLE Vineyard
(
   -- Add columns
   vineyard_ID int NOT NULL IDENTITY,
   vineyard_name varchar(30) NOT NULL,
   -- Add constraints
   CONSTRAINT PK_Vineyard PRIMARY KEY (vineyard_ID),
   CONSTRAINT U1_Vineyard UNIQUE (vineyard_name)
);
go

CREATE TABLE Varietal
(
   -- Add columns
   varietal_ID int NOT NULL IDENTITY,
   varietal_name varchar(30) NOT NULL,
   -- Add constraints
   varietal_color varchar(10) NOT NULL,
   CONSTRAINT PK_Varietal PRIMARY KEY (varietal_ID),
   CONSTRAINT U1_Varietal UNIQUE (varietal_name)
);
go

CREATE TABLE Vintage
(
   -- Add columns
   vintage_ID int NOT NULL IDENTITY,
   vintage_year int NOT NULL,
   -- Add constraints
   CONSTRAINT PK_Vintage PRIMARY KEY (vintage_ID)
  
);
go

CREATE TABLE Barrel
(
   -- Add columns
   barrel_ID int NOT NULL IDENTITY,
   oak_type varchar(10),
   -- Add constraints
   CONSTRAINT PK_Barrel PRIMARY KEY (Barrel_ID)
  
);
go

CREATE TABLE Clients
(
   -- Add columns
   client_ID int NOT NULL IDENTITY,
   client_type varchar(15) NOT NULL,
   client_name varchar(50) NOT NULL,
   [address] varchar(100) NOT NULL,
   telephone_number varchar(20) NOT NULL,
   sales_quantity int,
   -- Add constraints
   CONSTRAINT PK_Client PRIMARY KEY (client_ID),
   CONSTRAINT U1_Client UNIQUE ([address], telephone_number)
);
go

CREATE TABLE OrderStatus
(
   -- Add columns
   order_status_ID int NOT NULL IDENTITY,
   order_status varchar(20) NOT NULL,
   -- Add constraints
   CONSTRAINT PK_Order_Status PRIMARY KEY (order_status_ID)
);
go

CREATE TABLE VineyardVarietal
(
   -- Add columns
   vineyard_varietal_ID int NOT NULL IDENTITY,
   vineyard_ID int NOT NULL,
   varietal_ID int NOT NULL,
   -- Add constraints
   CONSTRAINT PK_VineyardVarietal PRIMARY KEY (vineyard_varietal_ID),
   CONSTRAINT FK1_VineyardVarietal FOREIGN KEY (vineyard_ID) REFERENCES Vineyard (vineyard_ID),
   CONSTRAINT FK2_VineyardVarietal FOREIGN KEY (varietal_ID) REFERENCES Varietal (varietal_ID)
);
go

CREATE TABLE VineyardVintage
(
   -- Add columns
   vineyard_vintage_ID int NOT NULL IDENTITY,
   vineyard_ID int NOT NULL,
   vintage_ID int NOT NULL,
   -- Add constraints
   CONSTRAINT PK_VineyardVintage PRIMARY KEY (vineyard_vintage_ID),
   CONSTRAINT FK1_VineyardVintage FOREIGN KEY (vineyard_ID) REFERENCES Vineyard (vineyard_ID),
   CONSTRAINT FK2_VineyardVintage FOREIGN KEY (vintage_ID) REFERENCES Vintage (vintage_ID)
);
go

CREATE TABLE Wine
(
   -- Add columns
   wine_ID int NOT NULL IDENTITY,
   varietal_ID int NOT NULL,
   vintage_ID int NOT NULL,
   barrel_ID int NOT NULL,
   wine_name varchar(50),
   price decimal(4,2) NOT NULL,
   quantity_sold int NOT NULL,
   average_rating decimal(3,2) NOT NULL,
   -- Add constraints
   CONSTRAINT PK_Wine PRIMARY KEY (wine_ID),
   CONSTRAINT FK1_Wine FOREIGN KEY (varietal_ID) REFERENCES Varietal (varietal_ID),
   CONSTRAINT FK2_Wine FOREIGN KEY (vintage_ID) REFERENCES Vintage (vintage_ID),
   CONSTRAINT FK3_Wine FOREIGN KEY (barrel_ID) REFERENCES Barrel (barrel_ID)
);
go


CREATE TABLE WineClient
(
   -- Add columns
   wine_client_ID int NOT NULL IDENTITY,
   wine_ID int NOT NULL,
   client_ID int NOT NULL,
   -- Add constraints
   CONSTRAINT PK_WineClient PRIMARY KEY (wine_client_ID),
   CONSTRAINT FK1_WineClient FOREIGN KEY (wine_ID) REFERENCES Wine (wine_ID),
   CONSTRAINT FK2_WineClient FOREIGN KEY (client_ID) REFERENCES Clients (client_ID)
);
go


CREATE TABLE OrderForm
(
   -- Add columns
   order_ID int NOT NULL IDENTITY,
   quantity int NOT NULL,
   -- Is datetime the right variable for this
   order_date datetime NOT NULL,
   wine_ID int NOT NULL,
   client_ID int NOT NULL,
   order_status_ID int NOT NULL,
   -- Add constraints
   CONSTRAINT PK_OrderForm PRIMARY KEY (order_id),
   CONSTRAINT FK1_OrderForm FOREIGN KEY (wine_ID) REFERENCES Wine (wine_ID),
   CONSTRAINT FK2_OrderForm FOREIGN KEY (client_ID) REFERENCES Clients (client_ID),
   CONSTRAINT FK3_OrderForm FOREIGN KEY (order_status_ID) REFERENCES OrderStatus (order_status_ID)
);
go

/*
We will now insert records into tables.
*/

-- Insert vineyard names into the Vineyard Table.
INSERT Vineyard (vineyard_name)
VALUES  ('Violet Crown'), ('A Squared'), ('East Bay');
go

-- Insert varietal information into the Varietal table.
INSERT Varietal (varietal_name, varietal_color)
VALUES  ('Riesling', 'White'),
       ('Chardonnay', 'White'),
       ('Sauvignon Blanc', 'White'),
       ('Pinot Noir', 'Red'),
       ('Merlot', 'Red'),
       ('Cabernet Sauvignon', 'Red');
go

-- Insert the vintages into the Vintage table.
INSERT Vintage (vintage_year)
VALUES  (2016), (2017), (2018);
go

-- Insert the oak types into the Barrel table.
INSERT Barrel (oak_type)
VALUES  ('American'), ('French');
go

-- Insert the client information into the Clients table.
INSERT Clients (client_type, client_name, [address], telephone_number, sales_quantity)
VALUES  ('Restaurant', 'Flagship Steakhouse', '6579 Python Street', '(679)564-2458', 84809),
       ('Retail', 'Grape Savings Store', '3092 Java Drive', '(546)085-0188', 70066),
       ('Customer', 'Bill Dalton', '6831 Tableau Avenue', '(533)422-7465', NULL),
       ('Restaurant', 'The Red Apple', '2352 Unix Boulevard', '(684)279-6530', 64779),
       ('Retail', 'The Vine Dispatch', '3648 Oracle Avenue', '(257)208-4486', 50909),
       ('Customer', 'Margot Brown', '1923 Ruby Road', '(304)343-0332', NULL);
go

-- Insert the order statuses into the OrderStatus table. 
INSERT OrderStatus (order_status)
VALUES ('OPEN'), ('CLOSED');
go

-- Insert values into the VineyardVarietal bridge table.
INSERT VineyardVarietal (vineyard_ID, varietal_ID)
VALUES  ((SELECT vineyard_ID FROM Vineyard WHERE vineyard_name = 'Violet Crown'), (SELECT Varietal_ID FROM Varietal WHERE varietal_name = 'Merlot')),
       ((SELECT vineyard_ID FROM Vineyard WHERE vineyard_name = 'Violet Crown'), (SELECT Varietal_ID FROM Varietal WHERE varietal_name = 'Cabernet Sauvignon')),
       ((SELECT vineyard_ID FROM Vineyard WHERE vineyard_name = 'A Squared'), (SELECT Varietal_ID FROM Varietal WHERE varietal_name = 'Chardonnay')),
       ((SELECT vineyard_ID FROM Vineyard WHERE vineyard_name = 'A Squared'), (SELECT Varietal_ID FROM Varietal WHERE varietal_name = 'Pinot Noir')),
       ((SELECT vineyard_ID FROM Vineyard WHERE vineyard_name = 'East Bay'), (SELECT Varietal_ID FROM Varietal WHERE varietal_name = 'Riesling')),
       ((SELECT vineyard_ID FROM Vineyard WHERE vineyard_name = 'East Bay'), (SELECT Varietal_ID FROM Varietal WHERE varietal_name = 'Sauvignon Blanc'));
go

-- Insert values into the VineyardVintage bridge table.
INSERT VineyardVintage (vineyard_ID, vintage_ID)
SELECT Vnrd.vineyard_ID, Vntge.vintage_ID
FROM (
   VALUES
   ('Violet Crown', 2016),
   ('Violet Crown', 2017),
   ('Violet Crown', 2018),
   ('A Squared', 2016),
   ('A Squared', 2017),
   ('A Squared', 2018),
   ('East Bay', 2016),
   ('East Bay', 2017),
   ('East Bay', 2018)
   ) AS VVintageConstruction(vineyard_name,vintage_year)
LEFT OUTER JOIN Vineyard AS Vnrd ON Vnrd.vineyard_name = VVintageConstruction.vineyard_name
LEFT OUTER JOIN Vintage AS Vntge ON Vntge.vintage_year = VVintageConstruction.vintage_year;
go

-- Insert values into the Wine Table
INSERT Wine (wine_name, varietal_ID, vintage_ID, barrel_ID, price, quantity_sold, average_rating)
SELECT Wine_Name, Vari.varietal_ID, Vntge.vintage_ID, Bar.barrel_ID, Price, Quantity_Sold, Average_Rating
FROM (
   VALUES
   ('Riesling 2016', 'Riesling', 2016, 'French', 12.99, 62326, 1.92),
   ('Riesling 2017', 'Riesling', 2017, 'French', 15.99, 65754, 3.79),
   ('Riesling 2018', 'Riesling', 2018, 'French', 13.99, 69873, 1.21),
   ('Chardonnay 2016', 'Chardonnay', 2016, 'American', 16.99, 53589, 3.09),
   ('Chardonnay 2017', 'Chardonnay', 2017, 'American', 10.99, 52505, 2.17),
   ('Chardonnay 2018', 'Chardonnay', 2018, 'American', 20.99, 77774, 4.32),
   ('Sauvignon Blanc 2016', 'Sauvignon Blanc', 2016, 'American', 11.99, 67018, 3.83),
   ('Sauvignon Blanc 2017', 'Sauvignon Blanc', 2017, 'American', 12.99, 61501, 1.01),
   ('Sauvignon Blanc 2018', 'Sauvignon Blanc', 2018, 'American', 14.99, 81863, 4.70),
   ('Pinot Noir 2016', 'Pinot Noir', 2016, 'French', 18.99, 51426, 4.37),
   ('Pinot Noir 2017', 'Pinot Noir', 2017, 'French', 16.99, 91641, 2.03),
   ('Pinot Noir 2018', 'Pinot Noir', 2018, 'French', 22.99, 51293, 2.37),
   ('Merlot 2016', 'Merlot', 2016, 'French', 12.99, 73491, 3.16),
   ('Merlot 2017', 'Merlot', 2017, 'French', 10.99, 58546, 2.92),
   ('Merlot 2018', 'Merlot', 2018, 'French', 20.99, 51703, 2.69),
   ('Cabernet Sauvignon 2016', 'Cabernet Sauvignon', 2016, 'American', 26.99, 88856, 4.63),
   ('Cabernet Sauvignon 2017', 'Cabernet Sauvignon', 2017, 'American', 30.99, 79397, 3.31),
   ('Cabernet Sauvignon 2018', 'Cabernet Sauvignon', 2018, 'American', 28.99, 56086, 3.84)
   ) AS WineConstruction(wine_name, varietal_name, vintage_year, oak_type, price, quantity_sold, average_rating)
LEFT OUTER JOIN Varietal AS Vari ON Vari.varietal_name = WineConstruction.varietal_name
LEFT OUTER JOIN Vintage AS Vntge ON Vntge.vintage_year = WineConstruction.vintage_year
LEFT OUTER JOIN Barrel AS Bar ON Bar.oak_type = WineConstruction.oak_type;
go

-- Insert values into the WineClient Table
INSERT WineClient (client_ID, wine_ID)
SELECT Cli.client_ID, Win.wine_ID
FROM (
   VALUES
   ('Flagship Steakhouse', 'Riesling 2017'),
   ('The Vine Dispatch', 'Pinot Noir 2017'),
   ('The Red Apple', 'Cabernet Sauvignon 2017'),
   ('Margot Brown', 'Pinot Noir 2018'),
   ('The Vine Dispatch', 'Sauvignon Blanc 2017'),
   ('Bill Dalton', 'Cabernet Sauvignon 2016'),
   ('The Vine Dispatch', 'Riesling 2018'),
   ('The Red Apple', 'Chardonnay 2018'),
   ('Grape Savings Store', 'Sauvignon Blanc 2016'),
   ('Bill Dalton', 'Merlot 2016')
   ) AS WinCliConstruction(client_name, wine_name)
LEFT OUTER JOIN Wine AS Win ON Win.wine_name = WinCliConstruction.wine_name
LEFT OUTER JOIN Clients AS Cli ON Cli.client_name = WinCliConstruction.client_name;
go


INSERT OrderForm (client_ID, wine_ID, quantity, order_date, order_status_ID)
SELECT Cli.client_ID, Win.wine_ID, Quantity, Order_Date, Stat.order_status_ID
FROM (
   VALUES
   ('Flagship Steakhouse', 'Riesling 2017', 240, '12-30-2019', 'OPEN'),
   ('The Vine Dispatch', 'Pinot Noir 2017', 204, '10-20-2019', 'CLOSED'),
   ('The Red Apple', 'Cabernet Sauvignon 2017', 156, '8-25-2019', 'CLOSED'),
   ('Margot Brown', 'Pinot Noir 2018', 7, '5-18-2019', 'CLOSED'),
   ('The Vine Dispatch', 'Sauvignon Blanc 2017', 216, '10-20-2019', 'CLOSED'),
   ('Bill Dalton', 'Cabernet Sauvignon 2016', 8, '9-5-2019', 'CLOSED'),
   ('The Vine Dispatch', 'Riesling 2018', 180, '10-20-2019', 'CLOSED'),
   ('The Red Apple', 'Chardonnay 2018', 204, '8-30-2019', 'CLOSED'),
   ('Grape Savings Store', 'Sauvignon Blanc 2016', 216, '7-20-2019', 'CLOSED'),
   ('Bill Dalton', 'Merlot 2016', 9, '8-12-2019', 'CLOSED')
   ) AS OrderConstruction(client_name, wine_name, quantity, order_date, order_status)
LEFT OUTER JOIN Clients AS Cli ON Cli.client_name = OrderConstruction.client_name
LEFT OUTER JOIN Wine AS Win ON Win.wine_name = OrderConstruction.wine_name
LEFT OUTER JOIN OrderStatus AS Stat On Stat.order_status = OrderConstruction.order_status;
go

/*
As we transition the data from the spreadsheets to the 
database, we notice that the status of one of the orders 
has been left open by accident. To fix this, we have 
created a procedure that changes an order's status from 
"OPEN" to "CLOSED." This procedure will also be used to 
close future orders as well. 
*/

/*
First, we will create a view of the OrderForm
table that will be easier to read.
*/
CREATE OR ALTER VIEW dbo.OrderForms
AS
SELECT
	OrderForm.order_ID AS OrderID,
	Clients.client_name AS ClientName,
	OrderForm.order_date AS [Date],
	Wine.wine_name AS WineName,
	OrderForm.quantity AS Quantity,
	OrderStatus.order_status AS [Status]
FROM OrderForm
JOIN Clients ON Clients.client_ID = OrderForm.client_ID
JOIN Wine ON Wine.wine_Id = OrderForm.wine_ID
JOIN OrderStatus ON OrderStatus.order_status_ID = OrderForm.order_status_ID
go

-- The first order is the one that is still open.
SELECT * FROM dbo.OrderForms
go

CREATE PROCEDURE dbo.ChangeStatus (@order_ID int)
AS
BEGIN
       DECLARE @status_ID int
       SELECT @status_ID = OrderForm.order_status_ID FROM OrderForm
       JOIN OrderStatus ON OrderStatus.order_status_ID = OrderForm.order_status_ID
       WHERE OrderStatus.order_status = 'CLOSED'

       UPDATE OrderForm
       SET    order_status_ID = @status_ID
       WHERE order_ID = @order_ID
END
go

DECLARE @OrderID int
SET @OrderID = 1
EXEC dbo.ChangeStatus 1
go

-- Check to see if the procedure was successful.
SELECT * FROM dbo.OrderForms
go

/*
As time passes and more people are drinking the wines,
the rating of the winery will change. 
This procedure will provide the means of updating the 
average rating of the wines. 
*/

CREATE PROCEDURE dbo.ChangeRating(@wine_name varchar(50), @newrating decimal(3,2))
AS
BEGIN
       UPDATE Wine SET average_rating = @newrating
       WHERE wine_name = @wine_name
END
go 

/*
In this instance, the 2018 Chardonnay is not as well 
precieved as it was when the average rating was last
calculated so we need to change the rating from a
4.32 to a 4.04
*/

-- Now we'll see if the procedure works as intended.
SELECT wine_name AS WineName, average_rating AS AverageRating
FROM Wine
WHERE wine_name = 'Chardonnay 2018'
go

EXEC dbo.ChangeRating 'Chardonnay 2018', 4.04
go

SELECT wine_name AS WineName, average_rating AS AverageRating
FROM Wine
WHERE wine_name = 'Chardonnay 2018'
go

-- We will now begin to answer the data questions.

/*
Data Question 1: Are sales due to vineyard, varietal, 
vintage, or oak type?

To answer data question 1, we will find the average rating
based on: vineyard rating, varietal rating, vintage rating,
and oak type rating
*/

-- Vineyard Rating Table
SELECT Vineyard.vineyard_name AS Vineyard, AVG(Wine.average_rating) AS VineyardRating
FROM Wine
JOIN Varietal ON Varietal.varietal_ID = Wine.varietal_ID
JOIN VineyardVarietal ON VineyardVarietal.varietal_ID = Varietal.varietal_ID
JOIN Vineyard ON Vineyard.vineyard_ID = VineyardVarietal.vineyard_ID
GROUP BY vineyard_name
ORDER BY AVG(Wine.average_rating) DESC;
go

-- Varietal rating table.
SELECT Varietal.varietal_name AS Varietal, AVG(Wine.average_rating) AS VarietalRating
FROM Wine
JOIN Varietal ON Varietal.varietal_ID = Wine.varietal_ID
GROUP BY varietal_name
ORDER BY AVG(Wine.average_rating) DESC;
go

-- Vintage rating table.
SELECT Vintage.vintage_year AS Vintage, AVG(Wine.average_rating) AS VintageRating
FROM Wine
JOIN Vintage ON Vintage.vintage_ID = Wine.vintage_ID
GROUP BY vintage_year
ORDER BY AVG(Wine.average_rating) DESC;
go

-- Oak Type Rating Table
SELECT Barrel.oak_type AS OakType, AVG(Wine.average_rating) AS BarrelRating
FROM Wine
JOIN Barrel ON Barrel.barrel_ID = Wine.barrel_ID
GROUP BY oak_type
ORDER BY AVG(Wine.average_rating) DESC;
go

-- This will create a view that puts all of the ratings in 
-- one table.
CREATE VIEW dbo.AllRatings AS
	SELECT Vineyard.vineyard_name AS Variable, AVG(Wine.average_rating) AS Rating
	FROM Wine
	JOIN Varietal ON Varietal.varietal_ID = Wine.varietal_ID
	JOIN VineyardVarietal ON VineyardVarietal.varietal_ID = Varietal.varietal_ID
	JOIN Vineyard ON Vineyard.vineyard_ID = VineyardVarietal.vineyard_ID
	GROUP BY vineyard_name
	UNION
	-- Varietal rating table.
	SELECT Varietal.varietal_name AS Variable, AVG(Wine.average_rating) AS Rating
	FROM Wine
	JOIN Varietal ON Varietal.varietal_ID = Wine.varietal_ID
	GROUP BY varietal_name
	UNION
	-- Vintage rating table.
	SELECT CAST(Vintage.vintage_year AS char(4)) AS Variable, AVG(Wine.average_rating) AS Rating
	FROM Wine
	JOIN Vintage ON Vintage.vintage_ID = Wine.vintage_ID
	GROUP BY vintage_year
	UNION
	-- Oak Type Rating Table
	SELECT Barrel.oak_type AS Variable, AVG(Wine.average_rating) AS Rating
	FROM Wine
	JOIN Barrel ON Barrel.barrel_ID = Wine.barrel_ID
	GROUP BY oak_type
go

SELECT * FROM dbo.AllRatings
ORDER BY Rating DESC
go

/*
The variables seem to be well distributed with no 
clear indication of any one factor determing the 
rating of a wine. Cabernet Sauvignon was the 
highest rated grape varietal and the highest 
rated variable overall with a rating close to 4.
2016 was the highest rated vintage, Violet Crown
was the highest rated vineyard, and American was
the highest rated oak type. The majority of the ratings
fall into the 2.5-3.5 range with two exceptions:
The aforementioned Cabernet Sauvignon and Riesling,
which had a measly rating of around 2.3.
*/

/*
Data Question 2: Which wines sell the best?

To answer this question, we will create a function called
"WineSalesFunction" that multiples the "price" and the 
"quantity_sold" objects from the Wine table to get the 
total sales of that wine. We will then select the top 3
wines based on their total sales. This select statement 
will be created as a view in order to create a report in 
access.
*/

Create Function dbo.WineSalesFunction (@wine_id int)
RETURNS decimal AS
BEGIN
       -- Declares a return value
       DECLARE @returnValue decimal

       -- Multiplies the quantity sold and the price to
       -- obtain the total sales
       SELECT @returnValue = quantity_sold * price FROM Wine
       WHERE Wine.wine_ID = @wine_id
      
       RETURN @returnValue
END
go

CREATE VIEW dbo.Top3Wines AS
	SELECT TOP 3
	wine_name AS WineName,
	price AS Price,
	quantity_sold AS QuantitySold,
	average_rating AS AverageRating,
	dbo.WineSalesFunction(wine_ID) AS Sales
	FROM Wine
	ORDER BY SALES DESC
go

SELECT * FROM dbo.Top3Wines
go

/*
Here we see that two of the Cabernets sold the best
followed by the latest vintage of the Chardonnay. 
One thing to keep in mind is that the 2016 Cabernet 
sold nearly 10,000 more units than the 2017 vintage, 
but because the 2017 was four dollars more it sold 
better overall.
*/

/*
Data Question 3: Do the ratings and the sales of a wine
correlate? 

To answer this question, we will select the average rating
from the Wine table and cast the ratings as integers. 

For example:
Wines with a rating of 1.00-1.99 will be floored to 1.
Wines with a rating of 2.00-2.99 will be floored to 2.
and so on...

This will effectively create the rating levels.

We will also select the sum of the WineSalesFunction 
outputs from the Wine table and group by our predefined 
levels.
*/

SELECT cast(average_rating as int) AS RatingLevel, SUM(dbo.WineSalesFunction(wine_ID)) AS TotalSales FROM Wine
GROUP BY cast(average_rating as int)
go

/*
There is a general correlation between the rating of a
wine and its sales. Wines rated as a 3 or a 4 sell
significantly better than those rated a 2 or a 1.
*/

/*
Data Question 4: Which wines sell best for each client 
type? 

To answer this question, we will create a view called
"ClientTypes" that displays the client_name, 
the client_type, the wine_name, 
and the quantity from the OrderForm table. 
The results were ordered first by client_type
and then by quantity in a SELECT statement.
*/

CREATE VIEW dbo.ClientTypes AS
	SELECT client_name AS ClientName, client_type AS ClientType, wine_name WineName, quantity AS Quantity
	FROM OrderForm
	JOIN Clients ON Clients.client_ID = OrderForm.client_ID
	JOIN Wine ON Wine.wine_Id = OrderForm.wine_ID
go

SELECT * FROM dbo.ClientTypes
ORDER BY ClientType DESC, Quantity DESC
go

/*
What the report shows is that red wines are more popular 
amongst customers while in retail/restaurants, whites
are slightly favores over reds. 
*/


/*
Data Question 5: How do the total sales of a wine change 
over time?

To answer this question, we will once again use the 
"WineSalesFunction" to sum up the total sales of all the 
wines for a given vintage.
*/
SELECT Vintage.vintage_year AS Vintage, SUM(dbo.WineSalesFunction(wine_ID)) AS YearlySales
FROM Wine
LEFT JOIN Vintage ON Vintage.vintage_ID = Wine.vintage_ID
GROUP BY Vintage.vintage_year
go

/*
We see a gradual increase in the sales from year to year.
One thing to note is that the increase from 2017 to 2018
was noticeably larger than the increase from 2016 to 
2017. This may be a sign of the exponential growth of the 
winery. 
*/








