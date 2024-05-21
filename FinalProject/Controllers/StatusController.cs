using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class StatusController : ControllerBase
{
    private readonly IStatus _status;

    public StatusController(IStatus status)
    {
        _status = status;
    }

    // Get A List Of Status
    [HttpGet("ViewStatus")]
    public IActionResult ViewStatus()
    {
        return Ok(_status.ViewStatus());
    }

    // Register Status
    [HttpPost("RegisterStatus")]
    public IActionResult RegisterStatus([FromBody] Status status)
    {
        return Ok(_status.RegisterStatus(status));
    }
}
