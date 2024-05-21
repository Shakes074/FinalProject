using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class EmployeeController : ControllerBase
{
    private readonly IEmployee _employee;

    public EmployeeController(IEmployee employee)
    {
        _employee = employee;
    }

    // Get A List Of Emplyment Status
    [HttpGet("ViewEmployee")]
    public IActionResult ViewEmployee()
    {
        return Ok(_employee.ViewEmployee());
    }

    // Register Employement Status
    [HttpPost("RegisterEmployee")]
    public IActionResult RegisterEmployee([FromBody] Employee employee)
    {
        return Ok(_employee.RegisterEmployee(employee));
    }
}
