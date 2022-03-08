create table tb_lista_de_tarefas(
       id_lista      number not null constraint pk_lista_tarefa primary key,
       descricao     varchar2(400) not null,
       dt_realizacao date,
       fl_status     number default 1,
       dt_registro   date   default sysdate
);

--Comentários 
comment on column humaster.tb_lista_de_tarefas.fl_status
  is 'Status da tarefa [1-A fazer; 2-Fazendo; 3-Feito; 4-Em atraso]';