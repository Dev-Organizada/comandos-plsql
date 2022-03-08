insert into tb_lista_de_tarefas
  (id_lista, descricao, dt_realizacao)
values
  (1,'Teste de a fazer',
   to_date('08/03/2022 13:33', 'dd/mm/yyyy hh24:mi'));
   
insert into tb_lista_de_tarefas
  (id_lista, descricao, dt_realizacao)
values
  (2,'Teste de fazendo',
   to_date('08/03/2022 12:25', 'dd/mm/yyyy hh24:mi'));

insert into tb_lista_de_tarefas
  (id_lista, descricao, dt_realizacao)
values
  (3,'Teste de feito',
   to_date('04/03/2022 09:30', 'dd/mm/yyyy hh24:mi'));

   
insert into tb_lista_de_tarefas
  (id_lista, descricao, dt_realizacao)
values
  (4,'Teste de atraso',
   to_date('04/03/2022 13:33', 'dd/mm/yyyy hh24:mi'));

commit;