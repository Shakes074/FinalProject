create view MemberGroupAges 
as
SELECT
    m.[FirstName],
    m.[LastName],
    m.[Gender],
    m.[Phone],
    b.[Name] AS 'Branch Name',
    CASE
        WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) < 12 THEN 'Sunday School'
        WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
        ELSE 'Adult'
    END AS 'Member Group'
FROM
    Members AS m
JOIN
    Branches AS b ON m.BranchID = b.id;