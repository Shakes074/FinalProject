CREATE procedure spLoginMember
@email varchar(50),
@password varchar(150)
as
begin
select [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], 
	   [Password], [JoinDate],
	   [BranchID] as BranchName, [StatusID] as StatusName, 
	   [RoleID] as RoleName, [EmployeeID] as Employment
from members
	where
email = @email and 
[password] = @password;
end;