using Models;

namespace UI.Service
{
    public class CountryService
    {
        readonly static string baseUrl = "https://localhost:7019/api";
        static readonly HttpClient client = new HttpClient();

        public static async Task<List<Country>> GetCountries()
        {
            try
            {
                using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Country/GetCountries");
                response.EnsureSuccessStatusCode();

                var country = await response.Content.ReadFromJsonAsync<List<Country>>();
                return country;
            }
            catch (HttpRequestException e)
            {
                throw new Exception("API EROOR", e);
            }
        }

        public static async Task<List<Province>> GetProvince(Country country)
        {
            try
            {
                using HttpResponseMessage response = await client.PostAsJsonAsync($"{baseUrl}/Country/GetProvinces", new { country = country });
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
}
