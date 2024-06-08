using Models;

namespace API.httpClient;

public class ProvinceClient
{
    readonly static string baseUrl = "https://countriesnow.space/api/v0.1";
    static readonly HttpClient client = new HttpClient();

    public static async Task<List<Province>> GetProvincesAsync(String country)
    {
        try
        {
            using HttpResponseMessage response = await client.PostAsJsonAsync("https://countriesnow.space/api/v0.1/countries/states", new { country = country });
            response.EnsureSuccessStatusCode();

            var results = await response.Content.ReadFromJsonAsync<ProvinceDTO>();
            return results.data.states;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

}
