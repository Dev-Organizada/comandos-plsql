CREATE OR REPLACE PACKAGE BODY product_package AS

    -- Criando a função que retorna um REF CURSOR que aponta para os objetos da tabela object_products
    FUNCTION get_products RETURN t_ref_cursor IS
        -- Declara um objeto t_ref_cursor
        v_products_ref_cursor t_ref_cursor;
        begin
            -- Obtem o REF CURSOR
            open v_products_ref_cursor FOR
                SELECT value(op) FROM object_products op ORDER BY op.id;
                
                -- Retorna o REF CURSOR
                return v_products_ref_cursor;
        end get_products;
        
         -- Exibe os atributos de um único objeto da tabela object_products
        PROCEDURE display_product(p_id IN object_products.id%TYPE) AS
            -- Declara um objeto t_product chamado v_product
            v_product t_product;
            begin
                -- Tenta obter o produto e armazena-lo em v_product
                SELECT value(op) INTO v_product FROM object_products op where op.id = p_id;
                
                -- Exibe os atributos de v_product
                dbms_output.put_line('Id: '||v_product.id);
                dbms_output.put_line('Nme: '||v_product.name);
                dbms_output.put_line('Description: '||v_product.description);
                dbms_output.put_line('Price: '||v_product.price);
                dbms_output.put_line('Days Valid: '||v_product.days_valid);
                
                -- Chama a função para exibe o prazo de validade
                dbms_output.put_line('Sell by date: '||v_product.get_sell_by_date());
            end display_product;
            
        -- Adiciona objetos na tabela object_products
        PROCEDURE insert_product(
            p_id            IN object_products.id%TYPE,
            p_name          IN object_products.name%TYPE,
            p_description   IN object_products.description%TYPE,
            p_price         IN object_products.price%TYPE,
            p_days_valid    IN object_products.days_valid%TYPE) AS
            
            -- Cria um objeto t_product chamado v_product
            v_product t_product := t_product(p_id, p_name, p_description, p_price, p_days_valid);
            begin
                -- Insere v_product na tabela object_products
                INSERT INTO object_products VALUES (v_product);
                commit;
                EXCEPTION WHEN OTHERS THEN
                    rollback;
            end insert_product;
            
       -- Atualiza o atributo preço de um objeto
        PROCEDURE update_product_price(
            p_id     IN object_products.id%TYPE,
            p_factor IN NUMBER) AS
            
            -- Cria um objeto t_product chamado v_product
            v_product t_product;
            begin
                -- Tenta obter o produto e armazena-lo em v_product
                SELECT value(op) INTO v_product FROM object_products op where op.id = p_id FOR UPDATE;
                
                -- Exibe o preço atual do produto
                dbms_output.put_line('Current Price: '||v_product.price);
                
                -- Multiplica price por p_factor
                v_product.price := v_product.price * p_factor;
                dbms_output.put_line('New Price: '||v_product.price);
                
                -- Atualiza o produto na tabela object_product
                UPDATE object_products op SET op = v_product WHERE id = p_id;
                commit;
                EXCEPTION WHEN OTHERS THEN
                    rollback;
            end update_product_price;
        
        --Retorna um unico objeto da tabela 
        FUNCTION get_product(p_id IN object_products.id%TYPE) RETURN t_product IS
            -- Cria um objeto t_product chamado v_product
            v_product t_product;
            begin
                -- Obtem o produto e armazena-lo em v_product
                SELECT value(op) INTO v_product FROM object_products op where op.id = p_id;
                
                -- Retorna v_product
                return v_product;
            end get_product;
            
        -- Atualiza todos os atributos de um objeto
        PROCEDURE update_product(p_product t_product) AS
            begin
                -- Atualiza o produto na tabela object_products
                UPDATE object_products op SET op = p_product WHERE id = p_product.id; 
                commit;
                EXCEPTION WHEN OTHERS THEN
                    rollback;
            end update_product;
            
        -- Retorna uma referencia para um unico objeto
        FUNCTION get_product_ref( p_id IN object_products.id%TYPE) RETURN REF t_product IS
            -- Declara uma referencia para um t_product
            v_product_ref REF t_product;
            begin
                -- Obtem a REF do produto e armazena em v_product_ref
                SELECT ref(op) into v_product_ref FROM object_products op WHERE op.id = p_id;
                
                -- Retorna v_product_ref
                return v_product_ref;
            end get_product_ref;
            
        -- Exclui um unico objeto da tabela
        PROCEDURE delete_product(p_id IN object_products.id%TYPE) AS
        begin
            -- Exclui o produto
            delete from object_products op where op.id = p_id;
            commit;
                EXCEPTION WHEN OTHERS THEN
                    rollback;
        end delete_product;

END product_package;


