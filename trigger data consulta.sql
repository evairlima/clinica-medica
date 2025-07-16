create trigger trg_data_consulta

on consulta

after insert

as

begin

if exists (select * from inserted where data_consulta < getdate())

begin

rollback transaction;

	raiserror('Nao � permitido inserir uma consulta com data retroativa!', 16, 1);

end

end
 
 
 
insert into consulta (data_consulta, horario_consulta, fk_paciente_cpf, fk_medico_crm)

values ('2023-01-01', '10:00', '012.345.678-90', 102030); --Vair exibir erro pois a data � retroativa
 
 
insert into consulta (data_consulta, horario_consulta, fk_paciente_cpf, fk_medico_crm)

values(cast(getdate() as date), '15:00','123.456.789-12',203040);-- vai executar pois segue as regras de neg�cio do sistema
 
select * from consulta;

 