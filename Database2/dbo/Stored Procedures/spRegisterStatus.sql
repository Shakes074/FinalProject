
CREATE procedure spRegisterStatus
	@Name varchar(50),
	@Description varchar(150),
	@Criteria varchar(200)
	as
	begin
	insert into ViewAllStatus
		values (@Name, @Description, @Criteria);
	end;