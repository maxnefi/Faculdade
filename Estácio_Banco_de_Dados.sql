--DADOS PARA SEREM TRABALHADOS
create table FUNCIONARIO (
CODFUNCIONARIO INT not null,
NOME VARCHAR (90) not null,
CPF CHAR(15) not null,
SEXO CHAR(1) not null,
DTNASCIMENTO DATE not null,
SALARIO real null,
constraint FUNCIONARIO_pk primary key (CODFUNCIONARIO)
);
select * from FUNCIONARIO; 
insert inTO FUNCIONARIO (CODFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO) values (1, 'MAXWELL SANTOS FARIAS', 123456789, 'M', '01/01/1994', 2000);
insert inTO FUNCIONARIO (CODFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO) values (2, 'DANIELE ROSA', 123456789, 'M', '01/02/1994', 2000);
insert inTO FUNCIONARIO (CODFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO) values (3, 'MAHIARA FARIAS', 123456789, 'F', '01/03/1994', 2000);
insert inTO FUNCIONARIO (CODFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO) values (4, 'ROSA MARIA WERBER', 123456789, 'F', '01/03/1994', 2000);
insert inTO FUNCIONARIO (CODFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO) values (5, 'ELIENE PINHEIRO', 123456789, 'F', '01/09/1994', 2000);
insert inTO FUNCIONARIO (CODFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO) values (6, 'ALISSON SANTOS', 123456789, 'M', '01/10/1994', 2000);
Exibir todos dos dados diferentes de uma determinada tabela

select distinct SEXO from FUNCIONARIO;

--OU

select distinct SEXO from FUNCIONARIO
group by SEXO;

--Grupo de dados com GROUP BY

--Retornar o número de funcionários por sexo.

select SEXO, count(*) as "TOTAL" from FUNCIONARIO
group by SEXO;


--Retornar, por mês de aniversário, a quantidade de colaboradores, o menor salário, o maior salário e o salário médio. Ordene os resultados por mês de aniversário.



select extract (month from DTNASCIMENTO), COUNT(*), MIN(SALARIO), MAX(SALARIO), AVG (SALARIO)
from funcionario
group BY extract (month from DTNASCIMENTO);
order by extract (month from DTNASCIMENTO)


--Grupo de dados com GROUP BY e HAVING


--Suponha que o departamento de recursos humanos esteja estudando a viabilidade de oferecer bônus de 5% aos funcionários por mês de nascimento, mas limitado somente aos casos onde há mais de um colaborador aniversariando. Assim, para cada mês em questão, deseja-se listar o mês, o número de colaboradores e o valor do bônus.

select extract (month from DTNASCIMENTO) as "MES DE ANIVERSÁRIO", COUNT(*) as "TOTAL DE COLABORADORES", SUM(SALARIO*0.05) as "BONUS"
from FUNCIONARIO
group by extract (month from DTNASCIMENTO)
having count(*)>1
order by extract (month from DTNASCIMENTO);



--Junção interna


SELECT * FROM CURSO, NIVELWHERE NIVEL.CODIGONIVEL=CURSO.CODIGONIVEL;

SELECT * FROM CURSO INNER JOIN NIVEL ON (NIVEL.CODIGONIVEL=CURSO.CODIGONIVEL);

SELECT * FROM CURSO INNER JOIN NIVEL USING(CODIGONIVEL);

SELECT CURSO.CODIGOCURSO, CURSO.NOME,NIVEL.CODIGONIVEL, NIVEL.DESCRICAO FROM CURSO INNER JOIN NIVEL ON (NIVEL.CODIGONIVEL=CURSO.CODIGONIVEL);

SELECT C.CODIGOCURSO, C.NOME,N.CODIGONIVEL, N.DESCRICAO FROM CURSO C INNER JOIN NIVEL N ON (N.CODIGONIVEL=C.CODIGONIVEL);

--Junção externa -  LEFT join, RIGHT join & full outer join


--O resultado da consulta anterior exibe somente os cursos para os quais há registro de informação sobre o nível associado a eles. E se quiséssemos incluir na listagem todos os registros da tabela CURSO?

--Para incluir no resultado da consulta todas as ocorrências da tabela CURSO, podemos usar a cláusula LEFT JOIN (junção à esquerda). Nesse tipo de junção, o resultado contém todos os registros da tabela declarada à esquerda da cláusula JOIN, mesmo que não haja registros correspondentes na tabela da direita. Em especial, quando não há correspondência, os resultados são retornados com o valor NULL.

select C.CODIGOCURSO, C.NOME, N.CODIGONIVEL, N.DESCRICAO
from CURSO C LEFT join NIVEL N using (CODIGONIVEL);

--De forma contrária, poderíamos ter interesse em exibir todos os registros da tabela à direita da cláusula JOIN. Em nosso exemplo, a tabela NIVEL. A cláusula RIGHT JOIN (junção à direita) é usada para essa finalidade.

select C.CODIGOCURSO, C.NOME, N.CODIGONIVEL, N.DESCRICAO
from CURSO C RIGHT join NIVEL N using (CODIGONIVEL);

--Outro tipo de junção externa, denominada FULL OUTER JOIN (junção completa), apresenta todos os registros das tabelas à esquerda e à direita, mesmo os registros não relacionados. Em outras palavras, a tabela resultante exibirá todos os registros de ambas as tabelas, além de valores NULL no caso dos registros sem correspondência

select C.CODIGOCURSO, C.NOME, N.CODIGONIVEL, N.DESCRICAO
from CURSO C full outer join NIVEL N using (CODIGONIVEL);


--Subconsultas

--ANINHADA

--Retornar o código e o nome do(s) funcionário(s) que ganha(m) o maior salário.
select 	CODIGOFUNCIONARIO, NOME
from funcionario f 
where SALARIO = (select MAX(SALARIO) from funcionario f );


--Retornar o código e o nome do(s) funcionário(s) que ganha(m) o maior salário.
select 	CODIGOFUNCIONARIO, NOME
from funcionario f 
where SALARIO = (select MAX(SALARIO) from funcionario f );

-- Retornar o código, o nome e o salário do(s) funcionário(s) que ganha(m) mais que a média salarial dos colaboradores.

select  CODIGOFUNCIONARIO, NOME, SALARIO
from funcionario f 
where SALARIO > (select AVG(SALARIO) from funcionario f );

--Retornar o código, o nome e o salário do(s) funcionário(s) que ganha(m) menos que a média salarial dos colaboradores do departamento de Tecnologia da Informação.
select codigOFUNCIONARIO, NOME, SALARIO
from funcionario f 
where SALARIO < 
				(select AVG(SALARIO)
				from FUNCIONARIO 
				where codigodepartamento = (select codigodepartamento 
											from departamento d 
											where NOME='Tecnologia da Informação'));
--Código alternativo:
select CODIGOFUNCIONARIO, NOME, SALARIO
from funcionario f 
where SALARIO < 
				(select AVG(SALARIO) 
				from funcionario f2 join departamento d using (CODIGODEPARTAMENTO)
				where D.NOME = 'Tecnologia da Informação');

--Quantos funcionários recebem menos que a funcionária que possui o maior salário entre as colaboradoras de sexo feminino?

select COUNT(*) as "RECEBEM MENOS"
from funcionario f 
where SALARIO < (select MAX(SALARIO) from funcionario f2 
				where SEXO = 'F');
							    
							    
--SUBCOLSULTAS CORRELATAS			
--Retornar o código, o nome e o salário do(s) funcionário(s) que ganha(m) mais que a média salarial dos colaboradores do departamento ao qual pertencem.
				
select CODIGOFUNCIONARIO, NOME, SALARIO
from funcionario f 
where SALARIO > (select AVG(SALARIO) 
				from funcionario f2 
				where codigodepartamento= F.CODIGODEPARTAMENTO);
				
--suponha que surgiu a necessidade de equiparar os salários dos funcionários que atuam no mesmo departamento. Os funcionários de cada departamento 
--terão salário atualizado em função do maior salário dos seus setores.
update funcionario F
set SALARIO = 
			(select MAX(SALARIO) from funcionario
			where F.codigodepartamento = codigodepartamento)
where CODIGODEPARTAMENTO is not null;

--CONSULTA CORRELACIONADA COM O USO DE [NOT] EXISTS
	
--exibir o código e o nome do departamento onde há pelo menos um funcionário alocado.
select D.CODIGODEPARTAMENTO, D.NOME
from departamento d 
where exists 
			(select F.CODIGODEPARTAMENTO
			from funcionario f
			where D.codigodepartamento = F.codigodepartamento);		
		
--Se estivéssemos interessados em saber se há departamento sem ocorrência de colaborador alocado, bastaria usar a negação (NOT), conforme a seguir:	
select D.CODIGODEPARTAMENTO, D.NOME
from departamento d 
where not exists 
				(select F.CODIGODEPARTAMENTO
				from funcionario f
				where F.codigodepartamento=D.codigodepartamento);
select * from funcionario f;
drop table funcionario cascade;

INSERT INTO CLIENTE (CODIGOCLIENTE, NOME, CPF, SEXO) VALUES   (1,'ROBERTA SILVA BRASIL','82998','F');
INSERT INTO CLIENTE (CODIGOCLIENTE, NOME, CPF, SEXO) VALUES   (2,'MARCOS PEREIRA BRASIL','9999','M');

--Consultas com o operador UNION
CREATE TABLE FUNCIONARIO (CODIGOFUNCIONARIO int  NOT NULL,NOME varchar(90)  NOT NULL,CPF char(15)  NULL,SEXO char(1)  NOT NULL,DTNASCIMENTO date  NOT NULL,SALARIO real   NULL,CONSTRAINT FUNCIONARIO_pk PRIMARY KEY (CODIGOFUNCIONARIO));



INSERT INTO FUNCIONARIO (CODIGOFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO)VALUES (1,'ROBERTA SILVA BRASIL','82998','F','20/02/1980',7000);
INSERT INTO FUNCIONARIO (CODIGOFUNCIONARIO, NOME, CPF,SEXO, DTNASCIMENTO, SALARIO)VALUES (2,'MARIA SILVA BRASIL','9876','F','20/09/1988',9500);
INSERT INTO FUNCIONARIO (CODIGOFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO)VALUES (3,'GABRIELLA PEREIRA LIMA','32998','F','20/02/1990',6000);
INSERT INTO FUNCIONARIO (CODIGOFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO)VALUES (4,'MARCOS PEREIRA BRASIL','9999','M','20/02/1999',6000);
INSERT INTO FUNCIONARIO (CODIGOFUNCIONARIO, NOME, CPF, SEXO, DTNASCIMENTO, SALARIO)VALUES (5,'HEMERSON SILVA BRASIL','9111','M','20/12/1992',4000);

-- Retornar o nome e o CPF de todos os funcionários e clientes.
select NOME, CPF
from funcionario f2 
union 
select NOME, CPF
from CLIENTE;

--Retornar o nome e o CPF de todos os cidadãos que são funcionários e clientes.
select NOME, CPF
from cliente 
intersect 
select NOME, CPF
from funcionario f;

-- Retornar o nome e o CPF de todos os cidadãos que são funcionários, clientes e alunos
select NOME, CPF
from CLIENTE
intersect
select NOME, CPF
from funcionario f 
intersect
select NOME, cpf 
from aluno a ;

--OBS.: Um aspecto importante é que uma consulta sob o formato X UNION Y INTERSECT Z é interpretada sendo X UNION (Y INTERSECT Z)

 --Retornar o nome e o CPF dos funcionários que não são clientes.
select NOME, CPF
from funcionario f 
except 
select NOME, cpf 
from cliente ;

--Retornar o nome e o CPF dos cidadãos que são somente funcionários.
select NOME, CPF
from funcionario f 
except
select NOME, CPF
from aluno a 
except
select NOME, CPF
from CLIENTE;				    
							    
