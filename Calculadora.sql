declare
  v_num1      number;
  v_num2      number;
  v_operador  varchar2(1);
  v_resultado number;
begin
  v_num1     := &num1;
  v_num2     := &num2;
  v_operador := &operador;

  if v_operador = '+' then
    v_resultado := v_num1 + v_num2;
    dbms_output.put_line('Resultado: ' || v_resultado);
  
  elsif v_operador = '-' then
    v_resultado := v_num1 - v_num2;
    dbms_output.put_line('Resultado: ' || v_resultado);
  
  elsif v_operador = '*' then
    v_resultado := v_num1 * v_num2;
    dbms_output.put_line('Resultado: ' || v_resultado);
  
  elsif v_operador = '/' then
    if v_num2 = 0 then
      dbms_output.put_line('Divisor tem que ser maior que zero.');
    else
      v_resultado := v_num1 / v_num2;
      dbms_output.put_line('Resultado real: ' 		 || v_resultado);
      dbms_output.put_line('Resultado truncado: '    || trunc(v_resultado));
      dbms_output.put_line('Resultado arredondado: ' || round(v_resultado));
    end if;
  
  else
    dbms_output.put_line('Operador inválido.');
  end if;
end;