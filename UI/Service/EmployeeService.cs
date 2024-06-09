using Models;

namespace UI.Service
{
    public class EmployeeService
    {
        //readonly static string baseUrl = "https://localhost:7019/api";
        readonly static string baseUrl = "http://bongi074-002-site1.gtempurl.com/api";
        static readonly HttpClient client = new HttpClient();

        public static async Task<List<Employee>> ViewEmployee()
        {
            try
            {
                using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Employee/ViewEmployee");
                response.EnsureSuccessStatusCode();

                return await response.Content.ReadFromJsonAsync<List<Employee>>();

            }
            catch (HttpRequestException e)
            {
                throw new Exception("API EROOR", e);
            }
        }

        public static async Task<bool> RegisterActivity(Employee employee)
        {
            try
            {
                using HttpResponseMessage response = await client.PostAsJsonAsync<Employee>($"{baseUrl}/Employee/RegisterEmployee", employee);

                return response.IsSuccessStatusCode;
            }
            catch (HttpRequestException e)
            {
                throw new Exception("API EROOR", e);
            }
        }
    }
}
