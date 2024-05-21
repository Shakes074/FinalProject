using Dapper;
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
}
