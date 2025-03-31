create database competicaoTriathlon;

use competicaoTriathlon;

create table atletas (
    idAtleta int auto_increment primary key,
    nome varchar(100) not null,
    dataNascimento date not null,
    pais varchar(50) not null
);

create table competicoes (
    idCompeticao int auto_increment primary key,
    nome varchar(100) not null,
    data date not null,
    local varchar(100) not null
);

create table resultados (
    idResultado int auto_increment primary key,
    atletaId int not null,
    competicaoId int not null,
    tempo time not null,
    posicao int not null,
    foreign key (atletaId) references atletas(idAtleta),
    foreign key (competicaoId) references competicoes(idCompeticao)
);

insert into atletas (nome, dataNascimento, pais) values
('joão silva', '1990-05-15', 'brasil'),
('maria oliveira', '1988-08-22', 'portugal'),
('carlos souza', '1992-03-10', 'brasil'),
('pedro santos', '1985-12-05', 'argentina');

insert into competicoes (nome, data, local) values
('triathlon rio 2025', '2025-01-15', 'rio de janeiro'),
('triathlon lisboa 2025', '2025-02-20', 'lisboa'),
('triathlon madri 2025', '2025-03-25', 'madri');

insert into resultados (atletaId, competicaoId, tempo, posicao) values
(1, 1, '02:15:30', 1),
(2, 1, '02:20:45', 2),
(3, 1, '02:25:50', 3),
(4, 2, '02:30:00', 1),
(1, 3, '02:40:20', 1),
(2, 3, '02:45:25', 2),
(3, 3, '02:50:30', 3);

select nome, pais from atletas;

select nome from atletas where pais = 'brasil';

select (select nome from atletas where idAtleta = resultados.atletaId) as nome, tempo, posicao from resultados where competicaoId = 1 order by posicao;

select sec_to_time(avg(time_to_sec(tempo))) as mediaTempo from resultados where competicaoId = 2;

select a.nome, count(r.idResultado) as numeroDeCompeticoes 
from atletas a
left join resultados r on a.idAtleta = r.atletaId
group by a.idAtleta;

select a.nome
from atletas a
join resultados r on a.idAtleta = r.atletaId
group by a.idAtleta
having count(r.idResultado) > 1;