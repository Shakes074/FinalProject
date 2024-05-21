using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ActivityController : ControllerBase
{
    private readonly IActivity _activity;

    public ActivityController(IActivity activity)
    {
        _activity = activity;
    }

    // Get A List Of Activities
    [HttpGet("ViewActivities")]
    public IActionResult ViewActivity()
    {
        return Ok(_activity.ViewActivity());
    }

    // Register Activity
    [HttpPost("RegisterActivity")]
    public IActionResult RegisterActivity([FromBody] Activity activity)
    {
        return Ok(_activity.RegisterActivity(activity));
    }
}
