using API.httpClient;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class CountryController : ControllerBase
{

    // Get A List Of Countries
    [HttpGet("GetCountries")]
    public async Task<IActionResult> GetCountries()
    {
        return Ok(await CountryClient.GetCountry());
    }
    // Get A List Of Provinces
    [HttpPost("GetProvices")]
    public async Task<IActionResult> GetProvinces([FromBody] string country)
    {
        return Ok(await ProvinceClient.GetProvincesAsync(country));
    }


}
