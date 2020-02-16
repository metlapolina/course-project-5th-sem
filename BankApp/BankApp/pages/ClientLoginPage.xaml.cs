using BankApp.db;
using System;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages
{
    public partial class LoginClientPage : Page
    {
        string strConn = @"Data Source=DESKTOP-1JIVBFF\SQLEXPRESS;Initial Catalog=Bank_DB;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

        public LoginClientPage()
        {
            InitializeComponent();

            DB db = new DB();
            db.OpenConnection(strConn);
            cb_Region.ItemsSource = db.GetAllRegions();
            db.CloseConnection();
        }

        private void LogIn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (Login.Text.Length == 0 || Password.Password.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(strConn);
                    var info = db.GetOneClient(Login.Text);
                    string result = db.IsClient(Login.Text, Password.Password);
                    db.CloseConnection();
                    if (result.Length != 0)
                    {
                        Client client = new Client(Login.Text, Password.Password, info[3], info[4], info[0], info[1], info[2]);
                        MainWindow mainWindow = new MainWindow(result, client);
                        mainWindow.Show();
                        Window.GetWindow(this).Close();
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


        private void Register_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (txt_Login.Text.Length == 0 || PasswordBoxdReg1.Password.Length == 0 || txt_Name.Text.Length == 0 || dp_Date.SelectedDate == null || cb_Region.Text.Length == 0 || txt_City.Text.Length == 0 || txt_Address.Text.Length == 0)
                {
                    MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else if (PasswordBoxdReg1.Password != PasswordBoxdReg2.Password)
                {
                    MessageBox.Show("Пароли не совпадают!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(strConn);
                    string message;
                    if (rb_Indiv.IsChecked == true)
                        message = db.AddIndividualClient(txt_Login.Text, PasswordBoxdReg1.Password, txt_Name.Text, txt_Surname.Text, dp_Date.SelectedDate, cb_Region.Text, txt_City.Text, txt_Address.Text);
                    else
                        message = db.AddBusinessClient(txt_Login.Text, PasswordBoxdReg1.Password, txt_Name.Text, dp_Date.SelectedDate, cb_Region.Text, txt_City.Text, txt_Address.Text);
                    db.CloseConnection();
                    if (message.Length != 0)
                    {
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                    else
                    {
                        Client client = new Client(txt_Login.Text, PasswordBoxdReg1.Password, txt_Name.Text, txt_Surname.Text, txt_Surname.Text, txt_City.Text, txt_Address.Text);
                        MainWindow mainWindow = new MainWindow("Client", client);
                        mainWindow.Show();
                        Window.GetWindow(this).Close();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void LogInEmployee_Click(object sender, RoutedEventArgs e)
        {
            var employeeLogin = new EmployeeLoginWindow(this);
            employeeLogin.ShowDialog();
        }

        private void RadioButton_Checked(object sender, RoutedEventArgs e)
        {
            txt_Surname.IsEnabled = false;
        }

        private void RadioButton_Unchecked(object sender, RoutedEventArgs e)
        {
            txt_Surname.IsEnabled = true;
        }

    }
}
