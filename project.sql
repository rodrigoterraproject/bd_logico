CREATE DATABASE ecommerce;
USE ecommerce;

-- Cliente
CREATE TABLE Cliente(
	idCliente INT auto_increment PRIMARY KEY,
    Nome VARCHAR(45),
    Endereço VARCHAR(45),
	CPF CHAR (11) NOT NULL,
    CNPJ VARCHAR(18),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF),
    CONSTRAINT unique_cnpj_cliente UNIQUE (CNPJ)
    );
DESC Cliente;


-- Produtos
CREATE TABLE Produto(
	idProduto INT auto_increment PRIMARY KEY,
    categoria VARCHAR(45),
    descrição VARCHAR(45),
	valor FLOAT
);
DESC Produto;


-- Pagamento
CREATE TABLE Pagamento(
	idPagamento INT auto_increment PRIMARY KEY,
    PagCliente INT,
    cartão VARCHAR(45),
    bandeira VARCHAR(45),
    numero VARCHAR(45),
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (PagCliente) REFERENCES Cliente(idCliente)
);
DESC Pagamento;

-- Entregas
CREATE TABLE Entrega(
	idEntrega INT auto_increment PRIMARY KEY,
    statusEntrega BOOL,
    codeRastreio VARCHAR(45),
    date_entrega DATE
);
DESC Entrega;

-- Pedidos
CREATE TABLE Pedido(
	idPedido INT auto_increment PRIMARY KEY,
    statusPedido BOOL DEFAULT FALSE,
    frete FLOAT,
    descrição VARCHAR(45),
    CONSTRAINT fk_entrega FOREIGN KEY (idPedido) REFERENCES Entrega(idEntrega)
);
DESC Pedido;

-- Estoque
CREATE TABLE Estoque(
	idEstoque INT auto_increment PRIMARY KEY,
    Local VARCHAR(45)
);
DESC Estoque;

-- Produtos em estoque
CREATE TABLE EstoquedeProdutos(
	idProduto INT PRIMARY KEY,
    idEstoquedeProdutos INT,
    Qntd FLOAT,
    CONSTRAINT fk_estoque FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_produto_estoque FOREIGN KEY (idEstoquedeProdutos) REFERENCES Estoque(idEstoque)
);
DESC EstoquedeProdutos;

--  1°Fornecedor
CREATE TABLE Fornecedor(
	idFornecedor INT auto_increment PRIMARY KEY,
    RazãoSocial VARCHAR(45),
    CPF CHAR (11) NOT NULL,
    CNPJ VARCHAR(18),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF),
    CONSTRAINT unique_cnpj_cliente UNIQUE (CNPJ)
);
DESC Fornecedor;

--  Terceiro Fornecedor
CREATE TABLE terceiro_forne(
	idTerceiro INT auto_increment PRIMARY KEY,
	RazãoSocial VARCHAR(45),
    Localização VARCHAR(45),
    CPF CHAR (11) NOT NULL,
    CNPJ VARCHAR(18),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF),
    CONSTRAINT unique_cnpj_cliente UNIQUE (CNPJ)
);
DESC terceiro_forne;

-- Pedidos de produtos
CREATE TABLE PedidoProduto(
	idPedido INT,
    idProduto INT,
    Qntd FLOAT DEFAULT 1,
    CONSTRAINT fk_pedido FOREIGN KEY (idPedido) REFERENCES terceiro_forne(idTerceiro),
    CONSTRAINT fk_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);
DESC PedidoProduto;

-- Pedidos produtos fornecedor principal
CREATE TABLE PedidoForne(
	idCompraForne INT,
    idPedidoForne INT,
    Qntd FLOAT DEFAULT 1,
    CONSTRAINT fk_pedido_forncedor FOREIGN KEY (idCompraForne) REFERENCES Fornecedor(idFornecedor),
    CONSTRAINT fk_fornecedor_pedido FOREIGN KEY (idPedidoForne) REFERENCES Pedido(idPedido)
);
DESC PedidoForne;

-- produtos em estoque do fornecedor princpal (verifica se tem os produtos em estoque)
CREATE TABLE Estoque_Forne(
	idEstoque_Forne INT,
    idProdutoForne INT,
    CONSTRAINT fk_estoque_forne FOREIGN KEY (idEstoque_Forne) REFERENCES Fornecedor(idFornecedor),
    CONSTRAINT fk_produtos_forne FOREIGN KEY (idProdutoForne) REFERENCES Produto(idProduto)
);
DESC Estoque_Forne;


-- Produtos em estoque do terceiro fornecedor (verifca se o fornecedor tem o produto em estoque)
CREATE TABLE EstoquedeTerceiros(
	idProdutosemEstoque INT,
    id_do_forne INT,
    CONSTRAINT fk_produtos_estoque FOREIGN KEY (idProdutosemEstoque) REFERENCES Produto(idProduto),
    CONSTRAINT fk_po_fornecedor FOREIGN KEY (id_do_forne) REFERENCES terceiro_forne(idTerceiro)
);
DESC EstoquedeTerceiros;
