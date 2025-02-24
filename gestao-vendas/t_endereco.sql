CREATE OR REPLACE TYPE t_endereco AS OBJECT (
        cep       NUMBER,
        rua       VARCHAR2(50),
        bairro    VARCHAR2(50),
        id_cidade NUMBER
);
