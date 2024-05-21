﻿using Dapper;
using Interface;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL;

public class ActivityDAL : IActivity
{
    private readonly IConfiguration _config;

    public ActivityDAL(IConfiguration configuration)
    {
        _config = configuration;
    }

    private SqlConnection GetConnection()
    {
        return new SqlConnection(_config.GetConnectionString("default"));
    }

    public bool RegisterActivity(Activity activity)
    {
        using var connection = GetConnection();

        return connection.Execute("spRegisterActivity", new { activity.Name, activity.Description}, commandType: CommandType.StoredProcedure) > 0;
    }

    public List<Activity> ViewActivity()
    {
        using var connection = GetConnection();

        return connection.Query<Activity>("spGetActivity", commandType: CommandType.StoredProcedure).ToList();
    }
}
