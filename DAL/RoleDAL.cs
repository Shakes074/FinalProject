using Dapper;
using Interface;
using Models;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;


namespace DAL;

public class RoleDAL : IRoles
{
    private readonly IConfiguration _config;

    public RoleDAL(IConfiguration configuration)
    {
        _config = configuration;
    }

    private SqlConnection GetConnection()
    {
        return new SqlConnection(_config.GetConnectionString("default"));
    }

    public bool RegisterRole(Role role)
    {
        using var connection = GetConnection();

        return connection.Execute("spRegisterRoles", new { role.Name, role.Description }, commandType: CommandType.StoredProcedure) > 0;
    }

    public List<Role> ViewRoles()
    {
        using var connection = GetConnection();

        return connection.Query<Role>("spGetRoles", commandType: CommandType.StoredProcedure).ToList();
    }

}
