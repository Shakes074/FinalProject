using Dapper;
using Interface;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Models;
using System.Data;

namespace DAL;

public class BranchDAL : IBranch
{
    private readonly IConfiguration _config;

    public BranchDAL(IConfiguration configuration)
    {
        _config = configuration;
    }

    private SqlConnection GetConnection()
    {
        return new SqlConnection(_config.GetConnectionString("default"));
    }

    public bool RegisterBranch(InsertBranch branch)
    {
        using var connection = GetConnection();

        return connection.Execute("spRegisterBranch", new { branch.Name, branch.Province, branch.Country }, commandType: CommandType.StoredProcedure) > 0;
    }

    public List<ViewBranch> ViewBranches()
    {
        using var connection = GetConnection();

        return connection.Query<ViewBranch>("spGetBranches", commandType: CommandType.StoredProcedure).ToList();
    }


    public List<ViewBranchCountries> GetCoutries()
    {
        using var connection = GetConnection();

        return connection.Query<ViewBranchCountries>("[dbo].[spGetBranchCountries]", commandType: CommandType.StoredProcedure).ToList();
    }

    public List<ViewBranchesProvinces> GetProvinces(ViewBranchCountries country)
    {
        using var connection = GetConnection();

        var param = new { country.Country };

        return connection.Query<ViewBranchesProvinces>("[dbo].[spGetBranchByProvince]", param, commandType: CommandType.StoredProcedure).ToList();
    }

    public List<ViewProvinceBranches> GetBranches(ViewBranchesProvinces provinces)
    {
        using var connection = GetConnection();

        var param = new { provinces.Province };

        return connection.Query<ViewProvinceBranches>("[dbo].[spGetBranchInProvince]", param, commandType: CommandType.StoredProcedure).ToList();
    }

}


