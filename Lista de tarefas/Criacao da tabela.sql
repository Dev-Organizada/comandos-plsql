create table tb_lista_de_tarefas(
       id_lista      number not null constraint pk_lista_tarefa primary key,
       descricao     varchar2(400) not null,
       dt_realizacao date,
       fl_status     number default 1,
       dt_registro   date   default sysdate
);