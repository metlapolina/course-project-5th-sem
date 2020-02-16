using BankApp.db;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages.client
{
    public partial class AccountPage : Page
    {
        static StackPanel sp_Acc;
        Client _client;
        string connStr;

        public AccountPage(Client client, string conn)
        {
            InitializeComponent();

            _client = client;
            connStr = conn;
            sp_Acc = pnl_Accounts;

            DB db = new DB();
            db.OpenConnection(connStr);
            cb_Accounts.ItemsSource = db.GetClientAccounts(_client.Login);
            db.CloseConnection();

            ShowAccounts();
        }

        private void ShowAccounts()
        {
            try
            {
                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("GetClientAccounts", conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@custLogin", _client.Login);
                    var reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            var subitem = new AccountControl(_client, connStr, reader.GetInt32(0), float.Parse(reader.GetValue(5).ToString()), reader.GetString(6))
                            {
                                Margin = new Thickness(0, 5, 0, 5)
                            };

                            sp_Acc.Children.Add(subitem);
                        }
                    }
                    reader.Close();
                }
            } catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void CreateAccount_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                var accountWindow = new AddAccountWindow(_client, connStr);
                accountWindow.ShowDialog();
                DB db = new DB();
                db.OpenConnection(connStr);
                cb_Accounts.ItemsSource = null;
                cb_Accounts.ItemsSource = db.GetClientAccounts(_client.Login);
                db.CloseConnection();

                sp_Acc.Children.Clear();
                ShowAccounts();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void CreateCard_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                if (!int.TryParse(cb_Accounts.Text, out int i))
                {
                    MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.CreateCard(int.Parse(cb_Accounts.Text));
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Данные успешно добавлены!");
                }
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
