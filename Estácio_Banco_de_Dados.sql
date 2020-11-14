select 	CODIGOFUNCIONARIO, NOME
from funcionario f 
where SALARIO = (select MAX(SALARIO) from funcionario f );
