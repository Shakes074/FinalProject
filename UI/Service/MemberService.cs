using Models;

namespace UI.Service;

public class MemberService
{
    readonly static string baseUrl = "https://localhost:7019/api";
    static readonly HttpClient client = new HttpClient();

    public static async Task<List<ViewMember>> ViewMembers()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Member/ViewMembers");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<ViewMember>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<bool> RegisterMember(InsertMember activity)
    {
        try
        {
            using HttpResponseMessage response = await client.PostAsJsonAsync<InsertMember>($"{baseUrl}/Member/RegisterMember", activity);

            return response.IsSuccessStatusCode;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    

}
