
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
    password TEXT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    profile_picture_link VARCHAR(255),
    birthdate DATE,
    roleID INT,
	salt TEXT,
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
	status varchar(50),
    FOREIGN KEY (userID) REFERENCES Accounts(userID)
);

-- Create Service_Requests table
CREATE TABLE Service_Requests (
    requestID INT IDENTITY(0,1) PRIMARY KEY,
    residentID INT,
    workerID INT,
	request_date DATE,
	assign_date DATE,
	finish_date DATE,
	title TEXT,
    description TEXT,
	type TEXT,
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

INSERT INTO Roles(roleID, role_name) values (1, 'Resident'), (2, 'Worker'),(3, 'Landlord');

INSERT INTO ApartmentTypes (typeID, size, base_rent)values(1, 'small', 5),(2,'medium', 10),(3, 'big', 15);
INSERT INTO Apartments(apartmentID, typeID, occupied) values(101, 1, 1),(102, 2, 0);

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID, salt) 
values ('resident', 'EDu66osgcOX/YeGaYI+JfiaX2n7/vYp+nR1wlxGWeM8kuWxKyVe2DfoH63IxDoZBBOqdZSKY0i+YBqyb91aNGg==', 'Resident', '1', '165325536556', 'mail@example.com', 'img_link', '20240523 10:34:09 AM', 1, 'sygiMeK1LpmQfiW1yOlOEA==');

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID, salt) 
values ('resident2', 'fjHhLQKMeP2cXOpCFCAxnePXbaV1ZoK9/Dn2IcptyM5hPYO+YLj3yDJU7IT9yVhyo0++8dZLMGOj8LKZfroc7A==', 'Resident', '2', '16965777756', 'resident2@example.com', 'img_link', '20240527 12:30:09 AM', 1, '/dgFDnHjVl9n8yxcUZ2xAw==');

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID, salt) 
values ('landlord', 'l9+/1Vffh/I9UK20+B9ku//6rxgTRxJmheVmZ07Bq+QHwy9Ha9YtvwfWte0XsciUIpKBrCb4ttE7HauaiAt6tQ==', 'Land', 'Lore', '1659797976', 'landlore@example.com', 'img_link', '20240422 7:56:09 AM', 3, 'JCXQhzsLzTg90vojY3De2w==');

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID, salt) 
values ('worker', 'IcHD7PgeDyzNeu3lrt1AANuPXAITfMSadHPYVOaYNr6iEtDYZ7wOC/GW2/ScC4A8C0hXRqiYf02CJ9QAvHSTYQ==', 'Work', 'Er', '1655972401012', 'worker@example.com', 'img_link', '20240422 8:55:09 AM', 2, '8FiR3HdEn0azjZmfoe6vUw==');

INSERT INTO Accounts(username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID, salt) 
values ('mra', 'dgacAR/m8eD8K24OkEvjmlaNuhGKurRTq+iov/sKWGvBRsrDvX8P22zQNopCed6C9uKyEKBSJoI9jTUYGVvSDw==', 'RTX', '4090', '552358235226', 'nvidia@example.com', 'img_link', '20190619 8:55:09 AM', 1, 'eFrts2W0PIsky+cwTTyVOA==');

insert into Residents(userID, apartmentID, billingdate) values (0, 101, '20240625 10:34:09 AM')
insert into Residents(userID, apartmentID, billingdate) values (1, 102, '20240626 9:50:09 AM')

insert into NotificationAlert(userID, notidate, noti_message,noti_status) values (0, '20240523 10:34:09 AM', 'ALLAHU AKBAR', 1)

INSERT INTO Workers(userID, base_salary, salary_multi, job, last_login, status) values(3, 100, 1, 'Plumber', '5/23/2024', 'Working');

INSERT INTO WorkerAttendance(userID, attendance_data) values (3, '0 0 0 0 3 0 0 0 0 0 0 3 0 0 0 0 0 0 3 0 0 0 2 0 0 3 0 0 0 0 0');

--insert into Service_Requests(requestID, residentID, workerID, requestdate, assigndate, finishdate, description, senddate, recievedate, finsishdate)
--values (0, 0, 0, '2024-05-22', '2024-05-22', '2024-05-23', 'Fix resident''s pipelines', '2024-05-22', '2024-05-22', '2024-05-24')

--insert into Service_Requests(requestID, residentID, workerID, requestdate, assigndate, finishdate, description, senddate, recievedate, finsishdate)
--values (1, 1, 0, '2024-05-23', '2024-05-23', '2024-05-24', 'Fix resident 2''s pipelines', '2024-05-23', '2024-05-23', '2024-05-24')

insert into Service_Requests(residentID, workerID, request_date, assign_date, finish_date, title, description, type)
values (0, 0, '2024-05-22', '2024-05-22', '2024-05-24', 'Fix resident''s pipelines', 'Go up there and fix it', 'Maintenance')

insert into Service_Requests(residentID, workerID, request_date, assign_date, finish_date, title, description, type)
values (1, 0, '2024-05-23', '2024-05-23', '2024-05-24', 'Fix resident 2''s pipelines', 'Go up there and fix it', 'Maintenance')

insert into Service_Requests(residentID, workerID, request_date, assign_date, finish_date, title, description, type)
values (1, 0, '2024-05-22', '2024-05-22', '2024-05-24', 'Fix resident 3''s pipelines', 'Go up there and make it right', 'Maintenance')