	create procedure spRegisterRoles
@name varchar(50),
@description varchar(150)
as
	begin
		insert into ViewAllRoles values
					(@name, @description)
	end;