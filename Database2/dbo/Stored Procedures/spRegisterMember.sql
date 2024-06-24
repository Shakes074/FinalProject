CREATE PROCEDURE spRegisterMember
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @MaritalStatus VARCHAR(50),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(50),
    @Phone VARCHAR(13),
    @Password VARCHAR(150),

    @BranchName VARCHAR(50),
    @StatusName VARCHAR(50) = 'Testify',
    @RoleName VARCHAR(25) = 'User',
    @EmployeeName VARCHAR(50) = 'Un-Employed'

AS
BEGIN

    INSERT INTO [dbo].[InsertViewMember]
        ([FirstName], [LastName], [MaritalStatus], [DateOfBirth], 
	     [Gender], [Email], [Phone], [Password], 
		 [BranchID], [StatusID], [RoleID], [EmployeeID])
    VALUES
        (@FirstName, @LastName,
         CASE WHEN @MaritalStatus = 'Married' THEN 1 ELSE 0 END,
         CONVERT(DATE, @DateOfBirth, 103),
         @Gender,
         @Email, @Phone, @Password,

         (select id from branches where [name] =  @BranchName),
         (select id from [status] where [name] = @StatusName),
         (select id from roles where [name] = @RoleName),
         (select id from EmployeeStatus where employment = @EmployeeName)
        );
END;