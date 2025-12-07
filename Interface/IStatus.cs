using Models;
namespace Interface;

public interface IStatus
{
    public bool RegisterStatus(Status status);
    public List<Status> ViewStatus();
}
