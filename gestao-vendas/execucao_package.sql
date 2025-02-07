BEGIN
    pk_gestao_venda.pr_registra_categoria('Eletrodomestico');
END;

BEGIN
    pk_gestao_venda.pr_registra_cidade('Fortaleza', 'CE');
END;

BEGIN
    pk_gestao_venda.pr_cadastra_cliente(
        pnome           => 'Nathaly Rodrigues',
        ptelefone       => 85998653201,
        pemail          => 'nathaly.rodrigues@teste.com',
        pdatanascimento => TO_DATE('25/03/1996', 'dd/mm/yyyy'),
        psexo           => 'F',
        pidendereco     => 1,
        pnumero         => 100,
        pcomplemento    => 'Bl 7, apto 001'
    );
END;

BEGIN
    pk_gestao_venda.pr_registra_forma_pagamento('Boleto');
END;

BEGIN
    pk_gestao_venda.pr_cadastra_produto(
        pnome        => 'Microondas',
        pdescricao   => 'Electrolux',
        pidcategoria => 2
    );
END;

BEGIN
    pk_gestao_venda.pr_cadastra_estoque(
        pidproduto  => 2,
        pquantidade => 8,
        pvaloruni   => 4109.99
    );
END;

DECLARE
    -- Arrays de produtos e quantidades
    v_produtos    sys.odcinumberlist := sys.odcinumberlist(1, 3); -- Produtos
    v_quantidades sys.odcinumberlist := sys.odcinumberlist(1, 1); -- Quantidades
BEGIN
    pk_gestao_venda.pr_gera_pedido(
        pidcliente   => 11,
        pidprodutos  => v_produtos,
        pquantidades => v_quantidades,
        pidpagamento => 1
    );
END;

BEGIN
    pk_gestao_venda.pr_atualiza_estoque(3, 10, 'Adicao');
END;

BEGIN
    pk_gestao_venda.pr_dados_pedido(pidpedido => 10);
END;

ALTER SESSION SET nls_date_format = 'DD/MM/YYYY HH24:MI:SS';
