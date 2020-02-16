using BankApp.db;
using System.Windows;

namespace BankApp.pages.client
{
    public partial class AddAccountWindow : Window
    {
        Client _client;
        string connStr;

        public AddAccountWindow(Client client, string conn)
        {
            InitializeComponent();

            _client = client;
            connStr = conn;

            DB db = new DB();
            db.OpenConnection(connStr);
            cb_Branch.ItemsSource = db.GetAllBranches();
            cb_Currency.ItemsSource = db.GetAllCurrency();
            db.CloseConnection();
        }

        private void AddAccount_Click(object sender, RoutedEventArgs e)
        {
            if (!float.TryParse(txt_Balance.Text, out float f))
            {
                MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.AddAccount(_client.Login, cb_Branch.Text, float.Parse(txt_Balance.Text), cb_Currency.Text);
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                {
                    MessageBox.Show("Данные успешно добавлены");
                    Close();
                }
            }
        }
    }
}
