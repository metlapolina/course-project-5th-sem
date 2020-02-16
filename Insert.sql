USE Bank_DB;
GO 
--заполнение таблицы Branch
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №1', 'Минская', 'Минск', 'ул.Фабрициуса 7/6', 220006);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №2', 'Минская', 'Минск', 'ул.Держинского 69/1', 220011);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №6', 'Минская', 'Минск', 'ул.Слободская 15', 220039);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №7', 'Минская', 'Жодино', 'ул.Свободы 18', 222164);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №9', 'Минская', 'Молодечно', 'ул.Великий Гостинец 6', 222301);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №12', 'Витебская', 'Витебск', 'ул.Фрунзе 13', 210035);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №15', 'Витебская', 'Витебск', 'ул.Гагарина 25', 210016);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №16', 'Витебская', 'Полоцк', 'ул.Франциска Скорины 3', 211049);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №19', 'Витебская', 'Новополоцк', 'ул.Молодежная 21', 211447);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №21', 'Брестская', 'Брест', 'ул.Южаная 6', 224035);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №23', 'Брестская', 'Брест', 'ул.Тургенева 15', 224005);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №24', 'Брестская', 'Пинск', 'ул.Гвардейская 7', 225700);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №27', 'Брестская', 'Кобрин', 'ул.Ткаченко 26', 225306);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №30', 'Гродненская', 'Гродно', 'ул.Цветочная 11', 230023);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №35', 'Гродненская', 'Гродно', 'ул.Юбилейная 6', 230024);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №37', 'Гродненская', 'Лида', 'ул.Чкалова 16а', 231282);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №39', 'Гродненская', 'Волковыск', 'ул.Красноармейская 36', 231891);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №41', 'Могилевская', 'Могилев', 'ул.Чапаева 52', 212039);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №42', 'Могилевская', 'Могилев', 'ул.Мирная 8', 212008);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №46', 'Могилевская', 'Бобруйск', 'ул.Космонавтов 10', 213818);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №48', 'Могилевская', 'Бобруйск', 'ул.Строителей 9/2', 213826);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №52', 'Гомельская', 'Гомель', 'ул.Симонова 27', 246026);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №56', 'Гомельская', 'Мозырь', 'ул.Ангарская 20', 247777);
INSERT INTO Branch(Name, Region, City, Address, [Index]) values('Отделение №59', 'Гомельская', 'Светлогорск', 'ул.Челюскинцев 23', 247433);
GO
--заполнение таблицы Department
INSERT INTO Department(Name) values('Юридический департамент');
INSERT INTO Department(Name) values('Финансовый департамент');
INSERT INTO Department(Name) values('Департамент бухгалтерского учета и отчетности');
INSERT INTO Department(Name) values('Департамент эмиссионно-кассовых операций');
INSERT INTO Department(Name) values('Департамент регулирования денежного обращения');
INSERT INTO Department(Name) values('Департамент валютного регулирования и валютного контроля');
INSERT INTO Department(Name) values('Департамент лицензирования банковской и аудиторской деятельности');
GO
--заполнение таблицы Product
INSERT INTO Product(Name) values('Просмотр денежных средств');
INSERT INTO Product(Name) values('Снятие денежных средств');
INSERT INTO Product(Name) values('Пополнение счета');
INSERT INTO Product(Name) values('Оформление счета');
INSERT INTO Product(Name) values('Оформление банковской карты');
INSERT INTO Product(Name) values('Оформление кредита');
INSERT INTO Product(Name) values('Перевод средств с обменом валюты');
INSERT INTO Product(Name) values('Перевод средств со счета на счет одного лица');
INSERT INTO Product(Name) values('Перевод средств со счета на счет другого лица');
INSERT INTO Product(Name) values('Пополнение кредита');
INSERT INTO Product(Name) values('Досрочное закрытие кредита');
GO
--заполнение таблицы Currency
INSERT INTO Currency(Name) values('RUB');
INSERT INTO Currency(Name) values('BYN');
INSERT INTO Currency(Name) values('USD');
GO
--процедура для генерации случайной строки
DROP PROCEDURE GenerateString;
GO
CREATE PROCEDURE GenerateString (@res nvarchar(10) output)
AS
BEGIN
	DECLARE @str NVARCHAR(10);
	SET @str = (SELECT c1 AS [text()] FROM (SELECT TOP (10) c1 FROM (
		VALUES
			('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'), ('K'), ('L'), ('M'), 
			('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'), ('U'), ('V'), ('W'), ('X'), ('Y'), ('Z')
		) AS T1(c1)
	ORDER BY ABS(CHECKSUM(NEWID()))
	) AS T2
	FOR XML PATH('')
	);
	SET @res = @str;
END
GO
--заполнение таблицы Employee начальниками
DROP PROCEDURE InsertRandEmployees;
GO
CREATE PROCEDURE InsertRandEmployees
AS
DECLARE @i INT = 1, @j INT = 1, @countBr int, @countDep int;
SELECT @countBr = count(*) FROM Branch;
SELECT @countDep = count(*) FROM Department;
WHILE @i <= @countBr
BEGIN
	WHILE @j <= @countDep
	BEGIN
		DECLARE @login NVARCHAR(30), @password NVARCHAR(30), @firstName NVARCHAR(20), @lastName NVARCHAR(20), 
			@position NVARCHAR(30), @start DATE, @branchId int, @departId int, @superiorId int, @end DATE;

		SET @login = left(NEWID(),8);
		SET @password = left(NEWID(),8);
		EXEC GenerateString @firstName output;
		EXEC GenerateString @lastName output;
		SET @position = 'Руководитель отдела';
		SET @start = DATEADD(DAY, FLOOR(rand()*3000), '2010-01-01');
		SET @branchId = @i;
		SET @departId = @j;
		SET @superiorId = NULL;
		SET @end = NULL;

		INSERT INTO Employee(Login, Password, First_Name, Last_Name, Position, Start_Date, Assigned_Branch_Id, Depart_Id, Superior_Emp_Id, End_Date)
			 VALUES( @login, @password, @firstName, @lastName, @position, @start, @branchId, @departId, @superiorId, @end);
		SET @j = @j + 1;
	END;
	SET @j = 1;
	SET @i = @i + 1;
END;
GO
exec InsertRandEmployees;
GO
--заполнение таблицы Employee менеджерами
DROP PROCEDURE InsertRandManagers;
GO
CREATE PROCEDURE InsertRandManagers
AS
DECLARE @i INT = 1;
WHILE @i < 1000
BEGIN
	DECLARE @login NVARCHAR(30), @password NVARCHAR(30), @firstName NVARCHAR(20), @lastName NVARCHAR(20), 
		@position NVARCHAR(30), @start DATE, @branchId int, @departId int, @superiorId int, @end DATE;
	DECLARE @cBranch int, @cDepart int;

	SET @login = left(NEWID(),8);
	SET @password = left(NEWID(),8);
	EXEC GenerateString @firstName output;
	EXEC GenerateString @lastName output;
	SET @position = 'Менеджер';
	SET @start = DATEADD(DAY, FLOOR(rand()*3000), '2010-01-01');

	SELECT @cBranch = count(*) FROM Branch;
	SET @branchId = cast(rand(checksum(newid()))*@cBranch+1 as int);

	SELECT @cDepart = count(*) FROM Department;
	SET @departId = cast(rand(checksum(newid()))*@cDepart+1 as int);

	SELECT @superiorId = Id FROM Employee WHERE Position LIKE '%Руководитель отдела%' AND Assigned_Branch_Id = @branchId AND Depart_Id = @departId;
	SET @end = NULL;
	
	INSERT INTO Employee(Login, Password, First_Name, Last_Name, Position, Start_Date, Assigned_Branch_Id, Depart_Id, Superior_Emp_Id, End_Date)
		 VALUES( @login, @password, @firstName, @lastName, @position, @start, @branchId, @departId, @superiorId, @end);
	SET @i = @i + 1;
END;
GO
exec InsertRandManagers;
GO
--процедура для заполнения таблицы Customer
DROP PROCEDURE InsertRandCustomers;
GO
CREATE PROCEDURE InsertRandCustomers
AS
DECLARE @i INT = 1;
WHILE @i < 100000
BEGIN
	DECLARE @login NVARCHAR(30), @password NVARCHAR(30), @region NVARCHAR(20), @city NVARCHAR(20), @address NVARCHAR(30);
	
	SET @login = 'user'+cast(@i as varchar);
	SET @password = 'user'+cast(@i as varchar);
	EXEC GenerateString @region output;
	EXEC GenerateString @city output;
	EXEC GenerateString @address output;

	INSERT INTO Customer(Login, Password, Region, City, Address) VALUES( @login, @password, @region, @city, @address);
	SET @i = @i + 1;
END;
GO
exec InsertRandCustomers;
GO
--процедура для заполнения таблицы Individual
DROP PROCEDURE InsertRandIndividual;
GO
CREATE PROCEDURE InsertRandIndividual
AS
DECLARE @i INT = 0, @id INT;
SELECT TOP(1) @id = Id FROM Customer ORDER BY Id;
WHILE @i < 70000
BEGIN
	DECLARE @custId INT, @firstName NVARCHAR(30), @lastName NVARCHAR(30), @birth DATE;
	
	SET @custId = @id + @i;
	EXEC GenerateString @firstName output;
	EXEC GenerateString @lastName output;
	SET @birth = DATEADD(DAY, FLOOR(rand()*18000), '1950-01-01');

	INSERT INTO Individual(Cust_Id, First_Name, Last_Name, Birth_Date) VALUES( @custId, @firstName, @lastName, @birth);
	SET @i = @i + 1;
END;
GO
exec InsertRandIndividual;
GO
--процедура для заполнения таблицы Business
DROP PROCEDURE InsertRandBusiness;
GO
CREATE PROCEDURE InsertRandBusiness
AS
DECLARE @i INT = 70000, @id INT, @count INT;
SELECT TOP(1) @id = Id FROM Customer ORDER BY Id;
SELECT @count = COUNT(*) FROM Customer;
WHILE @i < @count
BEGIN
	DECLARE @custId INT, @name NVARCHAR(255), @incorpDate DATE;
	
	SET @custId = @id + @i;
	EXEC GenerateString @name output;
	SET @incorpDate = DATEADD(DAY, FLOOR(rand()*10000), '1990-01-01');
	
	INSERT INTO Business(Cust_Id, Name, Incorp_Date) VALUES(@custId, @name, @incorpDate);
	SET @i = @i + 1;
END;
GO
exec InsertRandBusiness;
GO
--заполнение таблицы Account
DROP PROCEDURE InsertRandAccount;
GO
CREATE PROCEDURE InsertRandAccount
AS
DECLARE @i INT = 0, @id INT, @count INT;
SELECT TOP(1) @id = Id FROM Customer ORDER BY Id;
SELECT @count = COUNT(*) FROM Customer;
WHILE @i < @count
BEGIN
	DECLARE @custId INT, @open DATE, @branchId INT, @empId INT, @balance MONEY, @currId INT, @lastActive DATETIME, @close DATE;
	DECLARE @cBranch INT, @cCurr INT;
		
	SELECT @cCurr = COUNT(*) FROM Currency;

	SET @custId = @id + @i;	
	SET @open = DATEADD(DAY, FLOOR(rand()*1500), '2015-01-01');	
	SELECT @cBranch = COUNT(*) FROM Branch;
	SET @branchId = cast(rand(checksum(newid()))*@cBranch+1 as INT);
	SELECT TOP(1) @empId = Id FROM Employee WHERE Assigned_Branch_Id = @branchId AND Position LIKE '%Менеджер%';
	SET @balance = round(rand()*1000000,2);
	SET @currId = rand()*@cCurr+1;
	SET @lastActive = @open;
	SET @close = NULL;
			
	INSERT INTO Account(Cust_Id, Open_Date, Open_Branch_Id, Open_Emp_Id, Balance, Curr_Id, Last_Activity_Date, Close_Date)
		 VALUES( @custId, @open, @branchId, @empId, @balance, @currId, @lastActive, @close);
	SET @i = @i + 1;
END;
GO
exec InsertRandAccount;

GO
DROP MASTER KEY;
DROP SYMMETRIC KEY MySymmetricKey;
DROP ASYMMETRIC KEY MyAsymmetricKey;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '$tr0nGPa$$w0rd';
GO
-- Создание асимметричного ключа, зашифрованного парольной фразой StrongPa$$w0rd!
CREATE ASYMMETRIC KEY MyAsymmetricKey
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = 'StrongPa$$w0rd!';
GO
-- Создание симметричного ключа, зашифрованного асимметричным ключом.
CREATE SYMMETRIC KEY MySymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY ASYMMETRIC KEY MyAsymmetricKey;
GO
OPEN SYMMETRIC KEY MySymmetricKey
DECRYPTION BY ASYMMETRIC KEY MyAsymmetricKey
WITH PASSWORD = 'StrongPa$$w0rd!';
GO
--SELECT * FROM sys.openkeys;
GO
--заполнение таблицы Credit_Card
DROP PROCEDURE InsertRandCard;
GO
CREATE PROCEDURE InsertRandCard
AS
DECLARE @i INT = 0, @id INT, @count INT;
SELECT TOP(1) @id = Id FROM Account ORDER BY Id;
SELECT @count = COUNT(*) FROM Account;
WHILE @i < @count
BEGIN
	DECLARE @SymmetricKeyGUID AS [uniqueidentifier];
	SET @SymmetricKeyGUID = KEY_GUID('MySymmetricKey');
	IF (@SymmetricKeyGUID IS NOT NULL)
	BEGIN
		DECLARE @accId INT, @open DATE;		
		SELECT @accId = Id, @open = Open_Date FROM Account WHERE Id = @id + @i;
		INSERT INTO Credit_Card(Account_Id, Open_Date, Validity)
				VALUES( @accId, @open, ENCRYPTBYKEY(@SymmetricKeyGUID, N'09/21'));
	END;
	SET @i = @i + 1;
END;
GO
exec InsertRandCard;
GO

--информация о платежных картах клиента-----------------------------------------------------------------procedure
DROP PROCEDURE GetClientCard;
GO
CREATE PROCEDURE GetClientCard
	@accId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	DECLARE @check BIGINT;
	SET @mess='';
	SELECT @check = Id FROM Credit_Card WHERE Account_Id = @accId;
	IF(@check > 0)
		SELECT Id [ID],  Account_Id [ID счета], Open_Date [Дата открытия], 
				CONVERT(NVARCHAR(32), DECRYPTBYKEY(Validity)) [Действительно]
		FROM Credit_Card WHERE Account_Id = @accId;
	ELSE SET @mess = 'Для данного счета платежная карта не была оформлена!';
END;
GO

--EXECUTE AS USER = 'Client';
--declare @m nvarchar(200);
--exec GetClientCard 99999, @m output;
--print @m;
--REVERT;

--select * from Credit_Card;

--EXECUTE AS USER = 'Admin';
--exec GetAllAccounts;
--REVERT;

--заполнение таблицы Acc_Transaction
DROP PROCEDURE InsertRandTran;
GO
CREATE PROCEDURE InsertRandTran
AS
DECLARE @i INT = 0, @id INT, @count INT;
SELECT TOP(1) @id = Id FROM Account ORDER BY Id;
SELECT @count = COUNT(*) FROM Account;
WHILE @i < @count
BEGIN
	DECLARE @accId INT, @amount MONEY, @date DATETIME, @prodId INT, @branchId INT, @empId INT;
	DECLARE @openAcc DATE, @cProd INT;
	
	SET @accId = @id + @i;	
	SET @amount = round(rand()*10000,2);
	
	SELECT @openAcc = Open_Date FROM Account WHERE Id = @accId;
	SET @date = DATEADD(DAY, FLOOR(rand()*15), @openAcc);	
	
	SELECT @cProd = COUNT(*) FROM Product;
	SET @prodId = rand()*(@cProd-3)+4;
	SELECT @branchId = Open_Branch_Id FROM Account WHERE Id = @accId;
	SELECT @empId = Open_Emp_Id FROM Account WHERE Id = @accId;
			
	INSERT INTO Acc_Transaction(Account_Id, Amount, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
		 VALUES( @accId, @amount, @date, @prodId, @branchId, @empId);
	SET @i = @i + 1;
END;
GO
exec InsertRandTran;
GO
--заполнение таблицы Temp_Transaction
DROP PROCEDURE InsertRandTempTran;
GO
CREATE PROCEDURE InsertRandTempTran
AS
DECLARE c_tran CURSOR for SELECT A.Id FROM Acc_Transaction A JOIN Product P ON A.Type_Prod_Id=P.Id WHERE P.Name LIKE '%Пополнение кредита%';
DECLARE @tid INT, @date DATE, @completed BIT, @tranDate DATETIME;
OPEN c_tran;	  
FETCH c_tran into @tid; 
WHILE @@FETCH_STATUS = 0                                     
	BEGIN  
		SELECT @tranDate = DateTime FROM Acc_Transaction WHERE Id = @tid;
		SET @date = DATEADD(YEAR, FLOOR(rand()*10), @tranDate);	
		IF(@date<GETDATE())	SET @completed = 1;
		ELSE SET @completed = 0; 
		INSERT INTO Temp_Transaction(Acc_Tran_Id, Date_Retired, Completed) VALUES(@tid, @date, @completed);
		FETCH c_tran INTO @tid; 
	END;           
CLOSE c_tran;
DEALLOCATE c_tran;
GO
exec InsertRandTempTran;
GO
