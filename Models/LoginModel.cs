using System.Security.Cryptography;
using System.Text;
using AntDesign;


namespace Models;

public class LoginModel
{
    public string? Email { get; set; }
    public string? Password { get; set; }

    // password encryption
    public string HashPassword(string password)
    {
        var sha = SHA256.Create();
        var asByte = Encoding.Default.GetBytes(password);
        var hashed = sha.ComputeHash(asByte);
        
        return Convert.ToBase64String(hashed);
    }

    INotificationService _notice;
    public async Task NoticeWithIcon(NotificationType type, string message)
    {
        await _notice.Open(new NotificationConfig()
        {
            Message = "Login Error",
            Description = message,
            NotificationType = type
        });
    }
}


