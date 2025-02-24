-- Inciando o sistema 

-- Cadastro de cidade
BEGIN
    pk_gestao_venda.pr_registra_cidade('Franca', 'SP');
END;
-----------

--Cadastro de endereço
DECLARE
    vendereco t_endereco;
BEGIN
    vendereco := t_endereco(04567890, 'Arizona', 'Arandu', 4);
    pk_gestao_venda.pr_registra_endereco(vendereco);
END;
-----------

--Cadastro de cliente
declare
    v_cliente  t_cliente;
BEGIN
 v_cliente :=  t_cliente(
        'Carlos Souza', 
        11987654321, 
        'carlos@email.com', 
        TO_DATE('20/10/1985', 'DD/MM/YYYY'), 
        'M', 
        60441160,
        'Casa B',
        250
    );
    pk_gestao_venda.pr_cadastra_cliente(v_cliente);
END;
-------------

-- Cadastro de categoria
BEGIN
    pk_gestao_venda.pr_registra_categoria('TECNOLOGIA');
END;
-------------

--Cadastro de forma de pagamento
BEGIN
    pk_gestao_venda.pr_registra_forma_pagamento('Boleto');
END;
-------------

--Cadastro de produto
BEGIN
    pk_gestao_venda.pr_cadastra_produto(
        pnome        => 'Geladeira',
        pdescricao   => 'Panasonic',
        pidcategoria => 2
    );
END;
-------------

--Cadatrado de estoque do produto
BEGIN
    pk_gestao_venda.pr_cadastra_estoque(
        pidproduto  => 4,
        pquantidade => 8,
        pvaloruni   => 4509.99
    );
END;
-------------

-- Geração do pedido
DECLARE
    -- Arrays de produtos e quantidades
    v_produtos    sys.odcinumberlist := sys.odcinumberlist(1, 3); -- Produtos
    v_quantidades sys.odcinumberlist := sys.odcinumberlist(1, 1); -- Quantidades
BEGIN
    -- Chama a procedure
    pk_gestao_venda.pr_gera_pedido(
        pidcliente   => 11,
        pidprodutos  => v_produtos,
        pquantidades => v_quantidades,
        pidpagamento => 1
    );
END;
-------------

--Atualiza estoque. Pode ser utilizado para adicionar ou retirar produto e atualizar preço dos produtos
BEGIN
    pk_gestao_venda.pr_atualiza_estoque(3, 10, 'Adicao');
END;
-------------

--Informações sobre o pedido gerado
BEGIN
    pk_gestao_venda.pr_dados_pedido(pidpedido => 10);
END;
-------------

--Consulta endereço utilizando o cep
select pk_gestao_venda.f_busca_cep('60441160') from dual;

select c.*, pk_gestao_venda.f_busca_cep(c.cep) endereco from cliente c;
-------------

--Altera formato da data da sessão
ALTER SESSION SET nls_date_format = 'DD/MM/YYYY HH24:MI:SS';
