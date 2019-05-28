create database	pedido_compra
go

use pedido_compra
go

create table cliente 
	   (id_clie			int			not null primary key,
		nm_clie			varchar(60)	not null,
		doc_clie		varchar(15) not null,
		dtnas_clie		date);
go

create table pagamento 
		(id_pgto		int	not null	primary key,
		 dsc_pgto		varchar(30));
go

create table produto	
		(id_prod		int	not null	primary key,
		 dsc_prod		varchar(40) not null,
		 vl_prod		numeric(9,2));
go

create table pedido	
		(id_ped			int	not null primary key,
		 id_pgto		int	not null foreign key references pagamento(id_pgto),
		 id_clie		int not null foreign key references cliente(id_clie),
		 dt_ped			date,
		 tot_ped		numeric(10,2));
go

create table item_pedido 
		(id_ped			int not null foreign key references pedido(id_ped),
		 id_prod		int not null foreign key references produto(id_prod),
		 qtd_item_ped	numeric(7,2),
		 vl_item_ped	numeric(9,2));
go


INSERT INTO cliente VALUES 	
		(1,'Maria do Bairro','55276422000186','2018-05-01'),
		(2,'Escrava Izalra','85476237000104','2018-05-01'),
		(3,'Ezabel','96130380000158','2018-05-01'),
		(4,'Chico Javier','80463974000140','2018-05-01'),
		(5,'Nabucodonosor','86715663000108','2018-05-01');
go

INSERT INTO pagamento VALUES 
		(1,'Parcelado'),
		(2,'Cheque'),
		(3,'A vista');
go

INSERT INTO produto VALUES	
		(1,'Vassoura(Veiculo de Transporte)',10.50),
		(2,'Papel Higienico',15.00),
		(3,'Glade Lavanda',7.20),
		(4,'Omega 3',19.75),
		(5,'Omeprazol',20.00),
		(6,'Creme Dental',5.00),
		(7,'Escova de Dente',10.50),
		(8,'Arroz Prato Grosso',15.50),
		(9,'Tapoé',17.45),
		(10,'Salgadin',5.30);
go
		
INSERT INTO pedido VALUES	
		(1,1,1,'2019-01-01',0.00),
		(2,1,2,'2019-03-02',0.00),
		(3,2,3,'2019-03-10',0.00),
		(4,2,4,'2019-04-12',0.00),
		(5,3,5,'2019-04-16',0.00),
		(6,3,1,'2019-05-17',0.00),
		(7,2,2,'2019-05-22',0.00),
		(8,1,3,'2019-05-27',0.00);
go

INSERT INTO item_pedido VALUES	
		(1,3,1,7.20),
		(1,5,1,20.00),
		(1,6,1,5.00),
		(2,3,2,14.40),
		(2,5,1,20.00),
		(2,6,2,10.00),
		(3,3,5,36.00),
		(3,5,5,100.00),
		(3,6,5,25.00),
		(4,10,11,58.30),
		(4,9,12,209.40),
		(4,8,10,155.00),
		(5,2,3,45.00),
		(5,1,4,42.00),
		(5,6,6,30.00),
		(6,1,7,73.50),
		(6,8,8,124.00),
		(6,7,20,210.00),
		(7,3,10,72),
		(7,5,10,200.00),
		(7,6,10,50.00),
		(8,3,19,136.80),
		(8,5,29,580.00),
		(8,6,39,195.00);
go

/*c*/
select * from cliente 
order by nm_clie

/*d*/
select * from pagamento 
order by id_pgto desc

/*e*/
select * from pagamento 
where id_pgto = 2

/*f*/
select * from cliente 
where nm_clie like 'M%'

/*g*/
select * from pagamento 
where dsc_pgto like 'e'

/*h*/
select * from produto 
where vl_prod > 10.00

/*i*/
select * from pedido 
where dt_ped between '2018-02-10' and '2019-05-10'

/*j*/
select * from cliente 
inner join pedido on cliente.id_clie = pedido.id_clie 
order by nm_clie, id_ped

/*k*/
select id_ped 'Pedido',id_pgto 'Pagamento',id_clie 'Cliente',dt_ped 'Data do Pedido', tot_ped 'Total Pedido' 
from pedido 
where id_clie = 2

/*l*/
select * from item_pedido 
inner join produto on item_pedido.id_prod = produto.id_prod 
order by dsc_prod

/*m*/
select MIN(tot_ped) 'Menor Pedido' 
from pedido

/*n*/
select MAX(tot_ped) 'Maior Pedido' 
from pedido

/*o*/
select AVG(tot_ped) 'Media Pedidos' 
from pedido

/*p*/
select id_prod 
from item_pedido inner join pedido on item_pedido.id_ped = pedido.id_ped 
where pedido.id_clie = 4

/*q*/
select id_pgto 
from pedido 
where id_clie = 1

/*r*/
select	pedido.id_ped 'número do pedido', 
		pedido.dt_ped 'data do pedido', 
		cliente.id_clie 'código do cliente',  
		cliente.nm_clie'nome do cliente', 
		pagamento.dsc_pgto 'descrição da condição de pagamento', 
		item_pedido.qtd_item_ped 'itens do produto', 
		produto.dsc_prod +' R$'+ convert(varchar,item_pedido.vl_item_ped) 'descrição e valor do produto', 
		item_pedido.qtd_item_ped*item_pedido.vl_item_ped 'valor do total do item' , 
		pedido.tot_ped 'total de pedido'

from cliente
	inner join pedido on cliente.id_clie = pedido.id_clie
	inner join item_pedido on pedido.id_ped = item_pedido.id_ped
	inner join pagamento on pedido.id_pgto = pagamento.id_pgto
	inner join produto on item_pedido.id_prod = produto.id_prod

/*s*/
select COUNT(id_ped) 
from pedido 
where id_clie = 3

/*t*/
select SUM(qtd_item_ped*vl_item_ped) 
from item_pedido
where id_prod = 4  

/*u*/
select COUNT(*) 
from cliente

/*v*/
select * from item_pedido right join produto on item_pedido.id_prod = produto.id_prod 
where Isnull(item_pedido.id_prod,'') = ''

/*w*/
select * from cliente right join pedido on cliente.id_clie = pedido.id_clie
where Isnull(cliente.id_clie,'') = ''

/*x*/
alter table item_pedido 
add vl_tot_item numeric(12,2)

update item_pedido set vl_tot_item = qtd_item_ped * vl_item_ped

/*y*/
create view cliente_pedido
as select cliente.id_clie, cliente.nm_clie, pedido.id_ped, pedido.dt_ped, pedido.tot_ped
from cliente inner join pedido on cliente.id_clie = pedido.id_clie

/*z*/
drop database pedido_compra