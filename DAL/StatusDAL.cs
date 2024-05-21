using Dapper;
using Interface;
using Models;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace DAL;

public class StatusDAL : IStatus
{
    private readonly IConfiguration _config;

    public StatusDAL(IConfiguration configuration)
    {
        _config = configuration;
    }

    private SqlConnection GetConnection()
    {
        return new SqlConnection(_config.GetConnectionString("default"));
    }

    public bool RegisterStatus(Status status)
    {
        using var connection = GetConnection();

        return connection.Execute("spRegisterStatus", new { status.Name, status.Description, status.Criteria }, commandType: CommandType.StoredProcedure) > 0;
    }

    public List<Status> ViewStatus()
    {
        using var connection = GetConnection();

        return connection.Query<Status>("spGetStatus", commandType: CommandType.StoredProcedure).ToList();
    }
}
