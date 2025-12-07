using System.Security.Cryptography;
using System.Text;

namespace Models;

public class LoginModel
{
    public string? Email { get; set; }
    public string? Password { get; set; }
    //public string? message { get; set; }

    // password encryption
    public string HashPassword(string password)
    {
        var sha = SHA256.Create();
        var asByte = Encoding.Default.GetBytes(password);
        var hashed = sha.ComputeHash(asByte);

        return Convert.ToBase64String(hashed);
    }


}


