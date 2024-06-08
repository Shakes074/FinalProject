﻿using Dapper;
using Interface;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Models;
using System.Data;

namespace DAL
{
    public class MembersDAL : IMember
    {
        private readonly IConfiguration _config;

        public MembersDAL(IConfiguration configuration)
        {
            _config = configuration;
        }

        private SqlConnection GetConnection()
        {
            return new SqlConnection(_config.GetConnectionString("default"));
        }

        public List<ViewMember> ViewMember()
        {
            using var connection = GetConnection();

            return connection.Query<ViewMember>("spGetMembers", commandType: CommandType.StoredProcedure).ToList();
        }

        public bool RegisterMember(InsertMember member)
        {
            using var connection = GetConnection();

            return connection.Execute("spRegisterMember", new
            {
                member.FirstName,
                member.LastName,
                member.MaritalStatus,
                member.DateOfBirth,
                member.Gender,
                member.Email,
                member.Phone,
                member.Password,
                member.BranchName,
                member.EmpName
            }, commandType: CommandType.StoredProcedure) > 0;
        }

        public List<ViewMember> LoginMember(string email, string password)
        {
            using var connection = GetConnection();

            return connection.Query<ViewMember>("spLoginMember", new
            {
               email,
               password,
            },
            commandType: CommandType.StoredProcedure).ToList();
        }
    }
}
