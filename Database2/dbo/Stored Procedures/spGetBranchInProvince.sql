CREATE procedure spGetBranchInProvince
	@Province varchar(50)
	as
select distinct [Name] from Branches
	where [Province] = @Province;