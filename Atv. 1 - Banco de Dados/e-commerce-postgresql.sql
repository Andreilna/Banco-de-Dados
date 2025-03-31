CREATE TABLE Clientes (
    idCliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    dataCadastro DATE NOT NULL
);

CREATE TABLE Produtos (
    idProduto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50) NOT NULL
);

CREATE TABLE Pedidos (
    idPedido SERIAL PRIMARY KEY,
    ClienteID INT NOT NULL,
    DataPedido DATE NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(idCliente) ON DELETE CASCADE
);

CREATE TABLE ItensPedido (
    PedidoID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (PedidoID, ProdutoID),
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(idPedido) ON DELETE CASCADE,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(idProduto) ON DELETE CASCADE
);

INSERT INTO Clientes (nome, email, dataCadastro) VALUES
('João Silva', 'joao.silva@email.com', '2024-01-15'),
('Maria Oliveira', 'maria.oliveira@email.com', '2024-02-20'),
('Carlos Souza', 'carlos.souza@email.com', '2024-03-25'),
('Ana Costa', 'ana.costa@email.com', '2024-04-10'),
('Pedro Santos', 'pedro.santos@email.com', '2024-05-05');

INSERT INTO Produtos (nome, preco, categoria) VALUES
('Notebook', 3500.00, 'Eletronicos'),
('Smartphone', 2000.00, 'Eletronicos'),
('Geladeira', 2500.00, 'Eletrodomestico'),
('Fogão', 1500.00, 'Eletrodomestico'),
('Micro-ondas', 800.00, 'Eletrodomestico');

INSERT INTO Pedidos (ClienteID, DataPedido) VALUES
(1, '2024-06-15'),
(2, '2024-07-20'),
(3, '2024-08-25'),
(4, '2024-09-10'),
(5, '2024-10-05');

INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade, PrecoUnitario) VALUES
(1, 1, 1, 3500.00),
(1, 2, 2, 2000.00),
(2, 3, 1, 2500.00),
(3, 4, 1, 1500.00),
(3, 5, 1, 800.00),
(4, 1, 1, 3500.00),
(5, 2, 1, 2000.00),
(5, 3, 1, 2500.00);

SELECT nome, email FROM Clientes;
SELECT nome FROM Produtos WHERE categoria = 'Eletronicos';
SELECT idPedido, ClienteID, DataPedido FROM Pedidos ORDER BY DataPedido DESC;
SELECT SUM(Quantidade * PrecoUnitario) AS TotalPedido FROM ItensPedido WHERE PedidoID = 1;
SELECT ClienteID, COUNT(*) AS NumeroDePedidos FROM Pedidos GROUP BY ClienteID;
SELECT ClienteID FROM Pedidos GROUP BY ClienteID;
