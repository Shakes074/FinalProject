using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class RoleController : ControllerBase
{
    private readonly IRoles _roles;

    public RoleController(IRoles roles)
    {
        _roles = roles;
    }

    // Get A List Of Role
    [HttpGet("ViewRoles")]
    public IActionResult ViewRoles()
    {
        return Ok(_roles.ViewRoles());
    }

    // Register Role
    [HttpPost("RegisterRole")]
    public IActionResult RegisterRole([FromBody] Role role)
    {
        return Ok(_roles.RegisterRole(role));
    }

}