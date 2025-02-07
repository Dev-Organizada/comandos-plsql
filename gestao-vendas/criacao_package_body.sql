CREATE OR REPLACE PACKAGE BODY pk_gestao_venda AS

    PROCEDURE pr_registra_categoria (
        pnome IN categoria.nome%TYPE
    ) IS
    BEGIN
        INSERT INTO categoria VALUES ( categoria_seq.NEXTVAL,
                                       pnome );

        COMMIT;
        dbms_output.put_line('Categoria cadastrada com sucesso');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Erro ao cadastrar categoria. ' || sqlerrm);
    END;

    PROCEDURE pr_registra_forma_pagamento (
        pdescricao IN forma_pagamento.descricao%TYPE
    ) IS
    BEGIN
        INSERT INTO forma_pagamento VALUES ( pagamento_seq.NEXTVAL,
                                             pdescricao );

        COMMIT;
        dbms_output.put_line('Forma de pagamento cadastrada com sucesso');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Erro ao cadastrar forma de pagamento. ' || sqlerrm);
    END;

    PROCEDURE pr_registra_cidade (
        pcidade IN cidade.nome%TYPE,
        pestado IN cidade.estado%TYPE
    ) IS
    BEGIN
        INSERT INTO cidade VALUES ( cidade_seq.NEXTVAL,
                                    pcidade,
                                    pestado );

        COMMIT;
        dbms_output.put_line('Cidade cadastrada com sucesso');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Erro ao cadastrar cidade. ' || sqlerrm);
    END;

    FUNCTION f_busca_cep (
        pcep IN endereco.cep%TYPE
    ) RETURN t_ref_cursor IS
        v_cep_ref t_ref_cursor;
    BEGIN
        OPEN v_cep_ref FOR SELECT
                                                  en.rua,
                                                  en.bairro,
                                                  ci.nome,
                                                  ci.estado
                                              FROM
                                                  endereco en,
                                                  cidade   ci
                           WHERE
                                   en.id_cidade = ci.id_cidade
                               AND en.cep = pcep;

        RETURN v_cep_ref;
    END;

    PROCEDURE pr_cadastra_cliente (
        pnome           IN cliente.nome%TYPE,
        ptelefone       IN cliente.telefone%TYPE,
        pemail          IN cliente.email%TYPE,
        pdatanascimento IN cliente.data_nascimento%TYPE,
        psexo           IN cliente.sexo%TYPE,
        pidendereco     IN cliente.id_endereco%TYPE,
        pnumero         IN cliente.numero_residencia%TYPE,
        pcomplemento    IN cliente.complemento%TYPE
    ) IS
        vverificaendereco VARCHAR2(1);
    BEGIN
        BEGIN
            SELECT
                'S'
            INTO vverificaendereco
            FROM
                endereco
            WHERE
                id_endereco = pidendereco;

        EXCEPTION
            WHEN no_data_found THEN
                vverificaendereco := 'N';
                dbms_output.put_line('Código informado não possui endereço cadastrado.');
            WHEN OTHERS THEN
                vverificaendereco := 'N';
                dbms_output.put_line('Erro ao pesquisar endereço. ' || sqlerrm);
        END;

        IF vverificaendereco = 'S' THEN
            BEGIN
                INSERT INTO cliente VALUES ( cliente_seq.NEXTVAL,
                                             pnome,
                                             ptelefone,
                                             pemail,
                                             pdatanascimento,
                                             psexo,
                                             pidendereco,
                                             pcomplemento,
                                             pnumero );

                COMMIT;
                dbms_output.put_line('Cliente cadastrado com sucesso');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    dbms_output.put_line('Erro ao cadastrar cliente. ' || sqlerrm);
            END;

        END IF;

    END;

    PROCEDURE pr_cadastra_produto (
        pnome        IN produto.nome%TYPE,
        pdescricao   IN produto.descricao%TYPE,
        pidcategoria IN produto.id_categoria%TYPE
    ) IS
        vverificanome      VARCHAR2(1);
        vverificacategoria VARCHAR2(1);
    BEGIN
        BEGIN
            SELECT
                'S'
            INTO vverificanome
            FROM
                produto
            WHERE
                    nome = pnome
                AND descricao = pdescricao;

        EXCEPTION
            WHEN no_data_found THEN
                vverificanome := 'N';
            WHEN OTHERS THEN
                vverificanome := 'S';
                dbms_output.put_line('Erro ao pesquisar nome do produto. ' || sqlerrm);
        END;

        BEGIN
            SELECT
                'S'
            INTO vverificacategoria
            FROM
                categoria
            WHERE
                id_categoria = pidcategoria;

        EXCEPTION
            WHEN no_data_found THEN
                vverificacategoria := 'N';
                dbms_output.put_line('Categoria não cadastrada no sistema.');
            WHEN OTHERS THEN
                vverificacategoria := 'N';
                dbms_output.put_line('Erro ao pesquisar categoria. ' || sqlerrm);
        END;

        IF vverificanome = 'N' THEN
            IF vverificacategoria = 'S' THEN
                BEGIN
                    INSERT INTO produto VALUES ( produto_seq.NEXTVAL,
                                                 pnome,
                                                 pdescricao,
                                                 pidcategoria,
                                                 sysdate );

                    COMMIT;
                    dbms_output.put_line('Produto cadastrado com sucesso');
                EXCEPTION
                    WHEN OTHERS THEN
                        ROLLBACK;
                        dbms_output.put_line('Erro ao cadastrar produto. ' || sqlerrm);
                END;

            END IF;
        ELSE
            dbms_output.put_line('Produto já cadastrado no sistema.');
        END IF;

    END;

    PROCEDURE pr_cadastra_estoque (
        pidproduto  IN estoque.id_produto%TYPE,
        pquantidade IN estoque.quantidade%TYPE,
        pvaloruni   IN estoque.valor_unitario%TYPE
    ) IS
        vverificaproduto VARCHAR2(1);
    BEGIN
        BEGIN
            SELECT
                'S'
            INTO vverificaproduto
            FROM
                produto
            WHERE
                id_produto = pidproduto;

        EXCEPTION
            WHEN no_data_found THEN
                vverificaproduto := 'N';
                dbms_output.put_line('Produto não cadastrado no sistema.');
            WHEN OTHERS THEN
                vverificaproduto := 'N';
                dbms_output.put_line('Erro ao pesquisar produto em sistema. ' || sqlerrm);
        END;

        IF vverificaproduto = 'S' THEN
            BEGIN
                INSERT INTO estoque VALUES ( estoque_seq.NEXTVAL,
                                             pidproduto,
                                             pquantidade,
                                             pvaloruni,
                                             sysdate,
                                             sysdate );

                COMMIT;
                dbms_output.put_line('Estoque registrado com sucesso.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    dbms_output.put_line('Erro ao registrar estoque.' || sqlerrm);
            END;

        END IF;

    END;

    PROCEDURE pr_atualiza_estoque (
        pidproduto  IN estoque.id_produto%TYPE,
        pquantidade IN estoque.quantidade%TYPE,
        pacao       IN VARCHAR2
    ) IS
    BEGIN
        IF pacao = 'Subtracao' THEN
            UPDATE estoque
            SET
                quantidade = quantidade - pquantidade,
                ultima_atualizacao = sysdate
            WHERE
                id_produto = pidproduto;

            COMMIT;
        ELSIF pacao = 'Adicao' THEN
            UPDATE estoque
            SET
                quantidade = quantidade + pquantidade,
                ultima_atualizacao = sysdate
            WHERE
                id_produto = pidproduto;

            COMMIT;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Erro ao atualizar estoque. ' || sqlerrm);
    END;

    FUNCTION f_valor_total (
        pidproduto  IN estoque.id_produto%TYPE,
        pquantidade IN estoque.quantidade%TYPE
    ) RETURN NUMBER IS
        vvalortotal NUMBER;
    BEGIN
        SELECT
            valor_unitario * pquantidade
        INTO vvalortotal
        FROM
            estoque
        WHERE
            id_produto = pidproduto;

        RETURN vvalortotal;
    EXCEPTION
        WHEN no_data_found THEN
            vvalortotal := 0;
            dbms_output.put_line('Produto sem estoque.');
        WHEN OTHERS THEN
            vvalortotal := 0;
            dbms_output.put_line('Erro ao calcular valor. ' || sqlerrm);
    END;

    PROCEDURE pr_gera_pedido (
        pidcliente   IN NUMBER,
        pidprodutos  IN sys.odcinumberlist,  -- array de códigos de produtos
        pquantidades IN sys.odcinumberlist,     -- array de quantidades
        pidpagamento IN forma_pagamento.id_pagamento%TYPE
    ) IS

        vvalidacliente   VARCHAR2(1);
        vvalidaproduto   VARCHAR2(1);
        vvalidapagamento VARCHAR2(1);
        vverificaestoque estoque.quantidade%TYPE;
        vvalortotal      NUMBER := 0;
        vidpedido        pedido.id_pedido%TYPE;
    BEGIN
        -- Calcular valor total
        FOR i IN 1..pidprodutos.count LOOP
            vvalortotal := vvalortotal + f_valor_total(
                pidprodutos(i),
                pquantidades(i)
            );
        END LOOP;
        
        -- Verifica se cliente esta cadastrado
        BEGIN
            SELECT
                'S'
            INTO vvalidacliente
            FROM
                cliente
            WHERE
                id_cliente = pidcliente;

        EXCEPTION
            WHEN no_data_found THEN
                vvalidacliente := 'N';
                dbms_output.put_line('Cliente não cadastrado no sistema');
            WHEN OTHERS THEN
                vvalidacliente := 'N';
                dbms_output.put_line('Erro ao pesquisar cliente. ' || sqlerrm);
        END;

        IF vvalidacliente = 'S' THEN
            BEGIN
                SELECT
                    pedido_seq.NEXTVAL
                INTO vidpedido
                FROM
                    dual;

            EXCEPTION
                WHEN OTHERS THEN
                    BEGIN
                        SELECT
                            MAX(id_pedido) + 1
                        INTO vidpedido
                        FROM
                            pedido;

                    EXCEPTION
                        WHEN OTHERS THEN
                            vidpedido := 0;
                    END;
            END;
            -- Insere o cabeçalho do pedido na tabela de pedidos
            BEGIN
                INSERT INTO pedido VALUES ( vidpedido,
                                            pidcliente,
                                            sysdate,
                                            vvalortotal,
                                            pidpagamento );

                COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                    dbms_output.put_line('Erro ao cadastrar cabeçalho de pedido: ' || sqlerrm);
                    ROLLBACK;
            END;

        END IF;

        FOR i IN 1..pidprodutos.count LOOP
            BEGIN
                SELECT
                    'S'
                INTO vvalidaproduto
                FROM
                    produto
                WHERE
                    id_produto = pidprodutos(i);

            EXCEPTION
                WHEN no_data_found THEN
                    vvalidaproduto := 'N';
                    dbms_output.put_line('Produto não cadastrado no sistema');
                WHEN OTHERS THEN
                    vvalidaproduto := 'N';
                    dbms_output.put_line('Erro ao pesquisar produto. ' || sqlerrm);
            END;

            BEGIN
                SELECT
                    'S'
                INTO vvalidapagamento
                FROM
                    forma_pagamento
                WHERE
                    id_pagamento = pidpagamento;

            EXCEPTION
                WHEN no_data_found THEN
                    vvalidapagamento := 'N';
                    dbms_output.put_line('Forma de pagamento não cadastrado no sistema');
                WHEN OTHERS THEN
                    vvalidapagamento := 'N';
                    dbms_output.put_line('Erro ao pesquisar forma de pagamento. ' || sqlerrm);
            END;

            BEGIN
                SELECT
                    quantidade
                INTO vverificaestoque
                FROM
                    estoque
                WHERE
                    id_produto = pidprodutos(i);

            EXCEPTION
                WHEN no_data_found THEN
                    vverificaestoque := 0;
                    dbms_output.put_line('Quantidade indisponivel.');
                WHEN OTHERS THEN
                    vverificaestoque := 0;
                    dbms_output.put_line('Erro ao pesquisar quantidade do produto. ' || sqlerrm);
            END;

            IF
                vvalidaproduto = 'S'
                AND vvalidapagamento = 'S'
                AND vverificaestoque >= pquantidades(i)
            THEN
                BEGIN
                    INSERT INTO pedido_item VALUES ( vidpedido,
                                                     pidprodutos(i),
                                                     pquantidades(i) );

                    COMMIT;
                    pr_atualiza_estoque(
                        pidprodutos(i),
                        pquantidades(i),
                        'Subtracao'
                    );
                EXCEPTION
                    WHEN OTHERS THEN
                        ROLLBACK;
                        dbms_output.put_line('Erro ao inserir itens do pedido. ' || sqlerrm);
                END;
            END IF;

        END LOOP;

        dbms_output.put_line('Pedido realizado com sucesso! Pedido Nº: ' || vidpedido);
    END;

    PROCEDURE pr_dados_pedido (
        pidpedido pedido.id_pedido%TYPE
    ) IS

        CURSOR cdadospedido IS
        SELECT
            c.nome,
            c.telefone,
            c.email,
            p.valor_total,
            p.data_pedido
        FROM
            pedido  p,
            cliente c
        WHERE
                p.id_cliente = c.id_cliente
            AND p.id_pedido = pidpedido;

        CURSOR cdadositens IS
        SELECT
            ca.nome                         categoria,
            pr.nome                         produto,
            e.valor_unitario,
            i.quantidade,
            e.valor_unitario * i.quantidade total_produto
        FROM
            categoria   ca,
            produto     pr,
            estoque     e,
            pedido_item i
        WHERE
                ca.id_categoria = pr.id_categoria
            AND e.id_produto = pr.id_produto
            AND i.id_produto = pr.id_produto
            AND i.id_pedido = pidpedido;

    BEGIN
        FOR i IN cdadospedido LOOP
            dbms_output.put_line('------ Informações do cliente ------ ');
            dbms_output.put_line('Nome: ' || i.nome);
            dbms_output.put_line('Telefone: ' || i.telefone);
            dbms_output.put_line('E-mail: ' || i.email);
            dbms_output.put_line('');
            dbms_output.put_line('------ Itens do pedido ------ ');
            FOR x IN cdadositens LOOP
                dbms_output.put_line('Categoria: ' || x.categoria);
                dbms_output.put_line('Produto: ' || x.produto);
                dbms_output.put_line('Valor unitário: R$' || x.valor_unitario);
                dbms_output.put_line('Quantidade: ' || x.quantidade);
                dbms_output.put_line('Valor total: R$' || x.total_produto);
                dbms_output.put_line('');
            END LOOP;

            dbms_output.put_line('------ ------ ');
            dbms_output.put_line('Valor total do pedido: R$' || i.valor_total);
            dbms_output.put_line('Data do pedido: '
                                 || TO_DATE(i.data_pedido, 'dd/mm/yyyy hh24:mi:ss'));
        END LOOP;
    END;

END pk_gestao_venda;
