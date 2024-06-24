CREATE procedure spGetBranchCountries
	as
select  distinct [Country] from [dbo].[Branches];