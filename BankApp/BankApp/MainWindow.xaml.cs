using BankApp.db;
using BankApp.pages;
using System;
using System.Windows;

namespace BankApp
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            MainFrame.Navigate(new LoginClientPage());
        }

        public MainWindow(string fl, Client client)
        {
            InitializeComponent();
            try
            {
                if (fl == "Admin")
                    MainFrame.Navigate(new AdminMainPage());
                else if (fl == "Client" && client != null)
                    MainFrame.Navigate(new ClientMainPage(client));
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }
    }
}
