using API.httpClient;
using Microsoft.AspNetCore.Mvc;
using Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public  class CountryController : ControllerBase
{
    
    // Get A List Of Activities
    [HttpGet("GetCountries")]
    public async Task<IActionResult>GetCountries()
    {
        return  Ok(await CountryClient.GetCountries());
    }
}
