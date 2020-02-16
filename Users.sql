USE Bank_DB;

DROP LOGIN Admin;
DROP USER Admin;
CREATE LOGIN Admin WITH PASSWORD = 'Admin';
CREATE USER Admin FOR LOGIN Admin;

GRANT EXECUTE ON AddAccount TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON AddBranch TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON AddBusinessClient TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON AddDepartment TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON AddEmployee TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON AddIndividualClient TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON AddProduct TO Admin WITH GRANT OPTION;

GRANT EXECUTE ON DelAccount TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON DelBranch TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON DelDepartment TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON DelEmployee TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON DelTempTransaction TO Admin WITH GRANT OPTION;

GRANT EXECUTE ON UpdCustomer TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON UpdEmployee TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON UpdSuperior TO Admin WITH GRANT OPTION;

GRANT EXECUTE ON GetAllAccounts  TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetAllBranches TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetAllCurrency TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetAllDepartments TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetAllEmployees TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetAllProducts TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetAllTransactions TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetBusinessClients TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetIndividualClients TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetOneClient TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON GetOneEmployee TO Admin WITH GRANT OPTION;

--GRANT EXECUTE ON xp_cmdshell TO Admin;
ALTER SERVER ROLE [bulkadmin] ADD MEMBER Admin;
GRANT ALTER ON Employee TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON ExportToFile TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON ExecExport TO Admin WITH GRANT OPTION;
GRANT EXECUTE ON ImportFromFile TO Admin WITH GRANT OPTION;
GO

 -------------------------------------------------------------------------------
 
DROP LOGIN Client;
DROP USER Client;
CREATE LOGIN Client WITH PASSWORD = 'Client';
CREATE USER Client FOR LOGIN Client;

GRANT EXECUTE ON AddAccount TO Client;
GRANT EXECUTE ON CloseCredit TO Client;
GRANT EXECUTE ON CreateCard TO Client;
GRANT EXECUTE ON DelAccount TO Client;
GRANT EXECUTE ON DelCard TO Client;

GRANT EXECUTE ON GetAllBranches TO Client;
GRANT EXECUTE ON GetAllCurrency TO Client;
GRANT EXECUTE ON GetClientAccounts TO Client;
GRANT EXECUTE ON GetClientCard TO Client;
GRANT EXECUTE ON GetTempTransactions TO Client;
GRANT EXECUTE ON GetAccTransactions TO Client;

GRANT EXECUTE ON PayCredit TO Client;
GRANT EXECUTE ON PutMoney TO Client;
GRANT EXECUTE ON TakeCredit TO Client;
GRANT EXECUTE ON TransAnother TO Client;
GRANT EXECUTE ON TransExchange TO Client;
GRANT EXECUTE ON TransYourself TO Client;
GRANT EXECUTE ON WithdrawMoney TO Client;

GRANT EXECUTE ON dbo.CurrExchange TO Client;
