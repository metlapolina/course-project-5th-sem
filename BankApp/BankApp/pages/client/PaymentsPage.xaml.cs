using BankApp.db;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages
{
    public partial class PaymentsPage : Page
    {
        string connStr;
        Client _client;

        public PaymentsPage(Client client, string conn)
        {
            InitializeComponent();

            connStr = conn;
            _client = client;

            DB db = new DB();
            db.OpenConnection(connStr);
            cb_Accounts.ItemsSource = db.GetClientAccounts(_client.Login);
            db.CloseConnection();
        }

        private void PutMoney_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(cb_Accounts.Text, out int i) || !float.TryParse(txt_Balance.Text, out float f))
            {
                MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.PutMoney(int.Parse(cb_Accounts.Text), float.Parse(txt_Balance.Text));
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Транзакция прошла успешно!");
            }
        }

        private void WithdrawMoney_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(cb_Accounts.Text, out int i) || !float.TryParse(txt_Balance.Text, out float f))
            {
                MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.WithdrawMoney(int.Parse(cb_Accounts.Text), float.Parse(txt_Balance.Text));
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Транзакция прошла успешно!");
            }
        }
    }
}
