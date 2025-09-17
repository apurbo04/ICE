select * from titles

create proc sp_updatePrice @parameter char(15) 
as 
begin
	declare @temp money
	select @temp = price from titles where title_id=@parameter 
	set @temp = @temp+0.2*@temp
	if @temp<= 50
	update titles set price=@temp where title_id = @parameter
end

exec sp_updatePrice 'BU7832'

