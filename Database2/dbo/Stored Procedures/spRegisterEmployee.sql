CREATE PROCEDURE spRegisterEmployee
@Employment varchar(150),
@Description varchar(150)
AS
BEGIN
    INSERT INTO ViewAllEmployee ([Employment], [Description])
    VALUES (@Employment, @Description);
END;