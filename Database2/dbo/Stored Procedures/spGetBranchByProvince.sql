CREATE procedure spGetBranchByProvince
	@Country varchar(50)
	as
select distinct Province from Branches
	where [Country] = @Country;