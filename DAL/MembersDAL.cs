using Dapper;
using Interface;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Models;
using System.Data;
using System.Security.Cryptography;
using System.Text;


namespace DAL;

public class MembersDAL : IMember
{
    private readonly IConfiguration _config;
    LoginModel crypt = new LoginModel();
    string Password;

    public MembersDAL(IConfiguration configuration)
    {
        _config = configuration;
    }

    private SqlConnection GetConnection()
    {
        return new SqlConnection(_config.GetConnectionString("default1"));
    }

    public List<ViewMember> ViewMember()
    {
        using var connection = GetConnection();

        return connection.Query<ViewMember>("spGetMembers", commandType: CommandType.StoredProcedure).ToList();
    }

    public bool RegisterMember(InsertMember member)
    {
        using var connection = GetConnection();
        //encrpt before registering

        Password = crypt.HashPassword(member.Password);
        return connection.Execute("spRegisterMember", new
        {
           member.FirstName,
           member.LastName,
           member.MaritalStatus,
           member.DateOfBirth,
           member.Gender,
           member.Email,
           member.Phone,
           Password,
           member.BranchName,
           member.StatusName,
           member.RoleName,
           member.EmployeeName
        }, commandType: CommandType.StoredProcedure) > 0;
    }

    public bool UpdateMember(InsertMember member, int Id)
    {
        using var connection = GetConnection();
        Password = crypt.HashPassword(member.Password);
        return connection.Execute("spUpdateMember", new
        {
            Id,
            member.FirstName,
            member.LastName,
            member.MaritalStatus,
            member.DateOfBirth,
            member.Gender,
            member.Email,
            member.Phone,
            Password,
            member.BranchName,
            member.StatusName,
            member.RoleName,
            member.EmployeeName
        }, commandType: CommandType.StoredProcedure) > 0;
    }

    public ViewMember LoginMember(LoginModel model)
    {
        using var connection = GetConnection();
       
        string password = crypt.HashPassword(model.Password);
        return connection.QueryFirstOrDefault<ViewMember>("spLoginMember", new
        {
            
            email = model.Email,
            password = password,
        },
        commandType: CommandType.StoredProcedure);
    }

    public List<ViewMember> UpdateByUser(InsertMember member)
    {
        throw new NotImplementedException();
    }

    public List<MemberGroup> GetMemberGroup()
    {
        using var connection = GetConnection();

        return connection.Query<MemberGroup>("spMemberGroupAges", commandType: CommandType.StoredProcedure).ToList();
    }
    public List<MemberInBranch> GetMemberInBranch()
    {
        using var connection = GetConnection();

        return connection.Query<MemberInBranch>("spTotalMemberInBranch", commandType: CommandType.StoredProcedure).ToList();
    }
    public List<MemberStatus> GetMembersStatus()
    {
        using var connection = GetConnection();

        return connection.Query<MemberStatus>("spMembersStatus", commandType: CommandType.StoredProcedure).ToList();
    }
    public List<MemberActivitites> GetMembersActivitites()
    {
        using var connection = GetConnection();

        return connection.Query<MemberActivitites>("spMembersActivities", commandType: CommandType.StoredProcedure).ToList();
    }

   
}
