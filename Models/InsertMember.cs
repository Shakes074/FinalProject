namespace Models;

public class InsertMember
{
    public int ID { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string MaritalStatus { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string Gender { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Password { get; set; }
    public string BranchName { get; set; }
    public string EmpName { get; set; }
}

public class MStatus
{
    public string Value { get; set; }
    public string Name { get; set; }
}

public class Gender
{
    public string Value { get; set; }
    public string Name { get; set; }
}

public class EStatus
{
    public string Value { get; set; }
    public string Name { get; set; }
}

public class getDOB
{
    public DateTime DateOfBirth { get; set; }
}