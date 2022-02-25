declare
  v_num1      number;
  v_operador  varchar2(1);
  v_resultado number;
begin
  v_num1     := &num1;
  v_operador := &operador;

  if v_operador = '+' then
    for i in 1 .. 10 loop
      v_resultado := v_num1 + i;
      dbms_output.put_line(i || ' + ' || v_num1 || ' = ' || v_resultado);
    end loop;
  
  elsif v_operador = '-' then
    for i in 1 .. 10 loop
      v_resultado := v_num1 - i;
      dbms_output.put_line(i || ' - ' || v_num1 || ' = ' || v_resultado);
    end loop;
  
  elsif v_operador = '*' then
    for i in 1 .. 10 loop
      v_resultado := v_num1 * i;
      dbms_output.put_line(i || ' * ' || v_num1 || ' = ' || v_resultado);
    end loop;
  
  elsif v_operador = '/' then
    for i in 1 .. 10 loop
      v_resultado := v_num1 / i;
      dbms_output.put_line(i || ' / ' || v_num1 || ' = ' || v_resultado);
    end loop;
  else
    dbms_output.put_line('Operador inválido.');
  end if;
end;