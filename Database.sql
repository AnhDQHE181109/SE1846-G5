
IF DB_ID('ApartmentDB') IS NULL
BEGIN
-- Create the database if it does not exist
    CREATE DATABASE ApartmentDB;
END
GO

-- Use the database
USE ApartmentDB;
GO

-- Drop all foreign key constraints and tables if the database already exists
IF DB_ID('ApartmentDB') IS NOT NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) = N'';

    -- Build dynamic SQL to drop all foreign key constraints
    SELECT @sql += 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
                   ' DROP CONSTRAINT ' + QUOTENAME(CONSTRAINT_NAME) + ';'
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_TYPE = 'FOREIGN KEY';

    -- Execute the dynamic SQL to drop foreign key constraints
    EXEC sp_executesql @sql;

    -- Reset the SQL variable for dropping tables
    SET @sql = N'';

    -- Build dynamic SQL to drop all tables
    SELECT @sql += 'DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ';'
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE = 'BASE TABLE';

    -- Execute the dynamic SQL to drop tables
    EXEC sp_executesql @sql;
END
GO

USE ApartmentDB;

-- Create Rolls table first
CREATE TABLE Rolls (
    rollID INT PRIMARY KEY,
    roll_name VARCHAR(10)
);

-- Create Accounts table
CREATE TABLE Accounts (
    userID INT IDENTITY(0,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(50),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    profile_picture_link VARCHAR(255),
    rollID INT,
	birthdate DATE,
    FOREIGN KEY (rollID) REFERENCES Rolls(rollID)
);

-- Create ApartmentTypes table
CREATE TABLE ApartmentTypes (
    typeID INT PRIMARY KEY,
    size VARCHAR(50),
    base_rent DECIMAL(10, 2)
);
-- Create Apartments table
CREATE TABLE Apartments (
    apartmentID INT PRIMARY KEY,
    typeID INT,
    occupied BIT,
    FOREIGN KEY (typeID) REFERENCES ApartmentTypes(typeID),
);

-- Create Residents table
CREATE TABLE Residents (
    residentID INT PRIMARY KEY,
    userID INT,
    apartmentID INT,
    billingdate DATE,
    FOREIGN KEY (userID) REFERENCES Accounts(userID),
    FOREIGN KEY (apartmentID) REFERENCES Apartments(apartmentID)
);

-- Create Bills table
CREATE TABLE Bills (
    billID INT PRIMARY KEY,
    residentID INT,
    status VARCHAR(10),
    total DECIMAL(10, 2),
    billdate DATE,
    FOREIGN KEY (residentID) REFERENCES Residents(residentID)
);

-- Create Billdetails table
CREATE TABLE Billdetails (
    billdetailID INT PRIMARY KEY,
    billID INT,
    base_rent DECIMAL(10, 2),
    water_bill DECIMAL(10, 2),
    electricity_bill DECIMAL(10, 2),
    service_bill DECIMAL(10, 2),
    FOREIGN KEY (billID) REFERENCES Bills(billID)
);

-- Create Worker table
CREATE TABLE Worker (
    workerID INT PRIMARY KEY,
    userID INT,
    base_salary DECIMAL(10, 2),
    salary_multi DECIMAL(5, 2),
    job VARCHAR(50),
    FOREIGN KEY (userID) REFERENCES Accounts(userID)
);

-- Create Service_Requests table
CREATE TABLE Service_Requests (
    requestID INT PRIMARY KEY,
    residentID INT,
    workerID INT,
    description TEXT,
	senddate DATE,
	recievedate DATE,
	finsishdate DATE,
    FOREIGN KEY (residentID) REFERENCES Residents(residentID),
    FOREIGN KEY (workerID) REFERENCES Worker(workerID)
);
CREATE TABLE NotificationAlert (
    notiID INT IDENTITY(0,1) PRIMARY KEY,
	userID INT,
	desciption TEXT,
	notidate DATE,
	notistattus BIT,
	FOREIGN KEY (userID) REFERENCES Accounts(userID)
);
INSERT INTO Rolls(rollID, roll_name) values (1, 'Resident'), (2, 'Worker'),(3, 'Landlord');
