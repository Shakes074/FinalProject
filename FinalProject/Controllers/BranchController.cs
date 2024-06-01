using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;
using System.Diagnostics.Metrics;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class BranchController : ControllerBase
{
    private readonly IBranch _branch;

    public BranchController(IBranch branch)
    {
        _branch = branch;
    }

    // Get a list Of braches with number of members
    [HttpGet("ViewBranches")]
    public IActionResult ViewBranches()
    {
        return Ok(_branch.ViewBranches());
    }

    // Register a branch
    [HttpPost("RegisterBranch")]
    public IActionResult RegisterBranch([FromBody] InsertBranch branch)
    {
        return Ok(_branch.RegisterBranch(branch));
    }


    [HttpGet("GetCountryWithBranches")]
    public IActionResult GetCountryWithBranches()
    {
        return Ok(_branch.GetCoutries());
    }

    [HttpGet("GetProvinceWithBranches")]
    public IActionResult GetProvinceWithBranches([FromQuery] ViewBranchCountries pcountry)
    {
        return Ok(_branch.GetProvinces(pcountry));
    }

    [HttpGet("GetBranches")]
    public IActionResult GetBranches([FromQuery] ViewBranchesProvinces pprovince)
    {
        return Ok(_branch.GetBranches(pprovince));
    }

}
