USE Bank_DB;
GO

--������� ��������� ���������� "���������� �����" ��� insert � ������� Account
DROP TRIGGER TRANS_AFTER_ADD_ACC;
GO
CREATE TRIGGER TRANS_AFTER_ADD_ACC
ON Account AFTER INSERT
AS
	DECLARE @id INT, @prodId INT, @branchId INT, @empId INT;
	SELECT @id = Id, @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM inserted;
	SELECT @prodId = Id FROM Product WHERE Name = '���������� �����';
	INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
					values(@id, default, default, GETDATE(), @prodId, @branchId, @empId);
RETURN;
GO

--������� ��������� ���������� "���������� ���������� �����" ��� insert � ������� Credit_Card
DROP TRIGGER TRANS_AFTER_ADD_CARD;
GO
CREATE TRIGGER TRANS_AFTER_ADD_CARD
ON Credit_Card AFTER INSERT
AS
	DECLARE @id INT, @prodId INT, @branchId INT, @empId INT;
	SELECT @id = Account_Id FROM inserted;
	SELECT @branchId = Open_Branch_Id, @empId = Open_Emp_Id FROM Account WHERE Id = @id;
	SELECT @prodId = Id FROM Product WHERE Name = '���������� ���������� �����';
	INSERT INTO Acc_Transaction(Account_Id, Amount, Rest, DateTime, Type_Prod_Id, Execution_Branch_Id, Teller_Emp_Id)
					values(@id, default, default, GETDATE(), @prodId, @branchId, @empId);
RETURN;
GO

--������� ��������� ���������� � ����������� ��� ���������� ���������� ������
DROP TRIGGER TRANS_AFTER_UPD_EMP;
GO
CREATE TRIGGER TRANS_AFTER_UPD_EMP
ON Employee AFTER UPDATE
AS
	DECLARE @id INT, @pos1 NVARCHAR(30), @pos2 NVARCHAR(30), @branchId INT, @departId INT;
	SELECT @id = Id, @pos1 = Position, @branchId = Assigned_Branch_Id, @departId = Depart_Id FROM deleted;
	SELECT @pos2 = Position FROM inserted;
	IF(@pos1 != @pos2 AND @pos2 = '������������ ������')
		UPDATE Employee SET Superior_Emp_Id = @id 
		WHERE Assigned_Branch_Id = @branchId AND Depart_Id = @departId AND Id != @id;
RETURN;
GO