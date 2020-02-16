using BankApp.db;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Controls;

namespace BankApp.pages.client
{
    public partial class HistoryPage : Page
    {
        string connStr;
        Client _client;
        DataTable dataTable = new DataTable();

        public HistoryPage(Client client, string conn)
        {
            InitializeComponent();

            _client = client;
            connStr = conn;
            ShowTable();
        }

        public void ShowTable()
        {
            string sqlExpression = "GetAccTransactions";
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                connection.Open();
                SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                command.SelectCommand.CommandType = CommandType.StoredProcedure;
                command.SelectCommand.Parameters.AddWithValue("@login", _client.Login);
                dataTable.Clear();
                dataTable = new DataTable();
                command.Fill(dataTable);
                dataGrid.ItemsSource = dataTable.DefaultView;
                connection.Close();
            }
        }
    }
}
