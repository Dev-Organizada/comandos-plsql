DECLARE
    v_stat_work NUMBER;
    v_day_off   NUMBER;
    v_first_day DATE;
    v_next_day  DATE;
    v_day_week  VARCHAR2(15);
    v_add_hours number;
BEGIN
    v_stat_work := 12 / 24; -- qtd horas trabalhadas por dia
    v_day_off   := 36 / 24; -- qtd de horas de folgas por dia
    v_add_hours := 48 / 24; -- verifica a qtd de horas entre a folga e o proximo dia a ser trabalhado
    v_first_day := TO_DATE ( '13/02/2023 07:00', 'dd/mm/yyyy hh24:mi' ); -- inicio da jornada de trabalho
    FOR i IN 1..7 LOOP -- verifica os dias trabalhados no período de 7 dias
        BEGIN
            SELECT
                v_first_day + v_stat_work
            INTO v_next_day
            FROM
                dual;

        EXCEPTION
            WHEN OTHERS THEN
                v_next_day := NULL;
        END;

        IF v_next_day IS NULL THEN
            dbms_output.put_line('Verifique as informações passadas e tente novamente.');
        ELSE
            BEGIN
                SELECT
                    to_char(TO_DATE(v_next_day),'DAY')
                INTO v_day_week
                FROM
                    dual;

                dbms_output.put_line(v_day_week|| ' - '|| to_char(v_next_day, 'dd/mm/yyyy hh24:mi'));
                v_first_day := v_first_day + v_add_hours;
            EXCEPTION
                WHEN OTHERS THEN
                    v_day_week := NULL;
            END;
        END IF;

    END LOOP;

END;

