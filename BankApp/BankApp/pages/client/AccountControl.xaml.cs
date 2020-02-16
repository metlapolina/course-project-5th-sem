using BankApp.db;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;

namespace BankApp.pages.client
{
    public partial class AccountControl : UserControl
    {
        Client _client;
        string _connStr;
        int _id = 0;

        public AccountControl(Client client, string connStr, int id, float money, string curr)
        {
            InitializeComponent();

            _client = client;
            _connStr = connStr;
            _id = id;
            tb_Account.Text = id.ToString();
            tb_Balance.Text = money.ToString() + " " + curr;

            ShowCreditCard();
        }

        private void ShowCreditCard()
        {
            try
            {
                string message = "Платежная карта №";
                using (var conn = new SqlConnection(_connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("GetClientCard", conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@accId", _id);
                    var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(mess);
                    var reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            message += reader.GetValue(0);
                        }
                    }
                    else
                    {
                        message = cmd.Parameters["@mess"].Value.ToString();
                    }
                    reader.Close();
                }

                ToolTip tool = new ToolTip
                {
                    Content = message
                };
                gr_Item.ToolTip = tool;
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
                DB db = new DB();
                db.OpenConnection(_connStr);
                string message = db.DelAccount(_id);
                db.CloseConnection();
                if (message.Length != 0)
                    MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                    MessageBox.Show("Данные успешно удалены!");
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
