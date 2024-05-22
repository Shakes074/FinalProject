using Models;

namespace UI.Service
{
    public class CountryService
    {
        readonly static string baseUrl = "https://localhost:7019/api/";
        static readonly HttpClient client = new HttpClient();
        public static async Task<List<Country>> ViewActivity()
        {
            try
            {
                using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Country/GetCountries");
                response.EnsureSuccessStatusCode();

                return await response.Content.ReadFromJsonAsync<List<Country>>();

            }
            catch (HttpRequestException e)
            {
                throw new Exception("API EROOR", e);
            }
        }
    }
}
