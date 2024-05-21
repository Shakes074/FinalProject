using Models;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace UI.Service;

public class ActivityService
{
    readonly static string baseUrl = "https://localhost:7019/api";
    static readonly HttpClient client = new HttpClient();

    public static async Task<List<Activity>> ViewActivity()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Activity/ViewActivities");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<Activity>>();

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