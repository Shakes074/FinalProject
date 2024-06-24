CREATE procedure spGetBranchesProvinces
	@CountryName varchar(50)
	as
select distinct Province from Branches
	where Country = @CountryName;