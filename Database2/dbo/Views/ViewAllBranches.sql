CREATE VIEW ViewAllBranches AS
SELECT 
   b.[ID], b.[Name], b.[Province], b.[Country], 
    (COUNT(m.BranchID)) AS Total_Members
FROM 
    [dbo].[Branches] AS b 
LEFT JOIN
    [dbo].[Members] AS m ON b.ID = m.BranchID
GROUP BY 
    b.[Name], b.[Province], b.[Country], b.[ID];