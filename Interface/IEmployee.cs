using Models;
namespace Interface;

public interface IEmployee
{
    public bool RegisterEmployee(Employee role);
    public List<Employee> ViewEmployee();
}
