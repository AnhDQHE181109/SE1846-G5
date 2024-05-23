
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

-- Create Roles table first
CREATE TABLE Roles (
    roleID INT PRIMARY KEY,
    role_name VARCHAR(10)
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
    birthdate DATE,
    roleID INT,
    FOREIGN KEY (roleID) REFERENCES Roles(roleID)
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
    residentID INT identity(0,1) PRIMARY KEY,
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

-- Create Workers table
CREATE TABLE Workers (
    workerID INT IDENTITY(0,1) PRIMARY KEY,
    userID INT,
    base_salary DECIMAL(10, 2),
    salary_multi DECIMAL(5, 2),
    job VARCHAR(50),
	last_login DATE,
    FOREIGN KEY (userID) REFERENCES Accounts(userID)
);

-- Create Service_Requests table
CREATE TABLE Service_Requests (
    requestID INT PRIMARY KEY,
    residentID INT,
    workerID INT,
	requestdate DATE,
	assigndate DATE,
	finishdate DATE,
    description TEXT,
	senddate DATE,
	recievedate DATE,
	finsishdate DATE,
    FOREIGN KEY (residentID) REFERENCES Residents(residentID),
    FOREIGN KEY (workerID) REFERENCES Workers(workerID)
);
CREATE TABLE NotificationAlert (
    notiID INT IDENTITY(0,1) PRIMARY KEY,
	userID INT,
	notidate DATE,
	noti_message TEXT,
	noti_status BIT,
	FOREIGN KEY (userID) REFERENCES Accounts(userID)
);
CREATE TABLE WorkerAttendance(
	attendanceID INT IDENTITY(0,1) PRIMARY KEY,
	userID INT,
	attendance_data TEXT,
	FOREIGN KEY (userID) REFERENCES Accounts(userID)
);


INSERT INTO ApartmentTypes (typeID, size, base_rent)values(1, 'small', 5),(2,'medium', 10),(3, 'big', 15);
INSERT INTO Apartments(apartmentID, typeID, occupied) values(101, 1, 1),(102, 2, 0);

INSERT INTO Roles(roleID, role_name) values (1, 'Resident'), (2, 'Worker'),(3, 'Landlord');
INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID) 
values ('resident', 'password', 'Resident', '1', '165325536556', 'mail@example.com', 'img_link', '20240523 10:34:09 AM', 1);

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID) 
values ('resident2', 'password', 'Resident', '2', '16965777756', 'resident2@example.com', 'img_link', '20240527 12:30:09 AM', 1);

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID) 
values ('landlord', 'password', 'Land', 'Lore', '1659797976', 'landlore@example.com', 'img_link', '20240422 7:56:09 AM', 3);

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID) 
values ('worker', 'password', 'Work', 'Er', '1655972401012', 'worker@example.com', 'img_link', '20240422 8:55:09 AM', 2);

insert into Residents(userID, apartmentID, billingdate) values (0, 101, '20240625 10:34:09 AM')
insert into Residents(userID, apartmentID, billingdate) values (1, 102, '20240626 9:50:09 AM')

insert into NotificationAlert(userID, notidate, noti_message,noti_status) values (0, '20240523 10:34:09 AM', 'ALLAHU AKBAR', 1)

INSERT INTO Workers(userID, base_salary, salary_multi, job, last_login) values(3, 100, 1, 'Plumber', '5/23/2024');