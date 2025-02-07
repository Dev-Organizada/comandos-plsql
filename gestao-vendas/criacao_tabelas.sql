-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2025-01-22 19:52:19 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE categoria 
    ( 
     id_categoria NUMBER  NOT NULL , 
     nome         VARCHAR2 (100) 
    ) 
;

ALTER TABLE categoria 
    ADD CONSTRAINT categoria_PK PRIMARY KEY ( id_categoria ) ;

CREATE TABLE cidade 
    ( 
     id_cidade NUMBER  NOT NULL , 
     nome      VARCHAR2 (50) , 
     estado    VARCHAR2 (30) 
    ) 
;

ALTER TABLE cidade 
    ADD CONSTRAINT cidade_PK PRIMARY KEY ( id_cidade ) ;

CREATE TABLE cliente 
    ( 
     id_cliente      NUMBER  NOT NULL , 
     nome            VARCHAR2 (100)  NOT NULL , 
     telefone        NUMBER (15) , 
     email           VARCHAR2 (50) , 
     data_nascimento DATE , 
     sexo            VARCHAR2 (1)  NOT NULL , 
     id_endereco     NUMBER  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX cliente__IDX ON cliente 
    ( 
     id_cliente ASC 
    ) 
;

ALTER TABLE cliente 
    ADD CONSTRAINT cliente_PK PRIMARY KEY ( id_cliente ) ;

CREATE TABLE endereco 
    ( 
     id_endereco NUMBER  NOT NULL , 
     cep         NUMBER (12)  NOT NULL , 
     rua         VARCHAR2 (50)  NOT NULL , 
     numero      NUMBER , 
     bairro      VARCHAR2 (50)  NOT NULL , 
     id_cidade   NUMBER  NOT NULL 
    ) 
;

ALTER TABLE endereco 
    ADD CONSTRAINT endereco_PK PRIMARY KEY ( id_endereco ) ;

CREATE TABLE estoque 
    ( 
     id_estoque         NUMBER  NOT NULL , 
     id_produto         NUMBER  NOT NULL , 
     quantidade         NUMBER  NOT NULL , 
     valor_unitario     NUMBER (10,2)  NOT NULL , 
     data_cadastro      DATE  NOT NULL , 
     ultima_atualizacao DATE  NOT NULL 
    ) 
;

ALTER TABLE estoque 
    ADD CONSTRAINT estoque_PK PRIMARY KEY ( id_estoque ) ;

CREATE TABLE forma_pagamento 
    ( 
     id_pagamento NUMBER  NOT NULL , 
     descricao    VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE forma_pagamento 
    ADD CONSTRAINT forma_pagamento_PK PRIMARY KEY ( id_pagamento ) ;

CREATE TABLE pedido 
    ( 
     id_pedido    NUMBER  NOT NULL , 
     id_cliente   NUMBER  NOT NULL , 
     data_pedido  DATE  NOT NULL , 
     valor_total  NUMBER (10,2)  NOT NULL , 
     id_pagamento NUMBER  NOT NULL 
    ) 
;

ALTER TABLE pedido 
    ADD CONSTRAINT pedido_PK PRIMARY KEY ( id_pedido ) ;

CREATE TABLE pedido_item 
    ( 
     id_pedido  NUMBER  NOT NULL , 
     id_produto NUMBER  NOT NULL , 
     quantidade NUMBER  NOT NULL 
    ) 
;

ALTER TABLE pedido_item 
    ADD CONSTRAINT pedido_item_PK PRIMARY KEY ( id_pedido, id_produto ) ;

CREATE TABLE produto 
    ( 
     id_produto    NUMBER  NOT NULL , 
     nome          VARCHAR2 (100)  NOT NULL , 
     descricao     VARCHAR2 (250)  NOT NULL , 
     id_categoria  NUMBER  NOT NULL , 
     data_cadastro DATE  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX produto__IDX ON produto 
    ( 
     id_produto ASC 
    ) 
;

ALTER TABLE produto 
    ADD CONSTRAINT produto_PK PRIMARY KEY ( id_produto ) ;

ALTER TABLE cliente 
    ADD CONSTRAINT cliente_endereco_FK FOREIGN KEY 
    ( 
     id_endereco
    ) 
    REFERENCES endereco 
    ( 
     id_endereco
    ) 
;

ALTER TABLE endereco 
    ADD CONSTRAINT endereco_cidade_FK FOREIGN KEY 
    ( 
     id_cidade
    ) 
    REFERENCES cidade 
    ( 
     id_cidade
    ) 
;

ALTER TABLE estoque 
    ADD CONSTRAINT estoque_produto_FK FOREIGN KEY 
    ( 
     id_produto
    ) 
    REFERENCES produto 
    ( 
     id_produto
    ) 
;

ALTER TABLE pedido 
    ADD CONSTRAINT pedido_cliente_FK FOREIGN KEY 
    ( 
     id_cliente
    ) 
    REFERENCES cliente 
    ( 
     id_cliente
    ) 
;

ALTER TABLE pedido 
    ADD CONSTRAINT pedido_forma_pagamento_FK FOREIGN KEY 
    ( 
     id_pagamento
    ) 
    REFERENCES forma_pagamento 
    ( 
     id_pagamento
    ) 
;

ALTER TABLE pedido_item 
    ADD CONSTRAINT pedido_item_pedido_FK FOREIGN KEY 
    ( 
     id_pedido
    ) 
    REFERENCES pedido 
    ( 
     id_pedido
    ) 
;

ALTER TABLE pedido_item 
    ADD CONSTRAINT pedido_item_produto_FK FOREIGN KEY 
    ( 
     id_produto
    ) 
    REFERENCES produto 
    ( 
     id_produto
    ) 
;

ALTER TABLE produto 
    ADD CONSTRAINT produto_categoria_FK FOREIGN KEY 
    ( 
     id_categoria
    ) 
    REFERENCES categoria 
    ( 
     id_categoria
    ) 
;
