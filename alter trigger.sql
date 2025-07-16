alter trigger trg_data_consulta on consulta
for insert
as
begin
    declare @data_nova date
    select @data_nova = data_consulta from inserted
 
    if (@data_nova < cast(getdate() as date)) -- compara apenas a data, sem hora
    begin
        raiserror('Nao é permitido inserir uma consulta com data retroativa!', 16, 1)
        rollback transaction
    end
end;

