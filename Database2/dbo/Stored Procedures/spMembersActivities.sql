CREATE procedure spMembersActivities
as
begin
SELECT m.[FirstName], m.[LastName], m.[Gender], m.[Phone],
       a.[Name] AS 'Activity',
       b.[Name]
FROM members AS m
JOIN Branches AS b ON m.BranchID = b.ID
JOIN Activity AS a ON m.StatusID = a.ID;
end;