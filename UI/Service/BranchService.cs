using Models;

namespace UI.Service;

public class BranchService
{
    readonly static string baseUrl = "https://localhost:7019/api";
    //readonly static string baseUrl = "http://bongi074-002-site1.gtempurl.com/api";
    static readonly HttpClient client = new HttpClient();

    public static async Task<List<ViewBranch>> ViewBranch()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Branch/ViewBranches");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<ViewBranch>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<bool> RegisterBranch(InsertBranch branch)
    {
        try
        {
            using HttpResponseMessage response = await client.PostAsJsonAsync<InsertBranch>($"{baseUrl}/Branch/RegisterBranch", branch);

            return response.IsSuccessStatusCode;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

}
