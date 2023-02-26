--Criação de um objeto chamado t_product que será usado para representar produtos.
create type t_product as object(
    id          integer,
    name        varchar2(10),
    description varchar2(22),
    price       number(5,2),
    days_valid  integer,
    
    -- declara função membro get_sell_by_date()
    -- get_sell_by_date() retorna a data até a qual o produto deve ser vendido
    
    member function get_sell_by_date return date
);


-- Criação do corpo do objeto e do método get_sell_by_date
create type body t_product as
-- get_sell_by_date() retorna a data até a qual o produto deve ser vendido
member function get_sell_by_date return date is
    v_sell_by_date date;
    begin
        --Calcula a data de vencimento somando o atributo days_valid à data atual (sysdate)
        select days_valid + sysdate into v_sell_by_date from dual;
        
        --Retorna a data de vencimento
        return v_sell_by_date;
    end;
end;

------------------------- Objeto de Coluna ------------------------- 

-- Criação de um objeto de coluna -> Usa-se um objeto de coluna para definir uma coluna individual em uma tabela
create table products(
    product             t_product,
    quantity_in_stock   integer -- armazena a qtd de produtos atualmente em estoque
);


--Inserindo dados na tabela
insert into products(product,quantity_in_stock) values (t_product(1,'Pasta','20 Oz Bag of Pasta',3.95,10), -- utilização do construtor do metodo, recebendo 5 parametros para definir os atributos
        25);
insert into products(product,quantity_in_stock) values (t_product(2,'Sardines','20 Oz box of Sardines',2.99,5),50);

commit;


--Consulta para recuperar as linhas inseridas
select * from products;

-- Recuperando objetos individuais de uma tabela
select p.product from products p where p.product.id = 1;

--Especificando os atributos
select p.product.id, p.product.name, p.product.description, p.product.price, p.product.days_valid, p.quantity_in_stock from products p where p.product.id = 1;

--Utilizando o método criado
select p.product.name, p.product.get_sell_by_date() expiration_date from products p;


-- Atualizando a descrição do produto 1
update products p set p.product.description = '30 Oz Bag of Pasta' where p.product.id = 1;

-- Deletando o produto 2
delete from products p where p.product.id = 2;

rollback;

------------------------- Objeto de Tabela ------------------------- 
-- Criação de um objeto de tabela -> Usa-se um objeto de tabela para definir uma linha inteira de uma tabela como objeto.
-- Criando uma tabela de objetos para armazenar os objetos do tipo t_product. Usa o OF para identificar como uma tabela de objetos do tipo t_product.
create table object_products of t_product;

--1º forma de inserir dados: Usando o construtor
insert into object_products values (t_product(1,'Pasta','20 Oz Bag of Pasta',3.95,10));

--2º forma de inserir dados: Informando as colunas
insert into object_products(id, name, description, price, days_valid) values (2,'Sardines','20 Oz box of Sardines',2.99,5);

commit;

select * from object_products;

-- Utilizando o Value -> Trata a linha como um objeto real e retorna os atributos do objeto dentro de um construtor para o tipo de objeto.
-- Aceita como parametro o apelido da tabela
select value(op) from object_products op;

-- Pode adicionar um atributo de objeto após o Value
select value(op).name, value(op).price from object_products op;