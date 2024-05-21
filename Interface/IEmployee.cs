using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interface;

public interface IEmployee
{
    public bool RegisterEmployee(Employee role);
    public List<Employee> ViewEmployee();
}
