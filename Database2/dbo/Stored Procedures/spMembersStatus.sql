CREATE procedure spMembersStatus
as  
begin
SELECT m.[FirstName], m.[LastName], m.[Gender], m.[Phone],
       s.[Name] AS 'ActiveStatus',
       b.[Name] AS 'BranchName'
FROM members AS m
JOIN Branches AS b ON m.[BranchID] = b.id
JOIN [Status] AS s ON m.[StatusID] = s.id;
end;