using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MemberController : ControllerBase
    {
        private readonly IMember _member;

        public MemberController(IMember member)
        {
            _member = member;
        }

        // Get A List Of Members
        [HttpGet("ViewMembers")]
        public IActionResult ViewMembers()
        {
            return Ok(_member.ViewMember());
        }

        // Register A Member
        [HttpPost("RegisterMember")]
        public IActionResult RegisterEmployee([FromBody] InsertMember member)
        {
            return Ok(_member.RegisterMember(member));
        }
    }
}
