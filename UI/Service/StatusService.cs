﻿using Models;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace UI.Service;

public class StatusService
{
    readonly static string baseUrl = "https://localhost:7019/api";
    static readonly HttpClient client = new HttpClient();

    public static async Task<List<Status>> ViewStatus()
    {
        try
        {
            using HttpResponseMessage response = await client.GetAsync($"{baseUrl}/Status/ViewStatus");
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<List<Status>>();

        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

    public static async Task<bool> RegisterStatus(Status status)
    {
        try
        {
            using HttpResponseMessage response = await client.PostAsJsonAsync<Status>($"{baseUrl}/Status/RegisterStatus", status);

            return response.IsSuccessStatusCode;
        }
        catch (HttpRequestException e)
        {
            throw new Exception("API EROOR", e);
        }
    }

}
