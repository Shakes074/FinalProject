using Models;
using System.Text;

namespace API.httpClient;

public static class CountryClient
{
    readonly static string baseUrl = "https://countriesnow.space/api/v0.1";
    static readonly HttpClient client = new HttpClient();

    public static async Task<List<Country>> GetCountry()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/countries/iso");
            response.EnsureSuccessStatusCode();

            var results =  await response.Content.ReadFromJsonAsync<CountryDTO>();
            return results.data;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }

    }
    

}
