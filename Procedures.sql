USE Bank_DB;

--проверка принадлежности клиента банку
DROP PROCEDURE IsClient;
GO
CREATE PROCEDURE IsClient
	@login NVARCHAR(30),
	@password NVARCHAR(30)
AS
BEGIN
	BEGIN TRY
		DECLARE @check INT;
		SELECT @check = Id FROM Customer WHERE Login = @login AND Password = @password;
		IF(@check > 0)
		BEGIN
			UPDATE Account SET Last_Activity_Date=GETDATE() WHERE Cust_Id=@check;
			SELECT 0;
		END;
		ELSE SELECT 'Такого клиента не существует!';
	END TRY
	BEGIN CATCH
		SELECT 'Ошибка системы!';
	END CATCH;
END
GO

--проверка принадлежности клиента банку
DROP PROCEDURE IsEmployee;
GO
CREATE PROCEDURE IsEmployee
	@login NVARCHAR(30),
	@password NVARCHAR(30)
AS
BEGIN
	BEGIN TRY
		DECLARE @checkEmp INT, @checkAdmin INT;
		SELECT @checkEmp = count(*) FROM Employee WHERE Login = @login AND Password = @password;
		IF(@checkEmp = 1)
			SELECT 1;
		ELSE IF(@login = 'Admin' AND @password = 'Admin')
			SELECT 2;
		ELSE SELECT 'Такого сотрудника не существует!';
	END TRY
	BEGIN CATCH
		SELECT 'Ошибка системы!';
	END CATCH;
END
GO

--информация о сотруднике по логину
DROP PROCEDURE GetOneEmployee;
GO
CREATE PROCEDURE GetOneEmployee
    @login NVARCHAR(30)
AS
	SELECT E.Id [ID], E.Login [Логин], E.Password [Пароль], E.Position [Должность], E2.Last_Name [Начальник], D.Name [Департамент], B.Name [Филиал]
	FROM Employee E LEFT OUTER JOIN Branch B ON E.Assigned_Branch_Id=B.Id
					LEFT OUTER JOIN Department D ON E.Depart_Id=D.Id
					LEFT OUTER JOIN Employee E2 ON E.Superior_Emp_Id=E2.Id
	WHERE E.Login = @login;
GO

--информация о клиенте по логину
DROP PROCEDURE GetOneClient;
GO
CREATE PROCEDURE GetOneClient
    @login NVARCHAR(30)
AS
	SELECT C.Id [ID], C.Login [Логин], C.Password [Пароль], C.Region [Область], C.City [Город], C.Address [Адрес], I.First_Name [Имя], I.Last_Name [Фамилия]
	FROM Customer C INNER JOIN Individual I ON C.Id=I.Cust_Id
	WHERE C.Login = @login
	UNION
	SELECT C.Id [ID], C.Login [Логин], C.Password [Пароль], C.Region [Область], C.City [Город], C.Address [Адрес], B.Name [Название], NULL
	FROM Customer C INNER JOIN Business B ON C.Id=B.Cust_Id 
	WHERE C.Login = @login;
GO

--------------------------------------ADMIN--------------------------------------

--информация о физических клиентах
DROP PROCEDURE GetIndividualClients;
GO
CREATE PROCEDURE GetIndividualClients
AS
SELECT C.Id [ID], C.Login [Логин], C.Password [Пароль], I.First_Name [Имя], I.Last_Name [Фамилия], I.Birth_Date [Дата рождения], 
		C.Region [Область], C.City [Город], C.Address [Адрес]
FROM Customer C INNER JOIN Individual I ON C.Id=I.Cust_Id;
GO

--информация о юридических клиентах
DROP PROCEDURE GetBusinessClients;
GO 
CREATE PROCEDURE GetBusinessClients
AS 
SELECT C.Id [ID], C.Login [Логин], C.Password [Пароль], B.Name [Название], B.Incorp_Date [Дата регистации], C.Region [Область], 
		C.City [Город], C.Address [Адрес]
FROM Customer C INNER JOIN Business B ON C.Id=B.Cust_Id;
GO

--информация о всех сотрудниках
DROP PROCEDURE GetAllEmployees;
GO
CREATE PROCEDURE GetAllEmployees
AS 
SELECT E.Id [ID], E.Login [Логин], E.Password [Пароль], E.First_Name [Имя], E.Last_Name [Фамилия], E.Position [Должность], 
		E.Start_Date [Дата приема на работу], E.End_Date [Дата увольнения], E2.Last_Name [Начальник], D.Name [Департамент], B.Name [Филиал]
FROM Employee E LEFT OUTER JOIN Branch B ON E.Assigned_Branch_Id=B.Id
				LEFT OUTER JOIN Department D ON E.Depart_Id=D.Id
				LEFT OUTER JOIN Employee E2 ON E.Superior_Emp_Id=E2.Id;
GO

--информация о всех счетах
DROP PROCEDURE GetAllAccounts;
GO
CREATE PROCEDURE GetAllAccounts
AS 
SELECT A.Id [ID], C.Login [Логин клиента], A.Open_Date [Дата открытия], B.Name [Филиал], E.Last_Name [Обслуживающий сотрудник], 
		A.Balance [Сумма на счете], Cr.Name [Валюта], CC.Validity [Действительно], A.Last_Activity_Date [Дата последней активности], A.Close_Date [Дата закрытия]
FROM Account A	INNER JOIN Customer C ON A.Cust_Id=C.Id
				LEFT OUTER JOIN Branch B ON A.Open_Branch_Id=B.Id
				LEFT OUTER JOIN Employee E ON A.Open_Emp_Id=E.Id
				INNER JOIN Currency Cr ON A.Curr_Id=Cr.Id
				LEFT OUTER JOIN Credit_Card CC ON A.Id=CC.Account_Id;
GO

--информация о всех транзакциях
DROP PROCEDURE GetAllTransactions;
GO
CREATE PROCEDURE GetAllTransactions
AS 
SELECT T.Id [ID], T.Account_Id [Аккаунт ID], T.Amount [Сумма], T.Rest [Остаток выплаты], T.DateTime [Время], P.Name [Услуга], B.Name [Филиал], 
		E.Last_Name [Обслуживающий сотрудник], isnull(TT.Date_Retired, T.DateTime) [Дата выплаты], isnull(TT.Completed, 1) [Завершена], TT.Id [ID текущей транзакции]
FROM Acc_Transaction T	INNER JOIN Product P ON T.Type_Prod_Id=P.Id
						LEFT OUTER JOIN Branch B ON T.Execution_Branch_Id=B.Id
						LEFT OUTER JOIN Employee E ON T.Teller_Emp_Id=E.Id
						LEFT OUTER JOIN Temp_Transaction TT ON TT.Acc_Tran_Id=T.Id
ORDER BY T.Id;
GO

--информация о всех услугах банка
DROP PROCEDURE GetAllProducts;
GO
CREATE PROCEDURE GetAllProducts
AS 
SELECT Id [ID], Name [Название] FROM Product;
GO

--информация о всех департаментах
DROP PROCEDURE GetAllDepartments;
GO
CREATE PROCEDURE GetAllDepartments
AS 
SELECT Id [ID], Name [Название] FROM Department;
GO

--информация о всех филиалах
DROP PROCEDURE GetAllBranches;
GO
CREATE PROCEDURE GetAllBranches
AS 
SELECT Id [ID], Name [Название], Region [Область], City [Город], Address [Адрес], [Index] [Индекс] FROM Branch;
GO

--информация о валюте банка
DROP PROCEDURE GetAllCurrency;
GO
CREATE PROCEDURE GetAllCurrency
AS 
SELECT Id [ID], Name [Название] FROM Currency;
GO

--добавить физического клиента
DROP PROCEDURE AddIndividualClient;
GO
CREATE PROCEDURE AddIndividualClient
	@login NVARCHAR(30),
	@password NVARCHAR(30),
    @firstName NVARCHAR(30),
	@lastName NVARCHAR (30),
	@birth DATE,
	@region NVARCHAR(20),
	@city NVARCHAR(20),
	@address NVARCHAR(30),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess = '';
	BEGIN TRY
		DECLARE @checkLogin int;
		SELECT @checkLogin = count(*) FROM Customer WHERE Login = @login;
		IF(@checkLogin = 0)
		BEGIN
			IF(DATEDIFF(year, @birth, GETDATE()) >= 18)
			BEGIN
				INSERT INTO Customer(Login, Password, Region, City, Address) values(@login, @password, @region, @city, @address);
				DECLARE @userId int;
				SELECT TOP(1) @userId = Id FROM Customer WHERE Login = @login;
				INSERT INTO Individual(Cust_Id, First_Name, Last_Name, Birth_Date) values(@userId, @firstName, @lastName, @birth);
			END;
			ELSE SET @mess = 'Клиенту еще нет 18 лет, в регистрации отказано!';
		END;
		ELSE SET @mess = 'Клиент с таким логином уже существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--добавить юридического клиента
DROP PROCEDURE AddBusinessClient;
GO
CREATE PROCEDURE AddBusinessClient
	@login NVARCHAR(30),
	@password NVARCHAR(30),
    @name NVARCHAR(30),
	@incDate DATE,
	@region NVARCHAR(20),
	@city NVARCHAR(20),
	@address NVARCHAR(30),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess = '';
	BEGIN TRY
		DECLARE @checkLogin int;
		SELECT @checkLogin = count(*) FROM Customer WHERE Login = @login;
		IF(@checkLogin = 0)
		BEGIN
			INSERT INTO Customer(Login, Password, Region, City, Address)
								values(@login, @password, @region, @city, @address);
			DECLARE @userId int;
			SELECT TOP(1) @userId = Id FROM Customer WHERE Login = @login;
			INSERT INTO Business(Cust_Id, Name, Incorp_Date) values(@userId, @name, @incDate);
		END;
		ELSE SET @mess = 'Пользователь с таким логином уже существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--добавить сотрудника
DROP PROCEDURE AddEmployee;
GO
CREATE PROCEDURE AddEmployee
	@login NVARCHAR(30),
	@password NVARCHAR(30),
    @firstName NVARCHAR(30),
    @lastName NVARCHAR(30),
	@position NVARCHAR(30),
	@start DATE,
	@branch NVARCHAR(30),
	@department NVARCHAR(100),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkLogin int;
		SELECT @checkLogin = count(*) FROM Employee WHERE Login = @login;
		if(@checkLogin = 0)
		BEGIN
			DECLARE @branchId int, @departId int, @superiorId int; 
			SELECT TOP(1) @branchId = Id FROM Branch WHERE Name = @branch;	
			SELECT TOP(1) @departId = Id FROM Department WHERE Name = @department;
			SELECT TOP(1) @superiorId = Id FROM Employee WHERE Assigned_Branch_Id = @branchId AND Depart_Id = @departId AND Position LIKE '%Руководитель%';
			IF(@branchId != 0 AND @departId != 0)
			BEGIN
				IF(@superiorId!= 0)
				INSERT INTO Employee(Login, Password, First_Name, Last_Name, Position, Start_Date, Assigned_Branch_Id, Depart_Id, Superior_Emp_Id, End_Date)
									values(@login, @password, @firstName, @lastName, @position, @start, @branchId, @departId, @superiorId, null);
				ELSE SET @mess = 'Начальника не существует!';
			END;
			ELSE SET @mess = 'Введенные данные (филиал, департамент) не существуют!';
		END;
		ELSE SET @mess = 'Сотрудник с таким логином уже существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--добавить филиал банка
DROP PROCEDURE AddBranch;
GO
CREATE PROCEDURE AddBranch
    @name NVARCHAR(30),
	@region NVARCHAR(20),
	@city NVARCHAR(20),
	@address NVARCHAR(30),
	@index NUMERIC(6),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkBranch int;
		SELECT @checkBranch = count(*) FROM Branch WHERE Name = @name;
		IF(@checkBranch = 0)
			INSERT INTO Branch(Name, Region, City, Address, [Index]) values(@name, @region, @city, @address, @index);
		ELSE SET @mess = 'Филиал с таким названием уже существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--добавить продукт/услугу, предоставляемый банком
DROP PROCEDURE AddProduct;
GO
CREATE PROCEDURE AddProduct
    @name NVARCHAR(50),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkProduct int;
		SELECT @checkProduct = count(*) FROM Product WHERE Name = @name;
		IF(@checkProduct = 0)
			INSERT INTO Product(Name) values(@name);
		ELSE SET @mess = 'Услуга с таким названием уже существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--добавить отделение банка
DROP PROCEDURE AddDepartment;
GO
CREATE PROCEDURE AddDepartment
    @name NVARCHAR(50),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkDepartment int;
		SELECT @checkDepartment = count(*) FROM Department WHERE Name = @name;
		IF(@checkDepartment = 0)
			INSERT INTO Department(Name) values(@name);
		ELSE SET @mess = 'Департамент с таким названием уже существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--добавить личный счет в банке + CLIENT
DROP PROCEDURE AddAccount;
GO
CREATE PROCEDURE AddAccount
	@login NVARCHAR(30),
	@branch NVARCHAR(30),
	@balance MONEY,
	@currency VARCHAR(3),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkLogin int, @customerId int,  @checkAccount int;
		SELECT @checkLogin = count(*) FROM Customer WHERE Login = @login;
		if(@checkLogin != 0)
		BEGIN
			SELECT TOP(1) @customerId = Id from Customer where Login=@login;
			SELECT @checkAccount = count(*) FROM Account WHERE Cust_Id = @customerId AND Close_Date is NULL;
			if(@checkAccount < 3)
			BEGIN
				DECLARE @branchId int, @empId int, @currId int; 
				SELECT TOP(1) @branchId = Id FROM Branch WHERE Name = @branch;	
				SELECT TOP(1) @empId = Id FROM Employee WHERE Assigned_Branch_Id = @branchId AND Position LIKE '%Менеджер%';
				SELECT TOP(1) @currId = Id FROM Currency WHERE Name = @currency;
				if(@branchId != 0 AND @empId != 0 AND @currId!= 0)
				BEGIN
					INSERT INTO Account(Cust_Id, Open_Date, Open_Branch_Id, Open_Emp_Id, Balance, Curr_Id, Last_Activity_Date, Close_Date)
										values(@customerId, GETDATE(), @branchId, @empId, @balance, @currId, GETDATE(), NULL);
				END;
				ELSE SET @mess = 'Введенные данные (филиал, начальник, валюта) не существуют!';
			END;
			ELSE SET @mess = 'Клиент не может открыть больше 3х счетов!';
		END;
		ELSE SET @mess = 'Клиента с таким логином не существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--удалить филиал банка
DROP PROCEDURE DelBranch;
GO
CREATE PROCEDURE DelBranch
	@name NVARCHAR(30),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkBranch int, @branchId int, @checkEmployee int, @checkAccount int, @checkTrans int;
		SELECT @checkBranch = count(*) FROM Branch WHERE Name = @name;		
		IF(@checkBranch != 0)
		BEGIN
			SELECT @branchId = Id FROM Branch WHERE Name = @name;
			SELECT @checkEmployee = count(*) FROM Employee WHERE Assigned_Branch_Id = @branchId;
			SELECT @checkAccount = count(*) FROM Account WHERE Open_Branch_Id = @branchId;
			SELECT @checkTrans = count(*) FROM Acc_Transaction T join Temp_Transaction TT ON T.Id=TT.Acc_Tran_Id 
											WHERE T.Execution_Branch_Id = @branchId AND TT.Completed=0;
			IF(@checkEmployee != 0)
				UPDATE Employee SET End_Date=GETDATE(), Assigned_Branch_Id = NULL WHERE Assigned_Branch_Id = @branchId;
			IF(@checkAccount != 0)
				UPDATE Account SET Open_Branch_Id=NULL WHERE Open_Branch_Id = @branchId;
			IF(@checkTrans != 0)
				UPDATE Acc_Transaction SET Execution_Branch_Id=NULL WHERE Execution_Branch_Id = @branchId;
			DELETE FROM Branch WHERE Name LIKE '%'+@name+'%';
		END;
		ELSE SET @mess = 'Филиала с таким названием не существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--удалить департамент банка
DROP PROCEDURE DelDepartment;
GO
CREATE PROCEDURE DelDepartment
	@name NVARCHAR(100),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkDepart int, @checkEmployee int, @departId int;
		SELECT @checkDepart = count(*) FROM Department WHERE Name = @name;
		IF(@checkDepart != 0)
		BEGIN
			SELECT @departId = Id FROM Department WHERE Name=@name;
			SELECT @checkEmployee = count(*) FROM Employee WHERE Depart_Id = @departId;
			IF(@checkEmployee != 0)
				UPDATE Employee SET End_Date=GETDATE(), Depart_Id = NULL WHERE Depart_Id = @departId;
			DELETE FROM Department WHERE Name LIKE '%'+@name+'%';
		END;
		ELSE SET @mess = 'Департамента с таким названием не существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--уволить сотрудника банка
DROP PROCEDURE DelEmployee;
GO
CREATE PROCEDURE DelEmployee
	@login NVARCHAR(30),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkEmployee int, @empId int, @checkSuperior int, @checkAccount int, @checkTrans int;
		SELECT @checkEmployee = count(*) FROM Employee WHERE Login = @login AND End_Date is NULL;
		IF(@checkEmployee != 0)
		BEGIN
			SELECT TOP(1) @empId = Id FROM Employee WHERE Login = @login;
			SELECT @checkSuperior = count(*) FROM Employee WHERE Superior_Emp_Id = @empId;		
			SELECT @checkTrans = count(*) FROM Acc_Transaction T join Temp_Transaction TT on T.Id=TT.Acc_Tran_Id WHERE T.Teller_Emp_Id = @empId AND TT.Completed=0;
		
			IF(@checkSuperior = 0)
			BEGIN
				IF(@checkTrans = 0)
					UPDATE TOP(1) Employee SET End_Date=GETDATE() WHERE Id = @empId;		
				ELSE SET @mess = 'Пожалуйста, смените сотрудника в текущих транзакциях, за которые данный сотрудник отвечает!';
			END;
			ELSE SET @mess = 'Этот сотрудник является руководителем отдела. Пожалуйста, назначьте нового руководителя, прежде чем удалить текущего!';
		END;
		ELSE SET @mess = 'Сотрудника с таким логином не существует или он уже уволен!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--закрыть счет клиента + CLIENT
DROP PROCEDURE DelAccount;
GO
CREATE PROCEDURE DelAccount
	@id INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkAccount INT, @checkTemp INT;
		SELECT @checkAccount = count(*) FROM Account WHERE Id = @id AND Close_Date is NULL;
		IF(@checkAccount != 0)
		BEGIN
			SELECT @checkTemp = count(*) FROM Temp_Transaction TT JOIN Acc_Transaction T ON TT.Acc_Tran_Id=T.Id  WHERE T.Account_Id = @id AND TT.Completed = 0;
			IF(@checkTemp=0)
			BEGIN
				UPDATE Account SET Close_Date=GETDATE() WHERE Id = @id;
				DELETE FROM Credit_Card WHERE Account_Id=id;
			END;
			ELSE SET @mess = 'Прежде чем закрыть счет, закройте все текущие транзакции!';
		END;
		ELSE SET @mess = 'Такого счета не существует или он уже закрыт!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO
	
--завершить текущую транзакцию
DROP PROCEDURE DelTempTransaction;
GO
CREATE PROCEDURE DelTempTransaction
	@id INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkTr int;
		SELECT @checkTr = count(*) FROM Temp_Transaction WHERE Id = @id AND Completed != 1;
		IF(@checkTr != 0)
			UPDATE Temp_Transaction SET Completed=1 WHERE Id = @id;
		ELSE SET @mess = 'Транзакция с таким Id не найдена или уже является завершенной!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--изменить данные о сотруднике банка
DROP PROCEDURE UpdEmployee;
GO
CREATE PROCEDURE UpdEmployee
	@login NVARCHAR(30),
	@position NVARCHAR(30),
	@branch NVARCHAR(30),
	@depart NVARCHAR(100),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkEmployee int, @branchId int, @departId int, @superiorId int;
		SELECT @checkEmployee = count(*) FROM Employee WHERE Login = @login;
		IF(@checkEmployee != 0)
		BEGIN
			SELECT @branchId = Id FROM Branch WHERE Name = @branch;
			SELECT @departId = Id FROM Department WHERE Name = @depart;
			SELECT @superiorId = Id FROM Employee WHERE Assigned_Branch_Id = @branchId AND Depart_Id = @departId AND Position LIKE '%Руководитель%';
			IF(@position like '%руководитель отдела%')
				SET @mess = 'Убедитесь, что предыдущего руководителя отдела уволили!';
			ELSE UPDATE TOP(1) Employee SET Position = @position, Assigned_Branch_Id = @branchId, Depart_Id = @departId,
											Superior_Emp_Id = @superiorId WHERE Login = @login;		
		END;
		ELSE SET @mess = 'Сотрудника с таким логином не существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--сменить руководителя отдела
DROP PROCEDURE UpdSuperior;
GO
CREATE PROCEDURE UpdSuperior
	@login NVARCHAR(30),
	@branch NVARCHAR(30),
	@depart NVARCHAR(100),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkEmployee int, @branchId int, @departId int, @superiorId int;
		SELECT @checkEmployee = Id FROM Employee WHERE Login = @login;
		IF(@checkEmployee > 0)
		BEGIN
			SELECT @branchId = Id FROM Branch WHERE Name = @branch;
			SELECT @departId = Id FROM Department WHERE Name = @depart;
			SELECT @superiorId = Id FROM Employee WHERE Assigned_Branch_Id = @branchId AND Depart_Id = @departId AND Position LIKE '%Руководитель%';
			IF(@superiorId > 0)
				UPDATE TOP(1) Employee SET Position = 'Менеджер', Superior_Emp_Id = @checkEmployee WHERE Id = @superiorId;
				UPDATE TOP(1) Employee SET Position = 'Руководитель отдела', Assigned_Branch_Id = @branchId, Depart_Id = @departId,
								Superior_Emp_Id = NULL WHERE Login = @login;		
		END;
		ELSE SET @mess = 'Сотрудника с таким логином не существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--изменить данные о клиенте банка
DROP PROCEDURE UpdCustomer;
GO
CREATE PROCEDURE UpdCustomer
	@login NVARCHAR(30),
	@region NVARCHAR(20),
	@city NVARCHAR(20),
	@address NVARCHAR(30),
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkLogin int;
		SELECT @checkLogin = count(*) FROM Customer WHERE Login = @login;
		IF(@checkLogin != 0)
			UPDATE Customer SET Region = @region, City = @city, Address = @address WHERE Login = @login;
		ELSE SET @mess = 'Пользователя с таким логином не существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE
GO
 
--экспорт в файл
DROP PROCEDURE ExportToFile;
GO
CREATE PROCEDURE ExportToFile
AS
	SELECT Id, Login, Password, First_Name, Last_Name, Position, Start_Date, 
				Assigned_Branch_Id, Depart_Id, Superior_Emp_Id, End_Date 
	FROM Employee FOR XML PATH('Employee'), ROOT('Root');
GO

--вызов процедуры экспорта в файл
DROP PROCEDURE ExecExport;
GO
CREATE PROCEDURE ExecExport
AS
DECLARE @cmd nvarchar(200);
SET @cmd = 'bcp "EXEC ExportToFile" queryout "d:\Bank\data.xml" -S .\SQLEXPRESS -E -dBank_DB -w -C1251 -r -T';
EXEC master..xp_cmdshell @cmd;
GO

--импорт из файла
DROP PROCEDURE ImportFromFile;
GO
CREATE PROCEDURE ImportFromFile AS
	DECLARE @xml XML;
	SELECT  @xml  = CONVERT(XML,bulkcolumn,2) FROM OPENROWSET(BULK 'D:\Bank\data.xml', SINGLE_BLOB) AS X
	SET ARITHABORT ON	
	DECLARE temp_cursor CURSOR LOCAL READ_ONLY FOR
	SELECT 	Tbl.Col.value('Id[1]', 'int') AS Id,
			Tbl.Col.value('Login[1]', 'nvarchar(30)') AS [Login],
			Tbl.Col.value('Password[1]', 'nvarchar(30)') AS [Password],
			Tbl.Col.value('First_Name[1]', 'nvarchar(30)') AS First_Name,
			Tbl.Col.value('Last_Name[1]', 'nvarchar(30)') AS Last_Name,
			Tbl.Col.value('Position[1]', 'nvarchar(30)') AS Position,
			Tbl.Col.value('Start_Date[1]', 'date') AS Start_Date,
			Tbl.Col.value('Assigned_Branch_Id[1]', 'int') AS Assigned_Branch_Id,
			Tbl.Col.value('Depart_Id[1]', 'int') AS Depart_Id,
			Tbl.Col.value('Superior_Emp_Id[1]', 'int') AS Superior_Emp_Id,
			Tbl.Col.value('End_Date[1]', 'date') AS End_Date FROM  @xml.nodes('/Root/Employee') Tbl(Col); 
	DECLARE @Id INT, @Login NVARCHAR(30), @Password NVARCHAR(30), @First_Name NVARCHAR(30), @Last_Name NVARCHAR(30), @Position NVARCHAR(30), 
			@Start_Date DATE, @Assigned_Branch_Id INT, @Depart_Id INT, @Superior_Emp_Id INT, @End_Date DATE;
	SET IDENTITY_INSERT Employee ON;
	OPEN temp_cursor;
	FETCH NEXT FROM temp_cursor INTO @Id, @Login, @Password, @First_Name, @Last_Name, @Position, @Start_Date, @Assigned_Branch_Id, @Depart_Id, 
										@Superior_Emp_Id, @End_Date;
	WHILE @@FETCH_STATUS = 0
	BEGIN		
		INSERT INTO Employee(Id, Login, Password, First_Name, Last_Name, Position, Start_Date, Assigned_Branch_Id, Depart_Id, Superior_Emp_Id, End_Date)
		 SELECT @Id, @Login, @Password, @First_Name, @Last_Name, @Position, @Start_Date, @Assigned_Branch_Id, @Depart_Id, @Superior_Emp_Id, @End_Date
								WHERE NOT EXISTS(SELECT * FROM Employee WHERE Id = @Id) 
								AND EXISTS(SELECT * FROM Branch WHERE Id = @Assigned_Branch_Id)
								AND EXISTS(SELECT * FROM Department WHERE Id = @Depart_Id);
		FETCH NEXT FROM temp_cursor INTO @Id, @Login, @Password, @First_Name, @Last_Name, @Position, @Start_Date, @Assigned_Branch_Id, @Depart_Id, 
											@Superior_Emp_Id, @End_Date;
	END;
	SET IDENTITY_INSERT Employee OFF;
GO

--------------------------------------CLIENT--------------------------------------
--информация о счетах клиента
DROP PROCEDURE GetClientAccounts;
GO
CREATE PROCEDURE GetClientAccounts
	@custLogin NVARCHAR(30)
AS
BEGIN
	DECLARE @custId INT;
	SELECT @custId = Id FROM Customer WHERE Login = @custLogin;
	IF(@custId > 0)
	SELECT A.Id [ID], A.Cust_Id [ID клиента], A.Open_Date [Дата открытия], A.Open_Branch_Id [ID Филиала], A.Open_Emp_Id [ID Сотрудника], 
		A.Balance [Сумма на счете], C.Name [Валюта], A.Last_Activity_Date [Дата последней активности], A.Close_Date [Дата закрытия]
	FROM Account A INNER JOIN Currency C ON A.Curr_Id = C.Id WHERE A.Cust_Id = @custId AND A.Close_Date is NULL;
END;
GO

--информация о платежных картах клиента
--DROP PROCEDURE GetClientCard;
--GO
--CREATE PROCEDURE GetClientCard
--	@accId INT,
--	@mess NVARCHAR(200) OUTPUT
--AS
--BEGIN
--	DECLARE @check BIGINT;
--	SET @mess='';
--	SELECT @check = Id FROM Credit_Card WHERE Account_Id = @accId;
--	IF(@check > 0)
--		SELECT CC.Id [ID], CC.Cust_Id [ID клиента], CC.Account_Id [ID счета], CC.Open_Date [Дата открытия], CONVERT(NVARCHAR(32), DECRYPTBYKEY(CC.Validity)) [Дата действительности], C.Name [Валюта]
--		FROM Credit_Card CC INNER JOIN Currency C ON CC.Curr_Id = C.Id WHERE CC.Account_Id = @accId;
--	ELSE SET @mess = 'Для данного счета платежная карта не была оформлена!';
--END;
--GO

--информация о текущих транзакциях по логину клиента
DROP PROCEDURE GetTempTransactions;
GO
CREATE PROCEDURE GetTempTransactions
	@login NVARCHAR(30)
AS
BEGIN
	DECLARE @custId INT;
	SELECT @custId = Id FROM Customer WHERE Login = @login;
	IF(@custId > 0)
	BEGIN
		SELECT TT.Id [ID], TT.Acc_Tran_Id [ID транзакции], T.Amount [Сумма], T.Rest [Остаток выплаты], T.DateTime [Время], P.Name [Услуга], isnull(TT.Date_Retired, T.DateTime) [Дата выплаты], isnull(TT.Completed, 1) [Завершена]
		FROM Account A	INNER JOIN Acc_Transaction T ON A.Id = T.Account_Id
						INNER JOIN Product P ON T.Type_Prod_Id=P.Id
						LEFT OUTER JOIN Temp_Transaction TT ON TT.Acc_Tran_Id=T.Id
		WHERE A.Cust_Id = @custId AND TT.Completed=0 OR TT.Completed=NULL
		ORDER BY TT.Id;
	END;
END;
GO

--информация о транзакциях по логину клиента
DROP PROCEDURE GetAccTransactions;
GO
CREATE PROCEDURE GetAccTransactions
	@login NVARCHAR(30)
AS
BEGIN
	DECLARE @custId INT;
	SELECT @custId = Id FROM Customer WHERE Login = @login;
	IF(@custId > 0)
SELECT T.Id [ID], T.Account_Id [Аккаунт ID], T.Amount [Сумма], T.Rest [Остаток выплаты], T.DateTime [Время], P.Name [Услуга],
			isnull(TT.Date_Retired, T.DateTime) [Дата выплаты], isnull(TT.Completed, 1) [Завершена], TT.Id [ID текущей транзакции]
FROM Account A	INNER JOIN Acc_Transaction T ON A.Id = T.Account_Id
						INNER JOIN Product P ON T.Type_Prod_Id=P.Id
						LEFT OUTER JOIN Temp_Transaction TT ON TT.Acc_Tran_Id=T.Id
WHERE A.Cust_Id = @custId
ORDER BY T.Id;
END;
GO

--оформить платежную карту
DROP PROCEDURE CreateCard;
GO
CREATE PROCEDURE CreateCard
	@accountId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkCard INT, @valid varbinary(max);	
		SELECT @checkCard = count(*) FROM Credit_Card WHERE Account_Id = @accountId;
		IF(@checkCard = 0)
		BEGIN		
			DECLARE @mm CHAR(2), @s CHAR(1), @yy CHAR(2);
			SET @mm=cast(MONTH(GETDATE()) as char);
			SET @s=cast('/' as char);
			SET @yy = cast(right(YEAR(GETDATE()),2)+4 as char);
			SET @valid = convert(varbinary(max),concat(@mm,@s,@yy));
			INSERT INTO Credit_Card(Account_Id, Open_Date, Validity) 
							VALUES(@accountId, GETDATE(), @valid);
		END;
		ELSE SET @mess = 'Карта, привязанная к этому счету, уже существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--удалить платежную карту
DROP PROCEDURE DelCard;
GO
CREATE PROCEDURE DelCard
	@accId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkCard int;
		SELECT @checkCard = count(*) FROM Credit_Card WHERE Account_Id = @accId;
		IF(@checkCard != 0)
			DELETE FROM Credit_Card WHERE Account_Id = @accId;
		ELSE SET @mess = 'Такой карты не существует!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--пополнить счет
DROP PROCEDURE PutMoney;
GO
CREATE PROCEDURE PutMoney
	@accountId INT,
	@amount MONEY,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkAccount INT;
		SELECT @checkAccount = count(*) FROM Account WHERE Id = @accountId AND Close_Date is NULL;
		IF(@checkAccount != 0)
		BEGIN
			DECLARE @prodId INT, @branchId INT, @empId INT;
			UPDATE Account SET Balance += @amount WHERE Id = @accountId;
			SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @accountId;
			SELECT @prodId = Id FROM Product WHERE Name = 'Пополнение счета';
			INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
								values(@accountId, @amount, default, GETDATE(), @prodId, @branchId, @empId);
		END;
		ELSE SET @mess = 'Такого счета не существует или он уже закрыт!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--снять денежные средства со счета
DROP PROCEDURE WithdrawMoney;
GO
CREATE PROCEDURE WithdrawMoney
	@accountId INT,
	@amount MONEY,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkAccount INT, @balance MONEY;
		SELECT @checkAccount = count(*) FROM Account WHERE Id = @accountId AND Close_Date is NULL;
		IF(@checkAccount != 0)
		BEGIN
			SELECT @balance = Balance FROM Account WHERE Id = @accountId;
			IF(@balance>=@amount)
			BEGIN
				DECLARE @prodId INT, @branchId INT, @empId INT;
				UPDATE Account SET Balance -= @amount WHERE Id = @accountId;
				SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @accountId;
				SELECT @prodId = Id FROM Product WHERE Name = 'Снятие денежных средств';
				INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
									values(@accountId, @amount, default, GETDATE(), @prodId, @branchId, @empId);
			END;
			ELSE SET @mess = 'Недостаточно средств!';
		END;
		ELSE SET @mess = 'Такого счета не существует или он уже закрыт!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--перевод денежных средств со счета на счет одного лица
DROP PROCEDURE TransYourself;
GO
CREATE PROCEDURE TransYourself
	@fromId INT,
	@amount MONEY,
	@toId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkFrom INT, @checkTo INT, @custFrom INT, @custTo INT, @balance MONEY;
		SELECT @checkFrom = Curr_Id, @custFrom = Cust_Id FROM Account WHERE Id = @fromId AND Close_Date is NULL;
		SELECT @checkTo = Curr_Id, @custTo = Cust_Id FROM Account WHERE Id = @toId AND Close_Date is NULL;
		IF(@checkFrom > 0 AND @checkTo > 0)
		BEGIN
			IF(@custFrom = @custTo)
			BEGIN
				IF(@checkFrom = @checkTo)
				BEGIN
					SELECT @balance = Balance FROM Account WHERE Id = @checkFrom;
					IF(@balance>=@amount)
					BEGIN
						DECLARE @prodId INT, @branchId INT, @empId INT;
						UPDATE Account SET Balance -= @amount WHERE Id = @fromId;
						UPDATE Account SET Balance += @amount WHERE Id = @toId;
						SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @fromId;
						SELECT @prodId = Id FROM Product WHERE Name = 'Перевод средств со счета на счет одного лица';
						INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
											values(@fromId, @amount, default, GETDATE(), @prodId, @branchId, @empId);
					END;
					ELSE SET @mess = 'Недостаточно средств для перевода!';
				END;
				ELSE SET @mess = 'Счета с разными валютами! Воспользуйтесь услугой "Перевод денежных средств с обменом валюты" для такого случая!';
			END;
			ELSE SET @mess = 'Счета не являются счетами одного лица!';
		END;
		ELSE SET @mess = 'Такого(их) счета(ов) не существует или он(и) уже закрыт(ы)!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--перевод денежных средств со счета на счет другого лица
DROP PROCEDURE TransAnother;
GO
CREATE PROCEDURE TransAnother
	@fromId INT,
	@amount MONEY,
	@toId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkFrom INT, @checkTo INT, @currFrom INT, @currTo INT, @balance MONEY;
		SELECT @checkFrom = count(*) FROM Account WHERE Id = @fromId AND Close_Date is NULL;
		SELECT @checkTo = count(*) FROM Account WHERE Id = @toId AND Close_Date is NULL;
		IF(@checkFrom != 0 AND @checkTo != 0)
		BEGIN
			SELECT @balance = Balance, @currFrom = Curr_Id FROM Account WHERE Id = @fromId;
			SELECT @currTo = Curr_Id FROM Account WHERE Id = @toId;
			IF(@currFrom=@currTo)
			BEGIN
				IF(@balance>=@amount)
				BEGIN
					DECLARE @prodId INT, @branchId INT, @empId INT;
					UPDATE Account SET Balance -= @amount*1.03 WHERE Id = @fromId;
					UPDATE Account SET Balance += @amount WHERE Id = @toId;
					SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @fromId;
					SELECT @prodId = Id FROM Product WHERE Name = 'Перевод средств со счета на счет другого лица';
					INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
										values(@fromId, @amount*1.03, default, GETDATE(), @prodId, @branchId, @empId);
				END;
				ELSE SET @mess = 'Недостаточно средств для перевода!';
			END;
			ELSE SET @mess = 'Счета с разными валютами! Воспользуйтесь услугой "Перевод денежных средств с обменом валюты" для такого случая!';
		END;
		ELSE SET @mess = 'Такого(их) счета(ов) не существует или он(и) уже закрыт(ы)!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--функция-конвертер валют
DROP FUNCTION CurrExchange;
GO
CREATE FUNCTION CurrExchange(@curr1 VARCHAR(3), @curr2 VARCHAR(3)) RETURNS FLOAT
BEGIN
	DECLARE @rc FLOAT;
	SET @rc = CASE
		WHEN @curr1='BYN' AND @curr2='RUB' THEN 31.18
		WHEN @curr1='BYN' AND @curr2='USD' THEN 0.49
		WHEN @curr1='USD' AND @curr2='BYN' THEN 2.05
		WHEN @curr1='USD' AND @curr2='RUB' THEN 63.75
		WHEN @curr1='RUB' AND @curr2='BYN' THEN 0.032
		WHEN @curr1='RUB' AND @curr2='USD' THEN 0.016
		ELSE 1
	END;
	RETURN @rc;
END;
GO

--перевод денежных средств с обменом валюты
DROP PROCEDURE TransExchange;
GO
CREATE PROCEDURE TransExchange
	@fromId INT,
	@amount MONEY,
	@toId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkFrom INT, @checkTo INT, @balance MONEY, @currIdFrom INT, @currIdTo INT, @curr1 VARCHAR(3), @curr2 VARCHAR(3);
		SELECT @checkFrom = count(*) FROM Account WHERE Id = @fromId AND Close_Date is NULL;
		SELECT @checkTo = count(*) FROM Account WHERE Id = @toId AND Close_Date is NULL;
		IF(@checkFrom != 0 AND @checkTo != 0)
		BEGIN			
			SELECT @balance = Balance, @currIdFrom = Curr_Id FROM Account WHERE Id = @fromId;
			SELECT @currIdTo = Curr_Id FROM Account WHERE Id = @toId;
			SELECT @curr1 = Name FROM Currency WHERE Id = @currIdFrom;			
			SELECT @curr2 = Name FROM Currency WHERE Id = @currIdTo;
			IF(@balance>=@amount)
			BEGIN
				DECLARE @prodId INT, @branchId INT, @empId INT;
				UPDATE Account SET Balance -= @amount WHERE Id = @fromId;
				UPDATE Account SET Balance += @amount*dbo.CurrExchange(@curr1,@curr2) WHERE Id = @toId;
				SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @fromId;
				SELECT @prodId = Id FROM Product WHERE Name = 'Перевод средств с обменом валюты';
				INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
									values(@fromId, @amount*dbo.CurrExchange(@curr1,@curr2), default, GETDATE(), @prodId, @branchId, @empId);
			END;
			ELSE SET @mess = 'Недостаточно средств для перевода!';
		END;
		ELSE SET @mess = 'Такого(их) счета(ов) не существует или он(и) уже закрыт(ы)!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--оформить кредит
DROP PROCEDURE TakeCredit;
GO
CREATE PROCEDURE TakeCredit
	@accountId INT,
	@amount MONEY,
	@end DATE,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkAccount INT, @checkCredit INT, @prodId INT, @branchId INT, @empId INT, @tId INT;
		SELECT @checkAccount = count(*) FROM Account WHERE Id = @accountId AND Close_Date is NULL;
		IF(@checkAccount != 0)
		BEGIN		
			SELECT @checkCredit = count(*) FROM Temp_Transaction WHERE Acc_Tran_Id = @accountId AND Completed = 0;
			IF(@checkCredit < 2)
			BEGIN
				SELECT @prodId = Id FROM Product WHERE Name = 'Оформление кредита';
				SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @accountId;
				INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
										VALUES( @accountId, @amount, @amount, GETDATE(), @prodId, @branchId, @empId);
				SELECT TOP(1) @tId = Id FROM Acc_Transaction ORDER BY Id DESC;
				INSERT INTO Temp_Transaction(Acc_Tran_Id, Date_Retired, Completed) VALUES(@tid, @end, 0);			
				UPDATE Account SET Balance += @amount WHERE Id = @accountId;
			END;
			ELSE SET @mess = 'В кредите отказано! Одному клиенту допустимо иметь не более двух открытых кредитов!';
		END;
		ELSE SET @mess = 'Такого счета не существует или он уже закрыт!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--пополнить кредит
DROP PROCEDURE PayCredit;
GO
CREATE PROCEDURE PayCredit
	@accountId INT,
	@amount MONEY,
	@transId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkTrans INT, @checkAccount INT, @checkRest MONEY, @checkTemp BIT;
		SELECT @checkAccount = count(*) FROM Account WHERE Id = @accountId AND Close_Date is NULL;
		IF(@checkAccount != 0)
		BEGIN	
			SELECT @checkTrans = Acc_Tran_Id, @checkTemp = Completed FROM Temp_Transaction WHERE Id = @transId;
			IF(@checkTemp = 0)
				BEGIN
				DECLARE @prodId INT, @branchId INT, @empId INT;
				UPDATE Account SET Balance -= @amount WHERE Id = @accountId;
				UPDATE Acc_Transaction SET Rest -= @amount WHERE Id = @checkTrans;
				SELECT @checkRest = Rest FROM Acc_Transaction WHERE Id = @checkTrans;
				
				SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @accountId;
				SELECT @prodId = Id FROM Product WHERE Name = 'Пополнение кредита';
				INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
									values(@accountId, @amount, @checkRest, GETDATE(), @prodId, @branchId, @empId);
				
				IF(@checkRest = 0)
					UPDATE Temp_Transaction SET Completed = 1 WHERE Acc_Tran_Id = @checkTrans;
				ELSE IF(@checkRest < 0)
				BEGIN
					UPDATE Acc_Transaction SET Rest = 0 WHERE Id = @checkTrans;
					UPDATE Temp_Transaction SET Completed = 1 WHERE Acc_Tran_Id = @checkTrans;
					UPDATE Account SET Balance -= @checkRest WHERE Id = @accountId;
				END;
			END;
			ELSE SET @mess = 'Эта транзакция уже закрыта! Кредит погашен';
		END;
		ELSE SET @mess = 'Такого счета не существует или он уже закрыт!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO

--погасить кредит полностью
DROP PROCEDURE CloseCredit;
GO
CREATE PROCEDURE CloseCredit
	@accountId INT,
	@transId INT,
	@mess NVARCHAR(200) OUTPUT
AS
BEGIN
	SET @mess='';
	BEGIN TRY
		DECLARE @checkTrans INT, @checkAccount INT, @checkRest MONEY, @checkTemp BIT;
		SELECT @checkAccount = count(*) FROM Account WHERE Id = @accountId AND Close_Date is NULL;
		IF(@checkAccount != 0)
		BEGIN	
			SELECT @checkTrans = Acc_Tran_Id, @checkTemp = Completed FROM Temp_Transaction WHERE Id = @transId;
			IF(@checkTemp = 0)
				BEGIN
					DECLARE @prodId INT, @branchId INT, @empId INT;
					SELECT @checkRest = Rest FROM Acc_Transaction WHERE Id = @checkTrans;				
					UPDATE Account SET Balance -= @checkRest WHERE Id = @accountId;
					UPDATE Acc_Transaction SET Rest = 0 WHERE Id = @checkTrans;				
					UPDATE Temp_Transaction SET Completed = 1 WHERE Acc_Tran_Id = @checkTrans;

					SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @accountId;
					SELECT @prodId = Id FROM Product WHERE Name = 'Досрочное закрытие кредита';
					INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
										values(@accountId, @checkRest, default, GETDATE(), @prodId, @branchId, @empId);
				END;
			ELSE SET @mess = 'Эта транзакция уже закрыта! Кредит погашен';
		END;
		ELSE SET @mess = 'Такого счета не существует или он уже закрыт!';
	END TRY
	BEGIN CATCH
		SET @mess = 'Ошибка системы!';
	END CATCH;
END
GO