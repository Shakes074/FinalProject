CREATE procedure spRegisterBranch
    @Country varchar(50),
    @Province varchar(50),
	@Name varchar(100)
    as
    begin
        insert into InsertViewBranch
        ([Country], [Province], [Name])
        values
        (@Country, @Province, @Name);
    end;