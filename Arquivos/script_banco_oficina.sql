/* Criação das tabelas e Relacionamentos*/
show databases;
create database Oficina;

use oficina;

Create table Cliente(
	idcliente int not null unique auto_increment,
    Pnome Varchar(20) not null,
    Sobrenome Varchar(20) not null,
    rg char(9) not null unique,
    celular char(13) not null,
    telefone char(12),
    primary key (idcliente)
);

desc Cliente;

Create table Equipe(
	id_equipe int not null,
    primary key (id_equipe)
);

create table Mecanico(
	id_mecanico int not null unique auto_increment,
    Pnome varchar(20) not null,
    Sobrenome varchar(20) not null,
    Especialidade varchar(40) not null,
    celular char(13) not null,
    salario float not null,
    id_equipe int,
    primary key (id_mecanico),
    foreign key (id_equipe) references Equipe(id_equipe) on update cascade
);

create table veiculo(
	Placa_veiculo char(7) not null unique,
    tipo_veiculo Enum('Carro','Moto') not null,
    modelo varchar(40) not null,
    id_proprietario int not null,
    id_equipe_resp int,
    primary key (Placa_veiculo),
    foreign key (id_proprietario) references Cliente(idcliente),
    foreign key (id_equipe_resp) references Equipe(id_equipe)
);

create table OS(
	id_OS int not null unique auto_increment,
    data_emissao date not null,
    status_os enum('Emitida', 'Aguardando Cliente', 'Aprovada', 'Em Execução', 'Concluída') default 'Emitida',
    Data_conclusão date,
    id_equipe_resp int not null,
    primary key (id_OS),
    foreign key (id_equipe_resp) references equipe(id_equipe)
);

create table Servicos(
	id_servico int not null unique auto_increment,
    nome_servico varchar(50) not null,
    descricao varchar(200) not null,
    valor float not null,
    primary key (id_servico)
);

create table Servicos_prestados(
	id_servico int not null,
    id_OS int not null,
    primary key (id_servico, id_OS),
    foreign key (id_servico) references servicos(id_servico),
    foreign key (id_OS) references OS(id_OS)
);

drop table Servicos_prestados;

create table pecas(
	id_peca int not null unique auto_increment,
    nome_peca varchar(40) not null,
    valor float not null,
    qtd int not null default 0,
    primary key (id_peca)
);

create table pecas_utilizadas(
	id_peca int not null,
    id_OS int not null,
    qtd_peca int not null default 1,
    primary key (id_peca, id_OS),
    foreign key (id_peca) references pecas(id_peca) on update cascade,
    foreign key (id_OS) references OS(id_OS)
);

/*inserção de instancias para realização de queries (gpt utilizado para gerar as inserções)*/

INSERT INTO Cliente (Pnome, Sobrenome, rg, celular, telefone)
VALUES 
('Carlos', 'Silva', '123456789', '(11)999999999', '(11)33224455'),
('Mariana', 'Oliveira', '987654321', '(11)988888888', '(11)44556677'),
('João', 'Pereira', '456123789', '(11)977777777', NULL),
('Ana', 'Costa', '741852963', '(21)966666666', '(21)32323232'),
('Pedro', 'Lima', '852963741', '(31)955555555', '(31)31313131');

INSERT INTO Equipe (id_equipe)
VALUES (1), (2), (3);

INSERT INTO Mecanico (Pnome, Sobrenome, Especialidade, celular, salario, id_equipe)
VALUES
('Rafael', 'Souza', 'Motor', '(11)966666666', 3500.00, 1),
('Lucas', 'Almeida', 'Suspensão', '(11)955555555', 3200.00, 1),
('Bruno', 'Ferreira', 'Freios', '(11)944444444', 3100.00, 1),

('Paulo', 'Santos', 'Elétrica', '(21)933333333', 3000.00, 2),
('André', 'Carvalho', 'Pintura', '(21)922222222', 2900.00, 2),

('Felipe', 'Martins', 'Transmissão', '(31)911111111', 3200.00, 3),
('Ricardo', 'Barbosa', 'Motor', '(31)900000000', 3500.00, 3),
('Marcelo', 'Vieira', 'Ar-condicionado', '(31)988888888', 3000.00, 3),
('Diego', 'Fonseca', 'Suspensão', '(31)977777777', 3100.00, 3);

INSERT INTO veiculo (Placa_veiculo, tipo_veiculo, modelo, id_proprietario, id_equipe_resp)
VALUES
('ABC1234', 'Carro', 'Honda Civic', 1, 1),
('XYZ9876', 'Moto', 'Yamaha MT-07', 2, 1),
('JKL4567', 'Carro', 'Toyota Corolla', 3, 2),
('MNO3210', 'Carro', 'Fiat Uno', 4, 3),
('QWE6543', 'Moto', 'Honda CG 160', 5, 3);

INSERT INTO veiculo (Placa_veiculo, tipo_veiculo, modelo, id_proprietario, id_equipe_resp)
VALUES ('AXP4853', 'Carro', 'Chevrolet Onix', 1, 2);

INSERT INTO OS (data_emissao, status_os, Data_conclusão, id_equipe_resp)
VALUES
('2025-08-01', 'Aprovada', NULL, 1),
('2025-08-03', 'Em Execução', NULL, 1),
('2025-08-05', 'Concluída', '2025-08-10', 2),
('2025-08-07', 'Emitida', NULL, 3),
('2025-08-08', 'Aguardando Cliente', NULL, 3);

INSERT INTO Servicos (nome_servico, descricao, valor)
VALUES
('Troca de Óleo', 'Troca do óleo do motor e filtro', 120.00),
('Alinhamento', 'Alinhamento e balanceamento das rodas', 200.00),
('Troca de Bateria', 'Substituição da bateria por nova', 450.00),
('Pintura Parcial', 'Retoque e pintura de para-lamas', 600.00),
('Revisão Completa', 'Verificação geral e manutenção preventiva', 800.00);

INSERT INTO Servicos_prestados (id_servico, id_OS)
VALUES
(1, 1), (2, 2), (3, 3), (1, 3),
(4, 4), (5, 5);

INSERT INTO pecas (nome_peca, valor, qtd)
VALUES
('Filtro de Óleo', 30.00, 10),
('Bateria 60Ah', 400.00, 5),
('Par de Pneus', 800.00, 4),
('Tinta Automotiva', 150.00, 3),
('Correia Dentada', 200.00, 6);

INSERT INTO pecas_utilizadas (id_peca, id_OS, qtd_peca)
VALUES
(1, 1, 1),
(2, 3, 1),
(3, 2, 2),
(4, 4, 1),
(5, 5, 1);

/*realização de queries teste

Querie 1: o total dos salários de cada equipe de mecanicos*/

Select E.id_equipe, count(*) as numero_membros, sum(salario) as salario_total from Mecanico M
	inner join Equipe E on E.id_equipe = M.id_equipe
    group by E.id_equipe
    order by salario_total;
    
/*Querie 2: quantas OS estão em execução*/

INSERT INTO OS (data_emissao, status_os, Data_conclusão, id_equipe_resp)
VALUES
('2025-09-13', 'Em execução', NULL, 2);

INSERT INTO Servicos_prestados (id_servico, id_OS)
VALUES
(1, 6),
(2, 6);

INSERT INTO pecas_utilizadas (id_peca, id_OS, qtd_peca)
VALUES
(1, 6, 1),
(3, 6, 2);

Select data_emissao, id_equipe_resp from  OS
	where status_os = 'Em execução';
    
/*percebi que não era possivel saber qual carro tava relacionado a OS, então vou fazer uma modificação na tabela para isso*/

Alter table OS drop Placa_veiculo;
desc veiculo;
Alter table OS add placa_veiculo char(7);
Alter table OS add foreign key (placa_veiculo) references veiculo(Placa_veiculo);

select * from OS;

Update OS set placa_veiculo =
	case when id_OS = 1 then 'ABC1234'
		 when id_OS = 2 then 'XYZ9876'
         when id_OS = 3 then 'JKL4567'
         when id_OS = 4 then 'MNO3210'
         when id_OS = 5 then 'QWE6543'
         when id_OS = 6 then 'AXP4853'
         else placa_veiculo
         end;

select * from OS;

/*agora querie 3: ver o modelo dos carros relacionados a cada OS, mas apenas daquelas aguardando cliente ou em execução*/

select modelo, id_OS, status_os from OS os
	inner join veiculo v on v.placa_veiculo = os.placa_veiculo
    where status_os = 'Em Execução' or status_os = 'Aguardando Cliente'
    order by os.data_emissao desc;
    
/*querie 4: a soma dos serviços prestados em cada OS*/

select o.id_OS, sum(valor) as total from OS o
	inner join servicos_prestados sp on o.id_OS = sp.id_OS
    inner join servicos s on s.id_servico = sp.id_servico
    group by sp.id_OS;

/*querie 5: agora a soma total das peças, com valores maiores que 300*/

select OS.id_OS, sum(p.valor * pu.qtd_peca) as valor_total_pecas from OS
	inner join pecas_utilizadas pu on pu.id_OS = OS.id_OS
    inner join pecas p on pu.id_peca = p.id_peca
    group by pu.id_OS
    having valor_total_pecas > 300;
    
/*querie 6: o valor total da OS, alem dos clientes relacionados a OS, selecionando os que tiveram um valor de serviço entre 1000 e 2000
os left join foram usados pensando em casos onde alguma das OS n tivessem usados ou peças ou serviços, mas não os dois
*/

Select concat(c.Pnome, ' ', c.Sobrenome) as nome_cliente, OS.id_OS, sum(s.valor) + sum(p.valor * pu.qtd_peca) as valor_total_os from OS
	left join pecas_utilizadas pu on pu.id_OS = OS.id_OS
    left join pecas p on pu.id_peca = p.id_peca
    Left join servicos_prestados sp on OS.id_OS = sp.id_OS
    Left join servicos s on s.id_servico = sp.id_servico
    inner join veiculo v on OS.placa_veiculo = v.placa_veiculo
    inner join cliente c on v.id_proprietario = idcliente		
    group by OS.id_OS
    having valor_total_OS between 1000 and 2000;