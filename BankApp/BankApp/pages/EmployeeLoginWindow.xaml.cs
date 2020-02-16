using BankApp.db;
using System.Windows;

namespace BankApp.pages
{
    public partial class EmployeeLoginWindow : Window
    {
        private LoginClientPage loginClientPage;
        string strConn = @"Data Source=DESKTOP-1JIVBFF\SQLEXPRESS;Initial Catalog=Bank_DB;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

        public EmployeeLoginWindow(LoginClientPage loginPage)
        {
            InitializeComponent();
            loginClientPage = loginPage;
        }

        private void LogIn_Click(object sender, RoutedEventArgs e)
        {
            if (Login.Text.Length == 0 || Password.Password.Length == 0)
            {
                MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(strConn);
                string result = db.IsEmployee(Login.Text, Password.Password);
                db.CloseConnection();
                if (result.Length != 0)
                {
                    MainWindow mainWindow = new MainWindow(result, null);
                    mainWindow.Show();
                    Close();
                    GetWindow(loginClientPage).Close();
                }
                else
                {
                    MessageBox.Show("Такого сотрудника не существует!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
    }
}