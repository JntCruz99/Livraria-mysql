CREATE DATABASE livraria;
use livraria;
create table tb_editora(
	codigo int primary key,
    nome varchar(100)
);
create table tb_assunto(
	sigla char(2) primary key,
    nome varchar(100)
);
create table tb_livro(
	codigo int primary key,
    titulo varchar(100),
    valor decimal(8,2),
    ano int,
    assunto char(2),
    editora int,
	FOREIGN key (assunto) REFERENCES tb_assunto(sigla),
    FOREIGN key (editora) REFERENCES tb_editora(codigo)
);

insert into tb_editora (codigo, nome) VALUES (1, 'Pearson');
insert into tb_editora (codigo, nome) VALUES (2, 'Saraiva');
insert into tb_editora (codigo, nome) VALUES (3, 'Bookman');
insert into tb_editora (codigo, nome) VALUES (4, 'Unipê');

insert into tb_assunto (sigla, nome) VALUES ('BD', 'Banco de Dados');
insert into tb_assunto (sigla, nome) VALUES ('GP', 'Gerencia de Projetos');
insert into tb_assunto (sigla, nome) VALUES ('RC', 'Redes de Computadores');
insert into tb_assunto (sigla, nome) VALUES ('ES', 'Engenharia de Software');
insert into tb_assunto (sigla, nome) VALUES ('PR', 'Programação');

insert into tb_livro (codigo, titulo, valor, ano, assunto, editora) VALUES (1, 'MySQL', 100.00, 2014, 'BD', 1);
insert into tb_livro (codigo, titulo, valor, ano, assunto, editora) VALUES (2, 'Introdução ao PMBOK', 88.00, 2014, 'GP', 2);
insert into tb_livro (codigo, titulo, valor, ano, assunto, editora) VALUES (3, 'JAVA', 75.00, 2014, 'PR', 2);
insert into tb_livro (codigo, titulo, valor, ano, assunto, editora) VALUES (4, 'Engenharia de Software', 120.00, 2013, 'ES', 3);
insert into tb_livro (codigo, titulo, valor, ano, assunto, editora) VALUES (5, 'Python', 65.00, 2015, 'PR', 4);
insert into tb_livro (codigo, titulo, valor, ano, assunto, editora) VALUES (6, 'Oracle', 150.00, 2016, 'BD', 4);
insert into tb_livro (codigo, titulo, valor, ano, assunto, editora) VALUES (7, 'Redes de Computadores', 99.00, 2016, 'RC', 1);

SELECT * FROM tb_livro;
-- agrupando informações
-- select colunas from tabela group by coluna
-- HAVING condição
# Exibir o  preço medio dos livros de acordo com o assunto:
SELECT assunto AS 'ASSUNTO', AVG(valor) AS 'VALOR MEDIO'FROM tb_livro GROUP BY tb_assunto;
SELECT assunto AS 'ASSUNTO', AVG(valor) AS 'VALOR MEDIO'FROM tb_livro GROUP BY assunto;
SELECT assunto , AVG(valor)FROM tb_livro GROUP BY editora;

-- colocando condições 
SELECT assunto AS 'ASSUNTO', AVG(valor) AS 'VALOR MEDIO'FROM tb_livro GROUP BY assunto HAVING assunto='BD';

#SUBCONSULTAS(SELECT...(SELECT))
SELECT assunto, valor FROM tb_livro;
SELECT assunto, valor FROM tb_livro WHERE valor >= 150;

# SINTAXE BASE
# SELECT COLUNAS
# WHERE COLUNA ? (SELECT INTERNO)
# CASO 1: QUANDO O SELECT DA LINHA 55 PORTANTO UTILIZAMOS 
# = > < >= <= <>
SELECT * FROM tb_livro;
SELECT max(valor) FROM tb_livro;
SELECT titulo FROM tb_livro WHERE valor = 150;
SELECT titulo FROM tb_livro WHERE valor = (SELECT max(valor) FROM tb_livro);

# CASO 2 : QUANDO SELECT DA LINHA 54 
# IN 
SELECT max(valor) FROM tb_livro;
SELECT valor FROM tb_livro WHERE valor > 100;
SELECT titulo FROM tb_livro WHERE valor IN (SELECT valor FROM tb_livro WHERE valor > 100);

# fazer uma consulta que retorne os valores e titulo do livro para aqueles cujo ano de publicação é acima de 2015
SELECT ano FROM tb_livro WHERE ano >= 2015;
SELECT titulo,valor FROM tb_livro WHERE ano IN (SELECT ano FROM tb_livro WHERE ano >= 2015);

#Consulta em uma tabela

SELECT nome, titulo, valor FROM tb_assunto, tb_livro WHERE sigla=assunto;
SELECT tb_assunto.nome, tb_editora.nome FROM tb_assunto,tb_editora, tb_livro WHERE tb_assunto.sigla=tb_livro.assunto AND tb_editora.codigo=tb_livro.editora;

SELECT ass.nome, liv.titulo FROM tb_assunto AS ass, tb_livro AS liv WHERE ass.sigla=liv.assunto and liv.valor>100;
SELECT a.nome, l.titulo FROM tb_assunto a, tb_livro l WHERE a.sigla=l.assunto and l.valor>100;

#JOIN = INNER JOIN

SELECT a.nome, l.titulo FROM tb_assunto a INNER JOIN tb_livro l ON a.sigla=l.assunto;
insert into tb_livro(codigo,titulo,valor,ano) values (20, 'Dir. Digital', 250.00, 2021),(30,'Analise de Software', 220.50,2022);
insert into tb_editora(codigo,nome) values(1001,'Teste1'), (1002, 'terçou');
SELECT * FROM tb_editora;

SELECT e.nome , l.titulo From tb_editora e INNER JOIN tb_livro l ON e.codigo = l.editora;

SELECT e.nome , l.titulo From tb_editora e LEFT JOIN tb_livro l ON e.codigo = l.editora;
SELECT e.nome , l.titulo From tb_editora e RIGHT JOIN tb_livro l ON e.codigo = l.editora;

SELECT e.nome, a.nome, l.titulo FROM  tb_editora e INNER JOIN tb_livro l ON e.codigo=l.editora LEFT JOIN tb_assunto a ON a.sigla=l.assunto;