create procedure spUpdateUser
@LastName varchar(50),
@MaritalStatus bit,
@Email varchar(50),
@Password varchar(50),
@EmployeeID int
as
begin

UPDATE [dbo].[Members]
SET  
	[LastName] = @LastName, 
	[MaritalStatus] = CASE WHEN @MaritalStatus = 'Married' THEN 1 ELSE 0 END,
	[Email] = @Email,
	[Password] = @Password,
	[EmployeeID] = (SELECT id FROM EmployeeStatus WHERE EmployeeStatus.Employment = @EmployeeID)
WHERE [Email] = @Email;
end;