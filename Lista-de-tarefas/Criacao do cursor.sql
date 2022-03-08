declare
  v_tipo     number;
  v_contador number;
  cursor cr_lista is
    select * from tb_lista_de_tarefas lt where lt.fl_status = v_tipo;
begin
  v_tipo     := &tipo;
  v_contador := 0;

  --Tarefas a fazer
  if v_tipo = 1 then
    dbms_output.put_line('Segue lista de tarefas A Fazer:');
    dbms_output.put_line('');
    for i in cr_lista loop
      dbms_output.put_line('Descrição: ' || i.descricao ||
                           ' - Data de realização: ' ||
                           to_char(i.dt_realizacao, 'dd/mm/yyyy hh24:mi'));
      v_contador := v_contador + 1;
    end loop;
  
    -- Tarefas fazendo
  elsif v_tipo = 2 then
    dbms_output.put_line('Segue lista de tarefas que estão sendo Feitas:');
    dbms_output.put_line('');
    for i in cr_lista loop
      dbms_output.put_line('Descrição: ' || i.descricao ||
                           ' - Data de realização: ' ||
                           to_char(i.dt_realizacao, 'dd/mm/yyyy hh24:mi'));
      v_contador := v_contador + 1;
    end loop;
  
    -- Tarefas feitas
  elsif v_tipo = 3 then
    dbms_output.put_line('Segue lista de tarefas Feitas:');
    dbms_output.put_line('');
    for i in cr_lista loop
      dbms_output.put_line('Descrição: ' || i.descricao ||
                           ' - Data de realização: ' ||
                           to_char(i.dt_realizacao, 'dd/mm/yyyy hh24:mi'));
      v_contador := v_contador + 1;
    end loop;
  
    -- Tarefas em atraso
  elsif v_tipo = 4 then
    dbms_output.put_line('Segue lista de tarefas em Atraso:');
    dbms_output.put_line('');
    for i in cr_lista loop
      dbms_output.put_line('Descrição: ' || i.descricao ||
                             ' - Data de realização: ' ||
                             to_char(i.dt_realizacao, 'dd/mm/yyyy hh24:mi'));
        v_contador := v_contador + 1;
    end loop;
  else
    dbms_output.put_line('Tipo informado não cadastrado na base de dados.');
  end if;

  if v_contador = 0 then
    dbms_output.put_line('Lista de atividades está vazia.');
  else
    dbms_output.put_line('Total de tarefas: ' || v_contador);
  end if;
end;