using BankApp.db;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages
{
    public partial class AdminMainPage : Page
    {
        string connStr = @"Data Source=DESKTOP-1JIVBFF\SQLEXPRESS;Initial Catalog=Bank_DB;Integrated Security=False;User ID=Admin;Password=Admin;";
        string conn = @"Data Source=DESKTOP-1JIVBFF\SQLEXPRESS;Initial Catalog=Bank_DB;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        DataTable dataTable = new DataTable();

        public AdminMainPage()
        {
            InitializeComponent();

            FillCB();            
        }

        private void FillCB()
        {
            try
            {
                DB db = new DB();
                db.OpenConnection(connStr);

                var source = db.GetAllCurrency();
                string currency = "";
                foreach (var item in source)
                {
                    currency += item + "; ";
                }

                cb_Currency.ItemsSource = source;
                cb_Currency.SelectedItem = source[1];
                lb_Currency.Content = currency;
                cb_Branch.ItemsSource = cb_EmpBranch.ItemsSource = cb_UpdEmpBranch.ItemsSource = cb_DelBrLogin.ItemsSource = cb_UpdEBranch.ItemsSource = db.GetAllBranches();
                cb_BrRegion.ItemsSource = cb_Region.ItemsSource = cb_UpdRegion.ItemsSource = db.GetAllRegions();
                cb_EmpDepartment.ItemsSource = cb_UpdEmpDepart.ItemsSource = cb_DelDepart.ItemsSource = cb_UpdEDepart.ItemsSource = db.GetAllDepartments();

                db.CloseConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void RadioButton_Checked(object sender, RoutedEventArgs e)
        {
            txt_Surname.IsEnabled = false;
        }

        private void RadioButton_Unchecked(object sender, RoutedEventArgs e)
        {
            txt_Surname.IsEnabled = true;
        }

        private void LoginPage_Click(object sender, RoutedEventArgs e)
        {
            var answer = MessageBox.Show("Вы уверены, что хотите выйти?", "Выход", MessageBoxButton.OKCancel, MessageBoxImage.Exclamation, MessageBoxResult.Cancel);
            if (answer.Equals(MessageBoxResult.OK))
            {
                MainWindow loginPage = new MainWindow();
                loginPage.Show();
                Window.GetWindow(this).Close();
            }
        }

        private void GetInd_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetIndividualClients";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void GetBus_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetBusinessClients";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void GetAcc_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetAllAccounts";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void GetTran_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetAllTransactions";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void GetEmp_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetAllEmployees";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void GetBranch_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetAllBranches";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void GetDepart_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetAllDepartments";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void GetProd_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "GetAllProducts";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    dataTable.Clear();
                    dataTable = new DataTable();
                    command.Fill(dataTable);
                    dataGrid.ItemsSource = dataTable.DefaultView;
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void AddEmp_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_EmpLogin.Text.Length == 0 || EmpPassword.Password.Length == 0 || txt_EmpName.Text.Length == 0 || txt_EmpPosition.Text.Length == 0 || txt_EmpSurname.Text.Length == 0 || dp_EmpStartDate.SelectedDate == null || cb_EmpBranch.Text.Length == 0 || cb_EmpDepartment.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.AddEmployee(txt_EmpLogin.Text, EmpPassword.Password, txt_EmpName.Text, txt_EmpPosition.Text, txt_EmpSurname.Text, dp_EmpStartDate.SelectedDate, cb_EmpBranch.Text, cb_EmpDepartment.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно добавлены");
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void AddClient_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_Login.Text.Length == 0 || ps_Password.Password.Length == 0 || txt_Name.Text.Length == 0 || dp_Date.SelectedDate == null || cb_Region.Text.Length == 0 || txt_City.Text.Length == 0 || txt_Address.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message;
                    if (rb_Indiv.IsChecked == true)
                    {
                        message = db.AddIndividualClient(txt_Login.Text, ps_Password.Password, txt_Name.Text, txt_Surname.Text, dp_Date.SelectedDate, cb_Region.Text, txt_City.Text, txt_Address.Text);
                    }
                    else
                    {
                        message = db.AddBusinessClient(txt_Login.Text, ps_Password.Password, txt_Name.Text, dp_Date.SelectedDate, cb_Region.Text, txt_City.Text, txt_Address.Text);
                    }
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно добавлены");
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void AddAccount_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_AccLogin.Text.Length == 0 || cb_Branch.Text.Length == 0 || txt_Balance.Text.Length == 0 || cb_Currency.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    if (!float.TryParse(txt_Balance.Text, out float f))
                    {
                        MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                    else
                    {
                        DB db = new DB();
                        db.OpenConnection(connStr);
                        string message = db.AddAccount(txt_AccLogin.Text, cb_Branch.Text, float.Parse(txt_Balance.Text), cb_Currency.Text);
                        db.CloseConnection();
                        if (message.Length != 0)
                            MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                        else
                            MessageBox.Show("Данные успешно добавлены");
                    }
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void AddBranch_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_BrLogin.Text.Length == 0 || cb_BrRegion.Text.Length == 0 || txt_BrCity.Text.Length == 0 || txt_BrAddress.Text.Length == 0 || txt_BrIndex.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    if (!int.TryParse(txt_BrIndex.Text, out int i) || txt_BrIndex.Text.Length != 6)
                    {
                        MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                    else
                    {
                        DB db = new DB();
                        db.OpenConnection(connStr);
                        string message = db.AddBranch(txt_BrLogin.Text, cb_BrRegion.Text, txt_BrCity.Text, txt_BrAddress.Text, int.Parse(txt_BrIndex.Text));
                        db.CloseConnection();
                        if (message.Length != 0)
                            MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                        else
                            MessageBox.Show("Данные успешно добавлены");
                    }
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void AddProduct_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_NewProduct.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.AddProduct(txt_NewProduct.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно добавлены");
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void AddDepart_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_NewDepart.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.AddDepartment(txt_NewDepart.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно добавлены");
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }


        private void UpdEmpFind_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_UpdEmpLogin.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    var result = db.GetOneEmployee(txt_UpdEmpLogin.Text);
                    db.CloseConnection();
                    if (result.Count != 0)
                    {
                        txt_UpdEmpPosition.Text = result[0];
                        cb_UpdEmpBranch.SelectedItem = result[1];
                        cb_UpdEmpDepart.SelectedItem = result[2];
                    }
                    else
                    {
                        MessageBox.Show("Такого сотрудника не существует!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void UpdCustFind_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_UpdLogin.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    var result = db.GetOneClient(txt_UpdLogin.Text);
                    db.CloseConnection();
                    if (result.Count != 0)
                    {
                        cb_UpdRegion.Text = result[0];
                        txt_UpdCity.Text = result[1];
                        txt_UpdAddress.Text = result[2];
                    }
                    else
                    {
                        MessageBox.Show("Такого клиента не существует!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void UpdEmployee_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_UpdEmpLogin.Text.Length == 0 || txt_UpdEmpPosition.Text.Length == 0 || cb_UpdEmpBranch.Text.Length == 0 || cb_UpdEmpDepart.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.UpdEmployee(txt_UpdEmpLogin.Text, txt_UpdEmpPosition.Text, cb_UpdEmpBranch.Text, cb_UpdEmpDepart.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно изменены");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void UpdCustomer_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_UpdLogin.Text.Length == 0 || cb_UpdRegion.Text.Length == 0 || txt_UpdCity.Text.Length == 0 || txt_UpdAddress.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.UpdCustomer(txt_UpdLogin.Text, cb_UpdRegion.Text, txt_UpdCity.Text, txt_UpdAddress.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно изменены");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void UpdSuperior_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_UpdEmployee.Text.Length == 0 || cb_UpdEBranch.Text.Length == 0 || cb_UpdEDepart.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.UpdSuperior(txt_UpdEmployee.Text, cb_UpdEBranch.Text, cb_UpdEDepart.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно изменены");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DelAccount_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_DelAccLogin.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.DelAccount(int.Parse(txt_DelAccLogin.Text));
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно удалены");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DelEmp_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_DelEmpLogin.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.DelEmployee(txt_DelEmpLogin.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно удалены");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DelBranch_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (cb_DelBrLogin.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.DelBranch(cb_DelBrLogin.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно удалены");
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DellDepart_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (cb_DelDepart.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.DelDepartment(cb_DelDepart.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно удалены");
                }
                FillCB();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DelTempTr_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (cb_DelDepart.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    if (!int.TryParse(txt_DelTrLogin.Text, out int i))
                    {
                        MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                    else
                    {
                        DB db = new DB();
                        db.OpenConnection(connStr);
                        string message = db.DelTempTransaction(int.Parse(txt_DelTrLogin.Text));
                        db.CloseConnection();
                        if (message.Length != 0)
                            MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                        else
                            MessageBox.Show("Данные успешно удалены");
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void ExportToFile_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(conn))
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("ExecExport", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                    connection.Close();
                    MessageBox.Show("Данные успешно выгружены");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void ImportFromFile_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("ImportFromFile", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                    connection.Close();
                    MessageBox.Show("Данные успешно загружены");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
