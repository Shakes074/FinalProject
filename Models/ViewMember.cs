using System.IO;

namespace Models;

public class ViewMember
{
    public int ID { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string MaritalStatus { get; set; }
    public string DateOfBirth { get; set; }
    public string Gender { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Password { get; set; }
    public string JoinDate { get; set; }
    public string BranchName { get; set; }
    public string Province { get; set; }
    public string Country { get; set; }
    public string StatusName { get; set; }
    public string RoleName { get; set; }
    public string EmployeeName { get; set; }
}
public class MemberActivitites
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Gender { get; set; }
    public string Phone { get; set; }
    public string Activity { get; set; }
    public string Name { get; set; }
}
public class MemberStatus 
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Gender { get; set; }
    public string Phone { get; set; }
    public string ActiveStatus { get; set; }
    public string BranchName { get; set; }
}
public class MemberInBranch
{
    public string BranchName { get; set; }
    public int SundaySchool { get; set; }
    public int Youth { get; set; }
    public int Adults { get; set; }
    public int TotalMembers { get; set; }
}
public class MemberGroup 
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Gender { get; set; }
    public string Phone { get; set; }
    public string Name { get; set; }
    public string Group { get; set; }
}
