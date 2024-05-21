---- Crreating View function for getting status
USE [InqolaYevangeli];
GO

CREATE VIEW [ViewAllStatus]
AS 
SELECT [ID], [Name], [Description], [Criteria]
FROM [dbo].[Status];
GO


create procedure spGetStatus
	as
	begin
select * from ViewAllStatus;
	end;

	exec spGetStatus;


	Create procedure spRegisterStatus
	@Name varchar(50),
	@Description varchar(150),
	@Criteria varchar(200)
	as
	begin
	insert into ViewAllStatus
		values (@Name, @Description, @Criteria);
	end;

	exec spRegisterStatus
	@Name ='dfdf', @Description ='dfdf', @Criteria = 'dfdf';


---- 








