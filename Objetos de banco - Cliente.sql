-- Criando objeto para armazenar os dados do endereço
CREATE TYPE t_address AS OBJECT (
    street VARCHAR2(50),
    city   VARCHAR2(50),
    state  VARCHAR2(50),
    zip    NUMBER
);

-- Criando objeto para armazenar os dados dos clientes
CREATE TYPE t_person AS OBJECT(
    id          INTEGER,
    first_name  VARCHAR2(10),
    last_name   VARCHAR2(10),
    dob         DATE,
    phone       VARCHAR2(12),
    address     t_address
);

-- Crianção da tabela de objetos
CREATE TABLE objetc_custmers OF t_person;

-- 1º opção de insert
INSERT INTO objetc_custmers VALUES (t_person(1,'John','Brown','01/02/1955','800-555-1211',t_address('2 State Streer','Beantown','MA',12345)));

-- 2° opção de insert
INSERT INTO objetc_custmers (
    id,
    first_name,
    last_name,
    dob,
    phone,
    address
) VALUES (
    2,
    'Cynthia',
    'Green',
    '05/02/1968',
    '800-555-1212',
    t_address('3 Frre Street', 'Middle Town', 'CA', 12345)
);

COMMIT;

--------------------- Referencia de Objetos ---------------------
-- Cada objeto em uma tabela de objetos tem um Identificador De Objeto(OID) exclusivo que pode ser recuperado atraves da função REF().
SELECT REF(oc) FROM objetc_custmers oc where oc.id = 1;

-- Criação da tabela de compras onde irá armazenar os IOD do cliente e do produto
CREATE TABLE purcheses(
    id              INTEGER PRIMARY KEY,
    customer_ref    REF t_person SCOPE IS objetc_custmers, -- A cláusula SCOPE IS restringe uma referencia de ob a apontar para objetos de uma tabela especifica
    product_ref     REF t_product SCOPE IS object_products
);

-- Inserindo dados na tabela de compra. O cliente 1 comprou o produto 1
INSERT INTO purcheses (
    id,
    customer_ref,
    product_ref
) VALUES (
    1,
    (
        SELECT ref(oc) FROM objetc_custmers oc WHERE  oc.id = 1
    ),
    (
        SELECT ref(op) FROM object_products op WHERE op.id = 1
    )
);
COMMIT;

SELECT * FROM purcheses;

-- Recuperando os atributos usando o DEREF
SELECT deref(customer_ref).first_name name,deref(customer_ref).address.street street, deref(product_ref).name product FROM purcheses;