using Models;
namespace Interface;

public interface IActivity
{
    public bool RegisterActivity(Activity activity);
    public List<Activity> ViewActivity();
}
