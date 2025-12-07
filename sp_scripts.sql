-- 1. spGetBranches
CREATE OR ALTER PROCEDURE spGetBranches
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Branches] ORDER BY [Name];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 2. spGetBranchesProvinces
CREATE OR ALTER PROCEDURE spGetBranchesProvinces
    @CountryName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT DISTINCT Province FROM [dbo].[vw_Branches]
        WHERE Country = @CountryName
        ORDER BY Province;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 3. spGetBranchInProvince
CREATE OR ALTER PROCEDURE spGetBranchInProvince
    @Province VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT DISTINCT [Name] FROM [dbo].[vw_Branches]
        WHERE [Province] = @Province
        ORDER BY [Name];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 4. spGetEmployees (Updated for EmploymentStatus)
CREATE OR ALTER PROCEDURE spGetEmployees
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            ID,
            Employment,
            [Description],
            IsActive,
            CreatedDate,
            ModifiedDate
        FROM EmploymentStatus 
        WHERE IsActive = 1
        ORDER BY [Employment];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 5. spGetMembers
CREATE OR ALTER PROCEDURE spGetMembers
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Members] ORDER BY FirstName, LastName;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 6. spGetRoles
CREATE OR ALTER PROCEDURE [dbo].[spGetRoles]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT [ID], [Name], [Description] FROM [dbo].[vw_Roles] ORDER BY [Name];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 7. spGetStatus
CREATE OR ALTER PROCEDURE spGetStatus
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Status] ORDER BY [Name];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 8. spLoginMember (Updated for EmploymentStatusID)
CREATE OR ALTER PROCEDURE spLoginMember
    @Email VARCHAR(50),
    @Password VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            [FirstName], [LastName], [MaritalStatus], [DateOfBirth], 
            [Gender], [Email], [Phone], [JoinDate],
            BranchName, StatusName, RoleName, EmploymentStatus
        FROM [dbo].[vw_Members]
        WHERE Email = @Email 
        AND [Password] = CAST(@Password AS VARBINARY(256))
        AND IsActive = 1;
        
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('Invalid email or password', 16, 1);
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 9. spMemberGroupAges
CREATE OR ALTER PROCEDURE spMemberGroupAges 
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT  
            [FirstName], [LastName], [Gender], 
            [Phone], [BranchName], 
            [MemberGroup] AS 'Group'
        FROM [dbo].[vw_MemberAgeGroups]
        ORDER BY [MemberGroup], FirstName, LastName;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 10. spMemberGroups
CREATE OR ALTER PROCEDURE spMemberGroups
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            [MemberGroup],
            [TotalMembers]
        FROM [dbo].[vw_MemberGroupsSummary]
        ORDER BY [MemberGroup];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 11. spMembersActivities
CREATE OR ALTER PROCEDURE spMembersActivities
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            [FirstName], [LastName], [Gender], [Phone],
            [ActivityName],
            [BranchName],
            [ParticipationDate],
            [HoursParticipated]
        FROM [dbo].[vw_MemberActivityDetails]
        ORDER BY [BranchName], [FirstName], [LastName];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 12. spMembersStatus
CREATE OR ALTER PROCEDURE spMembersStatus
AS  
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            [FirstName], [LastName], [Gender], [Phone],
            [StatusName] AS 'ActiveStatus',
            [BranchName] AS 'BranchName'
        FROM [dbo].[vw_Members]
        ORDER BY [BranchName], [StatusName], FirstName, LastName;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 13. spRegisterActivity (Updated for Activity table)
CREATE OR ALTER PROCEDURE spRegisterActivity
    @Name VARCHAR(50),
    @Description VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF EXISTS (SELECT 1 FROM Activity WHERE [Name] = @Name AND IsActive = 1)
        BEGIN
            RAISERROR('Activity with this name already exists', 16, 1);
            RETURN;
        END
        
        INSERT INTO Activity ([Name], [Description], IsActive, CreatedDate, ModifiedDate)
        VALUES (@Name, @Description, 1, GETDATE(), GETDATE());
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 14. spRegisterBranch
CREATE OR ALTER PROCEDURE spRegisterBranch
    @Country VARCHAR(50),
    @Province VARCHAR(50),
    @Name VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF EXISTS (SELECT 1 FROM Branches WHERE [Name] = @Name AND Province = @Province AND IsActive = 1)
        BEGIN
            RAISERROR('Branch with this name already exists in this province', 16, 1);
            RETURN;
        END
        
        INSERT INTO Branches ([Country], [Province], [Name], IsActive, CreatedDate, ModifiedDate)
        VALUES (@Country, @Province, @Name, 1, GETDATE(), GETDATE());
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 15. spRegisterEmployee (Updated for EmploymentStatus)
CREATE OR ALTER PROCEDURE spRegisterEmployee
    @Employment VARCHAR(150),
    @Description VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF EXISTS (SELECT 1 FROM EmploymentStatus WHERE Employment = @Employment AND IsActive = 1)
        BEGIN
            RAISERROR('Employment status already exists', 16, 1);
            RETURN;
        END
        
        INSERT INTO EmploymentStatus (Employment, [Description], IsActive, CreatedDate, ModifiedDate)
        VALUES (@Employment, @Description, 1, GETDATE(), GETDATE());
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 16. spRegisterMember (Updated for EmploymentStatusID)
CREATE OR ALTER PROCEDURE spRegisterMember
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @MaritalStatus VARCHAR(10),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(50),
    @Phone VARCHAR(13),
    @Password VARCHAR(150),
    @BranchName VARCHAR(50),
    @StatusName VARCHAR(50) = 'Testify',
    @RoleName VARCHAR(25) = 'User',
    @EmployeeName VARCHAR(50) = 'Un-Employed',
    @NewMemberID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate email uniqueness
        IF EXISTS (SELECT 1 FROM Members WHERE Email = @Email AND IsActive = 1)
        BEGIN
            RAISERROR('Email already exists', 16, 1);
            RETURN;
        END
        
        -- Validate branch exists
        IF NOT EXISTS (SELECT 1 FROM Branches WHERE [Name] = @BranchName AND IsActive = 1)
        BEGIN
            RAISERROR('Invalid branch name', 16, 1);
            RETURN;
        END
        
        INSERT INTO Members (
            [FirstName], [LastName], [MaritalStatus], [DateOfBirth], 
            [Gender], [Email], [Phone], [Password], [JoinDate],
            [BranchID], [StatusID], [RoleID], [EmploymentStatusID],
            [IsActive], [CreatedDate], [ModifiedDate]
        )
        VALUES (
            @FirstName, @LastName,
            @MaritalStatus,
            @DateOfBirth,
            @Gender,
            @Email, @Phone, CAST(@Password AS VARBINARY(256)), GETDATE(),
            (SELECT ID FROM Branches WHERE [Name] = @BranchName AND IsActive = 1),
            (SELECT ID FROM [Status] WHERE [Name] = @StatusName AND IsActive = 1),
            (SELECT ID FROM Roles WHERE [Name] = @RoleName AND IsActive = 1),
            (SELECT ID FROM EmploymentStatus WHERE Employment = @EmployeeName AND IsActive = 1),
            1, GETDATE(), GETDATE()
        );
            
        SET @NewMemberID = SCOPE_IDENTITY();
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 17. spRegisterRoles
CREATE OR ALTER PROCEDURE spRegisterRoles
    @Name VARCHAR(50),
    @Description VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF EXISTS (SELECT 1 FROM Roles WHERE [Name] = @Name AND IsActive = 1)
        BEGIN
            RAISERROR('Role with this name already exists', 16, 1);
            RETURN;
        END
        
        INSERT INTO Roles ([Name], [Description], IsActive, CreatedDate, ModifiedDate)
        VALUES (@Name, @Description, 1, GETDATE(), GETDATE());
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 18. spRegisterStatus
CREATE OR ALTER PROCEDURE spRegisterStatus
    @Name VARCHAR(50),
    @Description VARCHAR(150),
    @Criteria VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF EXISTS (SELECT 1 FROM [Status] WHERE [Name] = @Name AND IsActive = 1)
        BEGIN
            RAISERROR('Status with this name already exists', 16, 1);
            RETURN;
        END
        
        INSERT INTO [Status] ([Name], [Description], [Criteria], IsActive, CreatedDate, ModifiedDate)
        VALUES (@Name, @Description, @Criteria, 1, GETDATE(), GETDATE());
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 19. spSelectByBranch
CREATE OR ALTER PROCEDURE spSelectByBranch
    @ID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Members]
        WHERE BranchID = @ID
        ORDER BY FirstName, LastName;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 20. spSelectByRole
CREATE OR ALTER PROCEDURE spSelectByRole
    @ID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Members]
        WHERE RoleID = @ID
        ORDER BY FirstName, LastName;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 21. spSelectMembers
CREATE OR ALTER PROCEDURE [dbo].[spSelectMembers]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Members]
        ORDER BY FirstName, LastName;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 22. spSelectRoles
CREATE OR ALTER PROCEDURE [dbo].[spSelectRoles]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Roles]
        ORDER BY [Name];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 23. spTotalMemberInBranch
CREATE OR ALTER PROCEDURE spTotalMemberInBranch
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            [BranchName],
            [SundaySchool],
            [Youth],
            [Adults],
            [TotalMembers]
        FROM [dbo].[vw_BranchStatistics]
        ORDER BY [BranchName];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 24. spUpdateMember (Updated for EmploymentStatusID)
CREATE OR ALTER PROCEDURE spUpdateMember
    @ID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @MaritalStatus VARCHAR(10),
    @DateOfBirth DATE,
    @Gender CHAR(1),
    @Email VARCHAR(50),
    @Phone VARCHAR(13),
    @Password VARCHAR(150),
    @BranchName VARCHAR(50),
    @StatusName VARCHAR(50),
    @RoleName VARCHAR(25),
    @EmployeeName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check if member exists
        IF NOT EXISTS (SELECT 1 FROM Members WHERE ID = @ID AND IsActive = 1)
        BEGIN
            RAISERROR('Member not found', 16, 1);
            RETURN;
        END
        
        -- Check if email is used by another member
        IF EXISTS (SELECT 1 FROM Members WHERE Email = @Email AND ID <> @ID AND IsActive = 1)
        BEGIN
            RAISERROR('Email already in use by another member', 16, 1);
            RETURN;
        END
        
        UPDATE Members
        SET
            FirstName = @FirstName,
            LastName = @LastName,
            MaritalStatus = @MaritalStatus,
            DateOfBirth = @DateOfBirth,
            Gender = @Gender,
            Email = @Email,
            Phone = @Phone,
            [Password] = CAST(@Password AS VARBINARY(256)),
            BranchID = (SELECT ID FROM Branches WHERE [Name] = @BranchName AND IsActive = 1),
            StatusID = (SELECT ID FROM [Status] WHERE [Name] = @StatusName AND IsActive = 1),
            RoleID = (SELECT ID FROM Roles WHERE [Name] = @RoleName AND IsActive = 1),
            EmploymentStatusID = (SELECT ID FROM EmploymentStatus WHERE Employment = @EmployeeName AND IsActive = 1),
            ModifiedDate = GETDATE()
        WHERE ID = @ID AND IsActive = 1;
        
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('Member update failed', 16, 1);
        END
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 25. spUpdateUser (Updated for EmploymentStatusID)
CREATE OR ALTER PROCEDURE spUpdateUser
    @LastName VARCHAR(50),
    @MaritalStatus VARCHAR(10),
    @Email VARCHAR(50),
    @Password VARCHAR(50),
    @EmployeeName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE [dbo].[Members]
        SET  
            [LastName] = @LastName, 
            [MaritalStatus] = @MaritalStatus,
            [Password] = CAST(@Password AS VARBINARY(256)),
            [EmploymentStatusID] = (SELECT ID FROM EmploymentStatus WHERE Employment = @EmployeeName AND IsActive = 1),
            [ModifiedDate] = GETDATE()
        WHERE [Email] = @Email AND IsActive = 1;
        
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('User not found with the specified email', 16, 1);
        END
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 26. spGetActivity (Updated for Activity table)
CREATE OR ALTER PROCEDURE spGetActivity
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[vw_Activities]
        ORDER BY [Name];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 27. spGetBranchByProvince
CREATE OR ALTER PROCEDURE spGetBranchByProvince
    @Country VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT DISTINCT Province FROM [dbo].[vw_Branches]
        WHERE [Country] = @Country
        ORDER BY Province;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 28. spGetBranchCountries
CREATE OR ALTER PROCEDURE spGetBranchCountries
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT DISTINCT [Country] FROM [dbo].[vw_Branches]
        ORDER BY [Country];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 29. spRegisterMemberActivity (Updated for MemberActivities)
CREATE OR ALTER PROCEDURE spRegisterMemberActivity
    @MemberEmail VARCHAR(50),
    @ActivityName VARCHAR(50),
    @ParticipationDate DATE = NULL,
    @HoursParticipated DECIMAL(5,2) = 0,
    @Notes VARCHAR(500) = NULL,
    @NewActivityMemberID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @ParticipationDate IS NULL
            SET @ParticipationDate = GETDATE();
        
        INSERT INTO MemberActivities (MemberID, ActivityID, ParticipationDate, HoursParticipated, Notes, IsActive, CreatedDate, ModifiedDate)
        VALUES (
            (SELECT ID FROM Members WHERE Email = @MemberEmail AND IsActive = 1),
            (SELECT ID FROM Activity WHERE [Name] = @ActivityName AND IsActive = 1),
            @ParticipationDate, @HoursParticipated, @Notes, 1, GETDATE(), GETDATE()
        );
            
        SET @NewActivityMemberID = SCOPE_IDENTITY();
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 30. spRecordAttendance (NEW Stored Procedure)
CREATE OR ALTER PROCEDURE spRecordAttendance
    @MemberEmail VARCHAR(50),
    @ActivityName VARCHAR(50),
    @AttendanceDate DATE = NULL,
    @TimeIn TIME = NULL,
    @TimeOut TIME = NULL,
    @IsPresent BIT = 1,
    @Notes VARCHAR(500) = NULL,
    @NewAttendanceID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @AttendanceDate IS NULL
            SET @AttendanceDate = GETDATE();
        
        INSERT INTO Attendance (MemberID, ActivityID, AttendanceDate, TimeIn, TimeOut, IsPresent, Notes, IsActive, CreatedDate, ModifiedDate)
        VALUES (
            (SELECT ID FROM Members WHERE Email = @MemberEmail AND IsActive = 1),
            (SELECT ID FROM Activity WHERE [Name] = @ActivityName AND IsActive = 1),
            @AttendanceDate, @TimeIn, @TimeOut, @IsPresent, @Notes, 1, GETDATE(), GETDATE()
        );
            
        SET @NewAttendanceID = SCOPE_IDENTITY();
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 31. spRecordContribution (NEW Stored Procedure)
CREATE OR ALTER PROCEDURE spRecordContribution
    @MemberEmail VARCHAR(50),
    @ContributionDate DATE = NULL,
    @Amount DECIMAL(10,2),
    @ContributionType VARCHAR(50),
    @PaymentMethod VARCHAR(50),
    @ReferenceNumber VARCHAR(100) = NULL,
    @Notes VARCHAR(500) = NULL,
    @NewContributionID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @ContributionDate IS NULL
            SET @ContributionDate = GETDATE();
        
        INSERT INTO Contributions (MemberID, ContributionDate, Amount, ContributionType, PaymentMethod, ReferenceNumber, Notes, IsActive, CreatedDate, ModifiedDate)
        VALUES (
            (SELECT ID FROM Members WHERE Email = @MemberEmail AND IsActive = 1),
            @ContributionDate, @Amount, @ContributionType, @PaymentMethod, @ReferenceNumber, @Notes, 1, GETDATE(), GETDATE()
        );
            
        SET @NewContributionID = SCOPE_IDENTITY();
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 32. spGetAttendance (NEW Stored Procedure)
CREATE OR ALTER PROCEDURE spGetAttendance
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @ActivityName VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @StartDate IS NULL
            SET @StartDate = DATEADD(DAY, -30, GETDATE());
        
        IF @EndDate IS NULL
            SET @EndDate = GETDATE();
        
        SELECT * FROM [dbo].[vw_Attendance]
        WHERE AttendanceDate BETWEEN @StartDate AND @EndDate
        AND (@ActivityName IS NULL OR ActivityName = @ActivityName)
        ORDER BY AttendanceDate DESC, ActivityName;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- 33. spGetContributions (NEW Stored Procedure)
CREATE OR ALTER PROCEDURE spGetContributions
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @ContributionType VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @StartDate IS NULL
            SET @StartDate = DATEADD(DAY, -30, GETDATE());
        
        IF @EndDate IS NULL
            SET @EndDate = GETDATE();
        
        SELECT * FROM [dbo].[vw_Contributions]
        WHERE ContributionDate BETWEEN @StartDate AND @EndDate
        AND (@ContributionType IS NULL OR ContributionType = @ContributionType)
        ORDER BY ContributionDate DESC;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO