using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
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
        public IActionResult ViewActivity()
        {
            return Ok(_branch.ViewBranches());
        }

        // Register a branch
        [HttpPost("RegisterBranch")]
        public IActionResult RegisterActivity([FromBody] InsertBranch branch)
        {
            return Ok(_branch.RegisterBranch(branch));
        }
    }
}
