    create procedure spRegisterActivity
@Name varchar(50),
@Description varchar(150)
as
begin
	insert into ViewAllActivities
	values(@Name,@Description);
end;