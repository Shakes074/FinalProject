namespace UI.Authentication
{
    public class UserAccountService
    {
        private List<UserAccount> _users;

        public UserAccountService()
        {
            _users = new List<UserAccount>
            {
                new UserAccount {Email = "shakes074@gmail.com", Password = "12345", Role = "Admin" },
                new UserAccount {Email = "zuke@gmail.com", Password = "54321", Role = "User"  }
            };
        }

        public UserAccount? GetUserAccount(string Email)
        {
            return _users.FirstOrDefault(x => x.Email == Email);
        }
    }
}
