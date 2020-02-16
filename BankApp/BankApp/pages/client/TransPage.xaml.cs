using BankApp.db;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages.client
{
    public partial class TransPage : Page
    {
        Client _client;
        string connStr;

        public TransPage(Client client, string conn)
        {
            InitializeComponent();

            _client = client;
            connStr = conn;

            DB db = new DB();
            db.OpenConnection(connStr);
            cb_FromAccount.ItemsSource = db.GetClientAccounts(_client.Login);
            db.CloseConnection();
        }

        private void TransYourself_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(cb_FromAccount.Text, out int i) || !float.TryParse(txt_Balance.Text, out float f) || !int.TryParse(txt_ToAccount.Text, out int a))
            {
                MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.TransYourself(int.Parse(cb_FromAccount.Text), float.Parse(txt_Balance.Text), int.Parse(txt_ToAccount.Text));
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Транзакция прошла успешно!");
            }
        }

        private void TransAnother_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(cb_FromAccount.Text, out int i) || !float.TryParse(txt_Balance.Text, out float f) || !int.TryParse(txt_ToAccount.Text, out int a))
            {
                MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.TransAnother(int.Parse(cb_FromAccount.Text), float.Parse(txt_Balance.Text), int.Parse(txt_ToAccount.Text));
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Транзакция прошла успешно!");
            }
        }

        private void TransExchange_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(cb_FromAccount.Text, out int i) || !float.TryParse(txt_Balance.Text, out float f) || !int.TryParse(txt_ToAccount.Text, out int a))
            {
                MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.TransExchange(int.Parse(cb_FromAccount.Text), float.Parse(txt_Balance.Text), int.Parse(txt_ToAccount.Text));
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Транзакция прошла успешно!");
            }
        }
    }
}
