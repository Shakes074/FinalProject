CREATE PROCEDURE [dbo].[spSelectMembers]
AS
begin
	SELECT * from MemberDetails
		order by FirstName;
	--* from [dbo].[Members]
end;