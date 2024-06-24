CREATE PROCEDURE spMemberGroups
	
AS
begin
	SELECT
        CASE
            WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) < 13 THEN 'Sunday School'
            WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
            ELSE 'Adult'
        END AS [Member Group],
        COUNT(*) AS [Total Members]
    FROM
        Members AS m
    GROUP BY
        CASE
            WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) < 13 THEN 'Sunday School'
            WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
            ELSE 'Adult'
        END;
	end;