using BankApp.db;
using BankApp.pages.client;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages
{
    public partial class ClientMainPage : Page
    {
        Client _client;
        string connStr = @"Data Source=DESKTOP-1JIVBFF\SQLEXPRESS;Initial Catalog=Bank_DB;Integrated Security=False;User ID=Client;Password=Client;";
        //string connStr = @"Data Source=DESKTOP-1JIVBFF\SQLEXPRESS;Initial Catalog=Bank_DB;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";


        public ClientMainPage(Client client)
        {
            InitializeComponent();
            ClientFrame.Navigate(new AccountPage(client, connStr));
            tb_Welcome.Text += client.ToString() + "!";
            _client = client;
        }

        private void PayHistory_Click(object sender, RoutedEventArgs e)
        {
            ClientFrame.Navigate(new HistoryPage(_client, connStr));
        }

        private void CheckAccounts_Click(object sender, RoutedEventArgs e)
        {
            ClientFrame.Navigate(new AccountPage(_client, connStr));
        }

        private void Payments_Click(object sender, RoutedEventArgs e)
        {
            ClientFrame.Navigate(new PaymentsPage(_client, connStr));
        }

        private void Credit_Click(object sender, RoutedEventArgs e)
        {
            ClientFrame.Navigate(new CreditPage(_client, connStr));
        }

        private void Trans_Click(object sender, RoutedEventArgs e)
        {
            ClientFrame.Navigate(new TransPage(_client, connStr));
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
    }
}
