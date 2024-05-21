using Models;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace UI.Service;

public class RoleService
{
    readonly static string baseUrl = "https://localhost:7019/api";
    static readonly HttpClient client = new HttpClient();

    public static async Task<List<Role>> ViewRoles()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Role/ViewRoles");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<Role>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<bool> RegisterRole(Role role)
    {
        try
        {
            using HttpResponseMessage response = await client.PostAsJsonAsync<Role>($"{baseUrl}/Role/RegisterRole", role);

            return response.IsSuccessStatusCode;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

}
