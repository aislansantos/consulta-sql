consultas gerais SQL

CREATE database teste_vendas;
use teste_vendas;

show tables;

drop table clientes;
drop table produtos;
drop table transportadoras;


CREATE TABLE clientes(
id int not null auto_increment,
name varchar(127) not null,
primary key(id)
)ENGINE = innoDB;

CREATE TABLE vendedores(
id int not null auto_increment,
name varchar(127) not null,
primary key(id)
)ENGINE = innoDB;

CREATE TABLE produtos(
id int not null auto_increment,
descricao varchar(127) not null,
preco double(6,2) not null,
primary key(id)
)ENGINE = innodb;


CREATE TABLE transportadoras(
id int not null auto_increment,
descricao varchar(127) not null,
valor_frete double(6,2) not null,
primary key(id)
)ENGINE = innodb;


ALTER TABLE produtos MODIFY COLUMN preco double(6,2) not null;



-- ------------ Table vendas -------------------------- 

CREATE TABLE vendas (
id int NOT NULL auto_increment,
data date NOT NULL,
cliente_id int NOT NULL,
vendedor_id int NOT NULL,
transport_id int NOT NULL DEFAULT 1, 
PRIMARY KEY (id)
)ENGINE = innodb;

ALTER TABLE vendas DROP COLUMN valor_total;
ALTER TABLE vendas ADD COLUMN transport_id int default 1; 
ALTER TABLE vendas ALTER COLUMN transport_id DROP default;
ALTER TABLE vendas MODIFY COLUMN transport_id int default 1;
ALTER TABLE vendas MODIFY COLUMN transport_id int not null;


ALTER TABLE vendas
ADD CONSTRAINT fk_vendas_cliente_id
FOREIGN KEY (cliente_id) REFERENCES clientes(id);

ALTER TABLE vendas
ADD CONSTRAINT fk_vendas_vendedor_id
FOREIGN KEY (vendedor_id) REFERENCES vendedores(id);

ALTER TABLE vendas
ADD CONSTRAINT fk_vendas_transport_id
FOREIGN KEY (transport_id) REFERENCES transportadoras(id);

-- -----------------------------------------------------

CREATE TABLE item_vendas (
id int NOT NULL auto_increment,
venda_id int NOT NULL,
produto_id int NOT NULL,
quantidade int NOT NULL DEFAULT 0,
PRIMARY KEY (id)
)ENGINE = innodb;


ALTER TABLE item_vendas
ADD CONSTRAINT fk_item_vendas_produto_id
FOREIGN KEY (produto_id) REFERENCES produtos(id);

ALTER TABLE item_vendas
ADD CONSTRAINT fk_item_vendas_venda_id
FOREIGN KEY (venda_id) REFERENCES vendas(id);


-- -------------------Inserir dados na table --------------
INSERT INTO vendedores (name) VALUES ('Vendedor A');
INSERT INTO vendedores (name) VALUES ('Vendedor B');
INSERT INTO vendedores (name) VALUES ('Vendedor C');

INSERT INTO clientes (name) VALUES ('Débora Rexnede Angelo Santos');



INSERT INTO vendas (data, cliente_id, vendedor_id) VALUES ("2024-01-22", 1, 3);
INSERT INTO vendas (data, cliente_id, vendedor_id) VALUES ("2024-02-04", 1, 2);


INSERT INTO vendas (data, cliente_id, vendedor_id) VALUES ("2024-02-04", 1701, 1);


INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (1, 2, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (1, 3, 2);

INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (2, 7, 1);


INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (3, 6, 1);



INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (4, 5, 2);



-- ---------------------------------------------- INSERTS GERADOS EM PLANILHA --------------------------------------------------\
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 5, 2, 1);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-05-02", 6, 3, 2);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2023-11-22", 7, 3, 3);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2021-11-05", 8, 1, 4);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 9, 1, 3);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 10, 1, 2);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 11, 2, 1);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 12, 3, 2);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 13, 1, 3);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 14, 2, 4);
INSERT  INTO  vendas (data, cliente_id, vendedor_id, transport_id) VALUES ("2024-01-23", 15, 1, 1);


INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (5, 5, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (6, 1, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (7, 2, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (8, 3, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (9, 4, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (10, 1, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (11, 3, 2);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (12, 4, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (13, 1, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (14, 5, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (5, 6, 4);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (7, 7, 2);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (9, 3, 1);
INSERT INTO item_vendas (venda_id, produto_id, quantidade) VALUES (11, 2, 1);

;


-- ----------------Consulta Simples --------------------------

desc vendas;

SELECT * FROM vendas v;
SELECT * FROM clientes c ;
SELECT * FROM vendedores v;
SELECT * FROM produtos p ;
SELECT * FROM item_vendas iv; 
SELECT * from transportadoras t;
 
SELECT COUNT(*) from clientes c ;


-- ---------------- Consultar simples especificas -----------------------

-- Mostra a quantidade de clientes sem registto de compra no database
SELECT COUNT(*) cliente_sem_registro_venda FROM clientes c
  WHERE c.id NOT IN (SELECT v.cliente_id FROM vendas v);
  
-- Mostra a quantidade de clientes que tem rtegistro de compra no database
SELECT COUNT(*) cliente_com_registro_venda FROM clientes c
	WHERE c.id IN (SELECT v.cliente_id FROM vendas v);

-- Mostra os clientes que tem rtegistro de compra no database
SELECT * FROM clientes c
	WHERE c.id IN (SELECT v.cliente_id FROM vendas v);

-- consulta vendas sem itens
SELECT * FROM vendas v
	WHERE v.id NOT IN (SELECT iv.venda_id FROM item_vendas iv);

-- consulta a quantidade de vendas sem item
SELECT COUNT(*) FROM vendas v
	WHERE v.id NOT IN (SELECT iv.venda_id FROM item_vendas iv);

-- Outra forma de achar venda sem itens
SELECT * FROM vendas v
LEFT JOIN item_vendas iv ON iv.venda_id = v.id
WHERE iv.id IS NULL
ORDER BY v.id ;


-- ------------------------------------------

-- RELATŔIO DE PEDIDOS COM OS TOTAIS


SELECT 
	v.id as cod,
	v.data,
	c.name cliente,
	ve.name vendedor,
	t.descricao transportadora,
	t.valor_frete valorFrete,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) totalItens,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) + t.valor_frete totalPedido
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN vendedores ve ON v.vendedor_id = ve.id
INNER JOIN transportadoras t on v.transport_id = t.id
UNION ALL
SELECT 
    NULL as cod,
    NULL as data,
    NULL as cliente,
    NULL as vendedor,
    "TOTAIS" as transportadora,
    SUM(t.valor_frete) as valorFrete,
   	SUM(IFNULL((
		SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
		INNER JOIN produtos p ON iv.produto_id = p.id
		WHERE v.id = iv.venda_id
		),0)) as totalItens,
    SUM(IFNULL((
        SELECT SUM(iv.quantidade * p.preco) 
        FROM item_vendas iv
        INNER JOIN produtos p ON iv.produto_id = p.id
        WHERE v.id = iv.venda_id
    ), 0) + t.valor_frete) as totalPedido
FROM vendas v
INNER JOIN transportadoras t ON v.transport_id = t.id
ORDER BY cod DESC ;

-- --------------------------------------------------------------------------------------------









-- Consulta pedidos dados gerais, incluindo a soma do total dos pedidos:
SELECT 
	v.id as cod,
	v.data,
	c.name cliente,
	ve.name vendedor,
	t.descricao transportadora,
	t.valor_frete valorFrete,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) totalItens,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) + t.valor_frete totalPedido
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN vendedores ve ON v.vendedor_id = ve.id
INNER JOIN transportadoras t on v.transport_id = t.id
ORDER BY v.id;


-- CONSULTA VENDA SEM ITENS LANÇADOS
SELECT 
	v.id as cod,
	v.data,
	c.name cliente,
	ve.name vendedor,
	t.descricao transportadora,
	t.valor_frete valorFrete,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) totalItens,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) + t.valor_frete totalPedido
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN vendedores ve ON v.vendedor_id = ve.id
INNER JOIN transportadoras t on v.transport_id = t.id
WHERE v.id NOT IN (SELECT iv.venda_id FROM item_vendas iv)
ORDER BY v.id;


-- CONSULTA VENDA SEM ITENS LANÇADOS - LEFT JOIN
SELECT 
	v.id as cod,
	v.data,
	c.name cliente,
	ve.name vendedor,
	t.descricao transportadora,
	t.valor_frete valorFrete,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) totalItens,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) + t.valor_frete totalPedido
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN vendedores ve ON v.vendedor_id = ve.id
INNER JOIN transportadoras t ON v.transport_id = t.id
LEFT JOIN item_vendas iv2 ON v.id = iv2.venda_id
WHERE iv2.id IS NULL
ORDER BY v.id;


-- CONSULTA VENDA SOMENTE COM ITENS LANÇADOS
SELECT 
	v.id as cod,
	v.data,
	c.name cliente,
	ve.name vendedor,
	t.descricao transportadora,
	t.valor_frete valorFrete,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) totalItens,
		(IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) + t.valor_frete) as totalPedido
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN vendedores ve ON v.vendedor_id = ve.id
INNER JOIN transportadoras t on v.transport_id = t.id
WHERE v.id IN (SELECT iv.venda_id FROM item_vendas iv)
ORDER BY v.id;


-- Consulta pedido unico com os dados gerais:
SELECT 
	v.id as cod,
	v.data,
	c.id codCli,
	c.name cliente,
	ve.id codVend,
	ve.name vendedor,
	t.descricao transportadora,
	t.valor_frete valorFrete,
		(
			SELECT SUM(iv.quantidade) from item_vendas iv 
			WHERE iv.venda_id = v.id 
	  	) totalItens,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) totalItens,
		IFNULL((
			SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
			INNER JOIN produtos p ON iv.produto_id = p.id
			WHERE v.id = iv.venda_id
		),0) + t.valor_frete totalPedido
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN vendedores ve ON v.vendedor_id = ve.id
INNER JOIN transportadoras t on v.transport_id = t.id
WHERE v.id = 2;



-- Consulta todos os items de pedidos
SELECT
	iv.id,
	iv.venda_id as numero_pedido,
	iv.produto_id as cod_produto,
	p.descricao,
	iv.quantidade,
	p.preco as valor_unitario,
	iv.quantidade * p.preco as valor_total
FROM item_vendas iv
INNER JOIN produtos p ON iv.produto_id = p.id;


-- Contsulta dos prordutos por pedido
SELECT 
	iv.venda_id as numero_pedido,
	iv.produto_id as cod_produto,
	p.descricao,
	iv.quantidade,
	p.preco as valor_unitario,
	iv.quantidade * p.preco as valor_total
FROM item_vendas iv
INNER JOIN produtos p ON iv.produto_id = p.id 
WHERE iv.venda_id = 2;

SELECT * FROM vendas v
INNER JOIN transportadoras t ON v.transport_id  = t.id ; 

SELECT * FROM vendas v
INNER JOIN transportadoras t ON v.transport_id  = t.id 
WHERE t.id = 2; 

SELECT COUNT(*) FROM vendas v
INNER JOIN transportadoras t ON v.transport_id  = t.id ; 

SELECT SUM(t.valor_frete) FROM vendas v 
INNER JOIN transportadoras t ON v.transport_id = t.id ;




	 
-- Media por transportadora.
SELECT AVG(t.valor_frete) FROM vendas v
INNER JOIN transportadoras t ON v.transport_id  = t.id
WHERE t.id = 3; 

SELECT 
	t.descricao,
	AVG(t.valor_frete) valor_medio_frete
FROM vendas v
INNER JOIN transportadoras t ON v.transport_id  = t.id
GROUP BY t.id ; 

-- ---------------------------------------------------------------------

SELECT * FROM vendas v
	(SELECT SUM(iv.quantidade * p.preco) FROM item_vendas iv
	INNER JOIN produtos p ON iv.produto_id = p.id	
	WHERE v.id = iv.venda_id) AS total;
  




