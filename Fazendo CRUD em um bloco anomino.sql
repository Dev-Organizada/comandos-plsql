declare
  v_opcao         number default 0;
  v_identificador number;
  v_verificador  varchar2(1);
  v_novo_id       ideias.id_ideias%type;
  v_novo_tema     ideias.tema%type;

  cursor cr_dados is
    select * from ideias;

begin
  v_opcao         := &opcao;
  v_identificador := &identificador;
  v_novo_id       := &novo_id;
  v_novo_tema     := &novo_tema;

  -- Consultar tabela
  if v_opcao = 1 then
    dbms_output.put_line('Dados da tabela IDEIAS:');
    for i in cr_dados loop
      dbms_output.put_line('ID Ideia: ' || i.id_ideias || ' - Tema: ' ||
                           i.tema);
    end loop;
  
    -- Inserir dados na tabela
  elsif v_opcao = 2 then
    begin
      insert into ideias values (v_novo_id, v_novo_tema);
      commit;
      dbms_output.put_line('Dados inseridos com sucesso.');
    exception
      when others then
        dbms_output.put_line('Erro encontrado! ' || sqlerrm);
        rollback;
    end;
  
    -- Atualizar dados da tabela
  elsif v_opcao = 3 then
    begin
      select 'S'
        into v_verificador
        from ideias
       where id_ideias = v_identificador;
    exception
      when others then
        v_verificador := null;
    end;
    if v_verificador is not null then
      update ideias
         set tema = v_novo_tema
       where id_ideias = v_identificador;
      commit;
      dbms_output.put_line('Dados atualizados com sucesso.');
    else
      dbms_output.put_line('Identificador não existe na tabela.');
    end if;
  
    -- Deletando dados da tabela
  elsif v_opcao = 4 then
    begin
      select 'S'
        into v_verificador
        from ideias
       where id_ideias = v_identificador;
    exception
      when others then
        v_verificador := null;
    end;
    if v_verificador is not null then
      delete from ideias where id_ideias = v_identificador;
      commit;
      dbms_output.put_line('Dados deletados com sucesso.');
    else
      dbms_output.put_line('Identificador não existe na tabela.');
    end if;
  else
    dbms_output.put_line('Opção não permitida.');
  end if;
end;