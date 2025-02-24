CREATE OR REPLACE TYPE t_cliente AS OBJECT (
        nome        VARCHAR2(100),
        telefone    NUMBER,
        email       VARCHAR2(50),
        data_nascimento   DATE,
        sexo        CHAR(1),
        cep         NUMBER,
        complemento VARCHAR2(50),
        numero      NUMBER
);
