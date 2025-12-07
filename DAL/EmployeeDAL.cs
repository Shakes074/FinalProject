using Dapper;
using Interface;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Models;
using System.Data;

namespace DAL;

public class EmployeeDAL : IEmployee
{
    private readonly IConfiguration _config;

    public EmployeeDAL(IConfiguration configuration)
    {
        _config = configuration;
    }

    private SqlConnection GetConnection()
    {
        return new SqlConnection(_config.GetConnectionString("default2"));
    }


    public bool RegisterEmployee(Employee employee)
    {
        using var connection = GetConnection();
        return connection.Execute("spRegisterEmployee", new { employee.Employment, employee.Description }, commandType: CommandType.StoredProcedure) > 0;
    }
    public List<Employee> ViewEmployee()
    {
        using var connection = GetConnection();

        return connection.Query<Employee>("spGetEmployees", commandType: CommandType.StoredProcedure).ToList();
    }
}
