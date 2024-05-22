using Models;

namespace API.httpClient
{
    public static class CountryClient
    {
        readonly static string baseUrl = "https://countriesnow.space/api/v0.1";
        static readonly HttpClient client = new HttpClient();

        public static async Task<List<Country>> GetCountries()
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

        public static async Task<bool> RegisterActivity(Activity activity)
        {
            try
            {
                using HttpResponseMessage response = await client.PostAsJsonAsync<Activity>($"{baseUrl}/Activity/RegisterActivity", activity);

                return response.IsSuccessStatusCode;
            }
            catch (HttpRequestException e)
            {
                throw new Exception("API EROOR", e);
            }
        }
    }
}
