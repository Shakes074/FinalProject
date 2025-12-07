using Models;
namespace Interface;

public interface IRoles
{
    public bool RegisterRole(Role role);
    public List<Role> ViewRoles();
}

