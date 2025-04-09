# Aplicação de Algebra Relacional
 
create database tech_e_cafe;
use tech_e_cafe;
 
#Aplicando Select Where Order By
 
create table clientes(
	id_cliente int auto_increment primary key,
	nome varchar(100),
	cidade varchar(50),
	idade int
);
 
insert into clientes (nome, cidade, idade) values
("Ana","São Paulo",25),
("João","Rio de Janeiro",30),
("Carlos","São Paulo",35),
("Mariana","Belo Horizonte",28),
("Beatriz","Curitiba",41);

# Quais os clientes são de São Paulo
select * from clientes where cidade = "São Paulo";

# Quais os clientes que tem mais de 30 anos?
select * from clientes where idade > 30;

# Gerar uma lista ordenada em ordem alfabética
select * from clientes order by nome asc;
select * from clientes order by nome desc;
select * from clientes order by nome; # O uso do ASC é opcional para ordem ascendente

create table Pedidos(
	id_pedido int auto_increment primary key,
    id_cliente int,
    valor decimal(10, 2),
    data_pedido date,
    constraint fk_idClientes_pedidos foreign key(id_cliente) references clientes(id_cliente)
);

insert into Pedidos(id_cliente, valor, data_pedido) values
# (1,100.00,"2024-04-01"),
(2,200.00,"2024-04-02"),
(1,300.00,"2024-04-03"),
(3,150.00,"2024-04-05");

# Aplicar Relacionamentos Join e Filtros

# Mostrar o nome do cliente com valor e data do pedido
select pedidos.id_cliente, clientes.nome, valor from pedidos
join clientes on pedidos.id_cliente = clientes.id_cliente;

# date_format(pedidos.data_pedido, '%d/%m/%Y') as data_pedido      Formatar data no farmato do Brasil

# Mostrar pedidos entre 01 e 03 de abril
select clientes.nome from pedidos where data_pedido between '2024-04-01' and '2024-04-03';

# Clientes que fizeram pedidos entre 01 e 03 de abril mostrando o nome do cliente
select pedidos.id_cliente, clientes.nome, valor, data_pedido from pedidos
join clientes on pedidos.id_cliente = clientes.id_cliente
where data_pedido between '2024-04-01' and '2024-04-03';

# Nome dos clientes que fizeram pedidos
select distinct clientes.nome from pedidos
join clientes on pedidos.id_cliente = clientes.id_cliente;

# Aplicar Agregações (Count, Sum, AVG) Group By e Having

# Contar o número de pedidos feitos pelos cleintes retornando os nomes dos clientes
select c.nome, count(p.id_pedido) as "Total de Pedido" from  Pedidos p 
join clientes c on p.id_cliente = c.id_cliente
group by c.nome order by count(p.id_pedido) asc; 

# Qual o nome do cliente que fizeram mais que 1 pedido?
select c.nome, count(p.id_pedido) as "Total de Pedidos" from pedidos p
join clientes c on p.id_cliente = c.id_cliente
group by c.nome having count(p.id_pedido) > 1;

# Qual o nome do cliente que fez mais pedidos?
select c.nome, count(p.id_pedido) as "Total de Pedidos" from pedidos p
join clientes c on p.id_cliente = c.id_cliente
group by c.nome order by "Total de Pedidos" desc limit 1;

# Qual o valor médio dos pedidos
select avg(valor) as "Valor Médio" from pedidos;

drop database tech_e_cafe;