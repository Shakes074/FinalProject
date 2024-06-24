CREATE PROCEDURE spSelectByRole
	@id int
AS
begin
	SELECT * from [dbo].[Members]
		where RoleID = @ID;
end;