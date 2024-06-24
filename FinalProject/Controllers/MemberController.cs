using Interface;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

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
    public IActionResult RegisterMember([FromBody] InsertMember member)
    {
       
        return Ok(_member.RegisterMember(member));
    }


    // PUT Update member
    [HttpPut("UpdateMember")]
    public IActionResult UpdateMember([FromBody] InsertMember member, int Id)
    {
       
        return Ok(_member.UpdateMember(member, Id));
    }


    // DELETE remove member 
    [HttpDelete("{id}")]
    public void Delete(int id)
    {
    }

    

    // Trying to login
    [HttpPost("LoginMember")]
    public IActionResult LoginMemeber([FromBody] LoginModel login)
    {
       
        var res = _member.LoginMember(login);

        if (res is null)
        {
            return BadRequest("Incorrect username or password");
        }

        return Ok(res);
    }

    // Get A List Of Members
    [HttpGet("ViewMemberGroup")]
    public IActionResult ViewMemberGroup()
    {
        return Ok(_member.GetMemberGroup());
    }

    // Get A List Of Members
    [HttpGet("ViewMemberInBranch")]
    public IActionResult ViewMemberInBranch()
    {
        return Ok(_member.GetMemberInBranch());
    }

    // Get A List Of Members
    [HttpGet("ViewMembersStatus")]
    public IActionResult ViewMembersStatus()
    {
        return Ok(_member.GetMembersStatus());
    }

    // Get A List Of Members
    [HttpGet("ViewMembersActivitites")]
    public IActionResult ViewMembersActivitites()
    {
        return Ok(_member.GetMembersActivitites());
    }

}
