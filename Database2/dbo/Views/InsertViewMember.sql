CREATE view InsertViewMember
as
	select 
	[FirstName], [LastName], [MaritalStatus],
	[DateOfBirth], [Gender], [Email], [Phone],
	[Password], 
	[BranchID], [StatusID], RoleID, [EmployeeID]
		from members;