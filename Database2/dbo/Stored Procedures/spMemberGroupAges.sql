CREATE procedure spMemberGroupAges 
as
begin
SELECT  [FirstName], [LastName], [Gender], 
[Phone], [Branch Name] as 'Name', [Member Group] as 'Group'
from [dbo].[MemberGroupAges];
end;