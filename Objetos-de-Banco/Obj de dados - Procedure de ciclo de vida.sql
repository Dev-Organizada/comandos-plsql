------ Criando a procedure

CREATE OR REPLACE PROCEDURE product_lifecycle AS
          v_product t_product;
      BEGIN
          -- Insere novo produto
          product_package.insert_product(4, 'Beef', '25 lb pack of beef', 32, 10);
          
          -- Exibe o produto
          product_package.display_product(4);
          
          -- Obtem novo produto e o armazena em v_product
          SELECT product_package.get_product(4) INTO v_product FROM dual;
          
          -- Altera alguns atributos
          v_product.description := '20 lb pack of beef';
          v_product.price := 36;
          v_product.days_valid := 8;
          
          -- Atualiza o produto
          product_package.update_product(v_product);
          
           -- Exibe o produto
          product_package.display_product(4);
          
          -- Exclui o produto
          product_package.delete_product(4);
          
      END product_lifecycle;
      
------- Chamando a procedure
CALL product_lifecycle();
