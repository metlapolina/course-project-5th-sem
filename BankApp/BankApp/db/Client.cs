namespace BankApp.db
{
    public class Client
    {
        public string Login { get; set; }
        string Password { get; set; }
        string FirstName { get; set; }
        string LastName { get; set; }
        string Region { get; set; }
        string City { get; set; }
        string Address { get; set; }

        public Client(string login, string password, string firstName, string lastName, string region, string city, string address)
        {
            Login = login;
            Password = password;
            FirstName = firstName;
            LastName = lastName;
            Region = region;
            City = city;
            Address = address;
        }

        public override string ToString()
        {
            if (LastName != null)
                return $"{FirstName} {LastName}";
            else
                return $"{FirstName}";
        }
    }
}
