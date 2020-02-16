USE Bank_DB;
GO
DROP TABLE Individual;
DROP TABLE Business;
DROP TABLE Temp_Transaction;
DROP TABLE Acc_Transaction;
DROP TABLE Credit_Card;
DROP TABLE Account;
DROP TABLE Product;
DROP TABLE Employee;
DROP TABLE Customer;
DROP TABLE Currency;
DROP TABLE Department;
DROP TABLE Branch;

CREATE TABLE Branch(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(30) NOT NULL,
    Region NVARCHAR(20) CHECK(Region IN ('Брестская', 'Витебская', 'Гомельская', 'Гродненская', 'Минская', 'Могилевская')),
    City NVARCHAR(20),
    [Address] NVARCHAR(30),
    [Index] NUMERIC(6) NOT NULL
);

CREATE TABLE Department(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) NOT NULL
);

CREATE TABLE Employee(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Login] NVARCHAR(30) UNIQUE NOT NULL,
	[Password] NVARCHAR(30) NOT NULL,
    First_Name NVARCHAR(30) NOT NULL,
    Last_Name NVARCHAR(30) NOT NULL,
    Position NVARCHAR(30) NOT NULL,
    [Start_Date] DATE NOT NULL,
    Assigned_Branch_Id INT,
    Depart_Id INT,
    Superior_Emp_Id INT,
    End_Date DATE,
	CONSTRAINT FK_Employee_Branch FOREIGN KEY(Assigned_Branch_Id) REFERENCES Branch,
	CONSTRAINT FK_Employee_Department FOREIGN KEY(Depart_Id) REFERENCES Department,
	CONSTRAINT FK_Employee_Employee FOREIGN KEY(Superior_Emp_Id) REFERENCES Employee
);

ALTER TABLE Employee
ALTER COLUMN [Password] ADD MASKED WITH (FUNCTION = 'partial(0, "XXXXXX", 0)');

--EXECUTE AS USER = 'Admin';
--exec GetAllEmployees;
--REVERT; 

CREATE TABLE Customer(
	Id INT IDENTITY(100000000,1) PRIMARY KEY NOT NULL,
	[Login] NVARCHAR(30) UNIQUE NOT NULL,
	[Password] NVARCHAR(30) NOT NULL,
    Region NVARCHAR(20),
    City NVARCHAR(20),
    [Address] NVARCHAR(30)
);

ALTER TABLE Customer
ALTER COLUMN [Password] 
ADD MASKED WITH (FUNCTION = 'partial(0, "XXXXXX", 0)');

CREATE TABLE Individual(
	Cust_Id INT PRIMARY KEY NOT NULL,
    First_Name NVARCHAR(30) NOT NULL,
    Last_Name NVARCHAR(30) NOT NULL,
    Birth_Date DATE NOT NULL,
	CONSTRAINT FK_Individual_Customer FOREIGN KEY(Cust_Id) REFERENCES Customer
);

CREATE TABLE Business(
	Cust_Id INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(255) NOT NULL,
    Incorp_Date DATE NOT NULL,
	CONSTRAINT FK_Business_Customer FOREIGN KEY(Cust_Id) REFERENCES Customer
);

CREATE TABLE Product(
    Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE Currency(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Name] VARCHAR(3) NOT NULL CHECK([Name] IN ('RUB', 'BYN', 'USD'))
);

CREATE TABLE Account(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Cust_Id INT NOT NULL,
	Open_Date DATE NOT NULL,
    Open_Branch_Id INT,
    Open_Emp_Id INT,
    Balance MONEY DEFAULT 0.0,
	Curr_Id INT NOT NULL,
    Last_Activity_Date DATETIME,
    Close_Date DATE,
	CONSTRAINT FK_Account_Customer FOREIGN KEY(Cust_Id) REFERENCES Customer,
	CONSTRAINT FK_Account_Branch FOREIGN KEY(Open_Branch_Id) REFERENCES Branch,
	CONSTRAINT FK_Account_Employee FOREIGN KEY(Open_Emp_Id) REFERENCES Employee,
	CONSTRAINT FK_Account_Currency FOREIGN KEY(Curr_Id) REFERENCES Currency
);

CREATE TABLE Credit_Card(
	Id BIGINT IDENTITY(100000000000,1) PRIMARY KEY NOT NULL,
	Account_Id INT NOT NULL,
	Open_Date DATE NOT NULL,
	Validity VARBINARY(MAX),
	CONSTRAINT FK_Card_Account FOREIGN KEY(Account_Id) REFERENCES Account
);

CREATE TABLE Acc_Transaction(
    Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Account_Id INT NOT NULL,
    Amount MONEY NOT NULL DEFAULT 0.0,
    Rest MONEY DEFAULT 0.0,
    [DateTime] DATETIME NOT NULL,
    Type_Prod_Id INT,
    Execution_Branch_Id INT,
    Teller_Emp_Id INT,
	CONSTRAINT FK_Acc_Transaction_Product FOREIGN KEY(Type_Prod_Id) REFERENCES Product,
	CONSTRAINT FK_Acc_Transaction_Account FOREIGN KEY(Account_Id) REFERENCES Account,
	CONSTRAINT FK_Acc_Transaction_Branch FOREIGN KEY(Execution_Branch_Id) REFERENCES Branch,
	CONSTRAINT FK_Acc_Transaction_Employee FOREIGN KEY(Teller_Emp_Id) REFERENCES Employee
);

CREATE TABLE Temp_Transaction(
    Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Acc_Tran_Id INT NOT NULL,
    Date_Retired DATE NOT NULL,
	Completed BIT NOT NULL,
	CONSTRAINT FK_Temp_Acc_Transaction FOREIGN KEY(Acc_Tran_Id) REFERENCES Acc_Transaction
);


