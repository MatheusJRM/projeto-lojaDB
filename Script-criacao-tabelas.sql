CREATE TABLE Endereco (
    id SERIAL PRIMARY key UNIQUE,
    logradouro VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    numero VARCHAR NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    estado VARCHAR(255) NOT NULL,
    complemento VARCHAR(255),
    cep VARCHAR(8) NOT NULL
);

create table Tipos_Pessoa (id int primary key, Tipo_Pessoa VARCHAR(1));

CREATE TABLE Pessoa (
    id SERIAL PRIMARY key UNIQUE,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    id_endereco INTEGER,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id),
    id_tipo_pessoa int not null REFERENCES Tipos_pessoa(id),
    CONSTRAINT People_AltPK UNIQUE (id, id_tipo_pessoa)
);

CREATE TABLE Pessoa_Fisica (
	pessoa_id INTEGER primary key unique references pessoa(id),
	id_tipo_pessoa int GENERATED ALWAYS AS (1) STORED,
	cpf VARCHAR(11) NOT null UNIQUE,
	FOREIGN KEY (pessoa_id, id_tipo_pessoa) REFERENCES Pessoa(id, id_tipo_pessoa)
);

CREATE TABLE Pessoa_Juridica (
	pessoa_id INTEGER primary key unique references pessoa(id),
	id_tipo_pessoa int GENERATED ALWAYS AS (2) STORED,
	FOREIGN KEY (pessoa_id, id_tipo_pessoa) REFERENCES Pessoa(id, id_tipo_pessoa),
    cnpj VARCHAR(14) NOT null UNIQUE
);

CREATE TABLE Usuario (
    id SERIAL PRIMARY key UNIQUE,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(16) NOT NULL,
    dataCadastro timestamp NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE Produto (
    id SERIAL PRIMARY key UNIQUE,
    nome VARCHAR(255) NOT NULL,
    preco_venda NUMERIC NOT NULL,
    quantidade_estoque INTEGER NOT NULL
);

CREATE TABLE Movimentacao_Compra (
    id SERIAL PRIMARY KEY,
    id_pessoa_fisica INTEGER NOT NULL,
    id_usuario INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade_produto INTEGER NOT NULL,
    valor_unitario NUMERIC NOT NULL,
    FOREIGN KEY (id_pessoa_fisica) REFERENCES pessoa_fisica(pessoa_id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_produto) REFERENCES produto(id)
);

CREATE TABLE Movimentacao_Venda (
    id SERIAL PRIMARY KEY,
    id_pessoa_juridica INTEGER NOT NULL,
    id_usuario INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade_produto INTEGER NOT NULL,
    valor_unitario NUMERIC NOT NULL,
    FOREIGN KEY (id_pessoa_juridica) REFERENCES pessoa_juridica(pessoa_id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_produto) REFERENCES produto(id)
);