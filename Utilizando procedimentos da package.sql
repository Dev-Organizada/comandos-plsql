-- Testando a função get_products: retorna um REF CURSOR que aponta para os objetos da tabela object_products
SELECT product_package.get_products FROM dual;

-- Testando a procedure display_product: Exibe os atributos de um único objeto da tabela object_products
CALL product_package.display_product(1);

-- Testando a procedure insert_product
CALL product_package.insert_product(3, 'Salsa', '15 Oz Jar of Salsa', 1, 20);

-- Testando a procedure update_product_price: Atualiza o atributo preço de um objeto
CALL product_package.update_product_price(3, 2);

-- Testando a função get_product: Retorna um unico objeto da tabela
SELECT product_package.get_product(3) FROM dual;

-- Testando a procedure update_product: Atualiza todos os atributos de um objeto
CALL product_package.update_product(3,'Salsa','25 Oz Jar of Salsa',3,15); -- Erroooooo

-- Testando a função get_product_ref: Retorna uma referencia para um unico objeto
SELECT deref(product_package.get_product_ref(3)) FROM dual;

-- Especificando os campos da get_product_ref
SELECT 
    deref(product_package.get_product_ref(3)).id codigo,
    deref(product_package.get_product_ref(3)).name nome,
    deref(product_package.get_product_ref(3)).description descricao,
    deref(product_package.get_product_ref(3)).price preco,
    deref(product_package.get_product_ref(3)).days_valid dias_de_validade
  FROM dual;

-- Testando a procedure delete_product
CALL product_package.delete_product(3);
