CREATE PROCEDURE spUpdateMember
    @ID int,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @MaritalStatus VARCHAR(50),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(50),
    @Phone VARCHAR(13),
    @Password VARCHAR(10),

    @BranchName VARCHAR(50),
    @StatusName VARCHAR(50),
    @RoleName VARCHAR(25),
    @EmployeeName VARCHAR(50)
AS
BEGIN
    UPDATE Members
    SET
        FirstName = @FirstName,
        LastName = @LastName,
        MaritalStatus = CASE WHEN @MaritalStatus = 'Married' THEN 1 ELSE 0 END,
        DateOfBirth = CONVERT(DATE, @DateOfBirth, 103),
        Gender = @Gender,
        Email = @Email,
        Phone = @Phone,
        [Password] = @Password,
        BranchID = (SELECT id FROM branches WHERE [name] = @BranchName),
        StatusID = (SELECT id FROM [status] WHERE [name] = @StatusName),
        RoleID = (SELECT id FROM roles WHERE [name] = @RoleName),
        EmployeeID = (SELECT id FROM EmployeeStatus WHERE employment = @EmployeeName)
    WHERE ID = @ID; -- Assuming 'ID' is the primary key column
END;