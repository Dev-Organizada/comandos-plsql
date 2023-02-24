CREATE PACKAGE product_package AS
    -- Criando um objeto do tipo cursor
    TYPE t_ref_cursor IS REF CURSOR;
    
    -- Criando a função que retorna um REF CURSOR que aponta para os objetos da tabela object_products
    FUNCTION get_products RETURN t_ref_cursor;
    
    -- Exibe os atributos de um único objeto da tabela object_products
    PROCEDURE display_product (
        p_id IN object_products.id%TYPE
    );
    
    -- Adiciona objetos na tabela object_products
    PROCEDURE insert_product(
        p_id            IN object_products.id%TYPE,
        p_name          IN object_products.name%TYPE,
        p_description   IN object_products.description%TYPE,
        p_price         IN object_products.price%TYPE,
        p_days_valid    IN object_products.days_valid%TYPE
    );
    
    -- Atualiza o atributo preço de um objeto
    PROCEDURE update_product_price(
        p_id     IN object_products.id%TYPE,
        p_factor IN NUMBER
    );
    
    --Retorna um unico objeto da tabela
    FUNCTION get_product(
        p_id     IN object_products.id%TYPE
    ) RETURN t_product;
    
    -- Atualiza todos os atributos de um objeto
    PROCEDURE update_product(
        p_product t_product
    );
    
    -- Retorna uma referencia para um unico objeto
    FUNCTION get_product_ref(
        p_id     IN object_products.id%TYPE
    )RETURN REF t_product;
    
    -- Exclui um unico objeto da tabela
    PROCEDURE delete_product(
        p_id     IN object_products.id%TYPE
    );
END product_package;