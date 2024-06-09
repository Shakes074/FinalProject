using Models;

namespace UI.Service;

public static class MemberService
{
    //readonly static string baseUrl = "https://localhost:7019/api";
    readonly static string baseUrl = "http://bongi074-002-site1.gtempurl.com/api";
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

    public static async Task<bool> RegisterMember(InsertMember member)
    {
        try
        {
            using HttpResponseMessage response = await client.PostAsJsonAsync<InsertMember>($"{baseUrl}/Member/RegisterMember", member);

            return response.IsSuccessStatusCode;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }



    public static async Task<List<ViewBranchCountries>> GetCountries()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Branch/GetCountryWithBranches");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<ViewBranchCountries>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<List<ViewBranchesProvinces>> GetProvinceAsync(String country)
    {

        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Branch/GetProvinceWithBranches?Country={country}");
            response.EnsureSuccessStatusCode();

            var results = await response.Content.ReadFromJsonAsync<List<ViewBranchesProvinces>>();
            return results;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<List<ViewProvinceBranches>> GetBranchesAsync(String province)
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Branch/GetBranches?Province={province}");
            response.EnsureSuccessStatusCode();

            var results = await response.Content.ReadFromJsonAsync<List<ViewProvinceBranches>>();

            return results;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API ERROR", e);
        }
    }

    public static async Task<ViewMember> LoginMember(LoginModel login)
    {
        try
        {
            using HttpResponseMessage response = await client.PostAsJsonAsync<LoginModel>($"{baseUrl}/Member/LoginMember", login);

            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<ViewMember>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }



    public static async Task<List<MemberGroup>> GetMemberGroup()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Member/ViewMemberGroup");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<MemberGroup>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<List<MemberInBranch>> GetMemberInBranch()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Member/ViewMemberInBranch");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<MemberInBranch>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<List<MemberStatus>> GetMembersStatus()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Member/ViewMembersStatus");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<MemberStatus>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<List<MemberActivitites>> GetMembersActivitites()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Member/ViewMembersActivitites");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<MemberActivitites>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }





}
