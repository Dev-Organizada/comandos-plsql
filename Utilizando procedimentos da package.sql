-- Testando a função get_products: retorna um REF CURSOR que aponta para os objetos da tabela object_products
SELECT product_package.get_products FROM dual;

-- Testando a procedure display_product: Exibe os atributos de um único objeto da tabela object_products
CALL product_package.display_product(1);

-- Testando a procedure insert_product
CALL product_package.insert_product(3,'Salsa','15 Oz Jar of Salsa',1.50,20);

-- Testando a procedure update_product_price: Atualiza o atributo preço de um objeto
CALL product_package.update_product_price(3, 2.4);

-- Testando a função get_product: Retorna um unico objeto da tabela
SELECT product_package.get_product(3) FROM dual;

-- Testando a procedure update_product: Atualiza todos os atributos de um objeto
CALL product_package.update_product(3,'Salsa','25 Oz Jar of Salsa',2.70,15);

-- Testando a função get_product_ref: Retorna uma referencia para um unico objeto
SELECT deref(product_package.get_product_ref(3)) FROM dual;

-- Testando a procedure delete_product
CALL product_package.delete_product(3);
