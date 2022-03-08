create or replace procedure pr_atualiza_lista is
  cursor cr_atualiza_lista is
    select * from tb_lista_de_tarefas lt where lt.fl_status in (1, 2);
begin
  for i in cr_atualiza_lista loop
    if i.dt_realizacao < sysdate then
      update tb_lista_de_tarefas
         set fl_status = 4
       where id_lista = i.id_lista;
      commit;
    end if;
  end loop;
end;