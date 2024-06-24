CREATE PROCEDURE spSelectByBranch
	@id int
AS
begin
			SELECT * from [dbo].[Members]
		where BranchID = @id;
end;