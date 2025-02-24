CREATE OR REPLACE PACKAGE pk_gestao_venda AS
    TYPE t_ref_cursor IS REF CURSOR;
    PROCEDURE pr_registra_categoria (
        pnome IN categoria.nome%TYPE
    );

    PROCEDURE pr_registra_forma_pagamento (
        pdescricao IN forma_pagamento.descricao%TYPE
    );

    PROCEDURE pr_registra_cidade (
        pcidade IN cidade.nome%TYPE,
        pestado IN cidade.estado%TYPE
    );

    PROCEDURE pr_registra_endereco (
        pendereco IN t_endereco
    );

    FUNCTION f_busca_cep (
        pcep IN endereco.cep%TYPE
    ) RETURN t_ref_cursor;

    PROCEDURE pr_cadastra_cliente (
        pcliente IN t_cliente
    );

    PROCEDURE pr_cadastra_produto (
        pnome        IN produto.nome%TYPE,
        pdescricao   IN produto.descricao%TYPE,
        pidcategoria IN produto.id_categoria%TYPE
    );

    PROCEDURE pr_cadastra_estoque (
        pidproduto  IN estoque.id_produto%TYPE,
        pquantidade IN estoque.quantidade%TYPE,
        pvaloruni   IN estoque.valor_unitario%TYPE
    );

    PROCEDURE pr_atualiza_estoque (
        pidproduto  IN estoque.id_produto%TYPE,
        pquantidade IN estoque.quantidade%TYPE,
        pvaloruni   IN estoque.valor_unitario%TYPE,
        pacao       IN VARCHAR2
    );

    FUNCTION f_valor_total (
        pidproduto  IN estoque.id_produto%TYPE,
        pquantidade IN estoque.quantidade%TYPE
    ) RETURN NUMBER;

    PROCEDURE pr_gera_pedido (
        pidcliente   IN NUMBER,
        pidprodutos  IN sys.odcinumberlist,  -- array de códigos de produtos
        pquantidades IN sys.odcinumberlist,     -- array de quantidades
        pidpagamento IN forma_pagamento.id_pagamento%TYPE
    );

    PROCEDURE pr_dados_pedido (
        pidpedido pedido.id_pedido%TYPE
    );

END pk_gestao_venda;
