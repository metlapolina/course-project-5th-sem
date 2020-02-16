using BankApp.db;
using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages.client
{
    public partial class CreditPage : Page
    {
        Client _client;
        string connStr;

        public CreditPage(Client client, string conn)
        {
            InitializeComponent();

            _client = client;
            connStr = conn;

            var dateSource = new List<string>
            {
                DateTime.Now.AddMonths(3).ToShortDateString(),
                DateTime.Now.AddMonths(6).ToShortDateString(),
                DateTime.Now.AddYears(1).ToShortDateString(),
                DateTime.Now.AddYears(2).ToShortDateString(),
                DateTime.Now.AddYears(5).ToShortDateString()
            };
            cb_EndDate.ItemsSource = dateSource;

            DB db = new DB();
            db.OpenConnection(connStr);
            cb_Accounts.ItemsSource = cb_PAccounts.ItemsSource = db.GetClientAccounts(_client.Login);
            cb_PIdTrans.ItemsSource = db.GetTempTransactions(_client.Login);
            db.CloseConnection();
        }

        private void NewCredit_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(cb_Accounts.Text, out int i) || !float.TryParse(txt_Balance.Text, out float f) || !DateTime.TryParse(cb_EndDate.Text, out DateTime d))
            {
                MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.TakeCredit(int.Parse(cb_Accounts.Text), float.Parse(txt_Balance.Text), DateTime.Parse(cb_EndDate.Text));
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Кредит успешно оформлен!");
            }
        }

        private void PayCredit_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (!int.TryParse(cb_PAccounts.Text, out int i) || !float.TryParse(txt_PBalance.Text, out float f) || !int.TryParse(cb_PIdTrans.Text, out int d))
                {
                    MessageBox.Show("Введите корректные данные!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    DB db = new DB();
                    db.OpenConnection(connStr);
                    string message = db.PayCredit(int.Parse(cb_PAccounts.Text), float.Parse(txt_PBalance.Text), int.Parse(cb_PIdTrans.Text));
                    db.CloseConnection();
                    if (message.Length != 0)
                        MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                        MessageBox.Show("Оплата прошла успешно!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void CloseCredit_click(object sender, RoutedEventArgs e)
        {
            try
            {
                DB db = new DB();
                db.OpenConnection(connStr);
                string message = db.CloseCredit(int.Parse(cb_PAccounts.Text), int.Parse(cb_PIdTrans.Text));
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Кредит погашен!");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
