
CREATE PROCEDURE [dbo].[spGetRoles]
AS
begin
	select [ID] ,[Name], [Description]  from [dbo].[ViewAllRoles];
end;