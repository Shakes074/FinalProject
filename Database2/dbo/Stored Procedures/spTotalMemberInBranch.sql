    CREATE procedure spTotalMemberInBranch
as
begin
SELECT
    g.[Branch Name] as 'BranchName',
    SUM(CASE WHEN g.[Member Group] = 'Sunday School' THEN 1 ELSE 0 END) AS 'SundaySchool',
    SUM(CASE WHEN g.[Member Group] = 'Youth' THEN 1 ELSE 0 END) AS 'Youth',
    SUM(CASE WHEN g.[Member Group] = 'Adult' THEN 1 ELSE 0 END) AS 'Adults',
    COUNT(*) AS 'TotalMembers'
FROM
    [dbo].[MemberGroupAges] AS g
GROUP BY
    g.[Branch Name];
end;