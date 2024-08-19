UPDATE `rede-hoteis`.`Funcionario`
SET `salario` = 3600.00
WHERE `nome` = 'Franz Kafka';

UPDATE `rede-hoteis`.`Quarto`
SET `numCamas` = 3
WHERE `idUnidade` = 1 AND `numQuarto` = 102;

UPDATE `rede-hoteis`.`Funcionario`
SET `salario` = `salario` * 1.05
WHERE `tipoFuncionario` = 'Faxineiro';

UPDATE `rede-hoteis`.`Unidade`
SET `nome` = 'Hotel Planeta'
WHERE `nome` = 'Hotel Sol';

UPDATE `rede-hoteis`.`Funcionario` f
JOIN `trabalha-em-academia` as t
ON f.`idFunc` = t.`idFunc`
JOIN `atrativo` as a 
ON t.`idAtrativo` = a.`idAtrativo`
JOIN `unidade` as u 
ON a.`idUnidade` = u.`idUnidade`
SET f.`salario` = f.`salario` * 1.10
WHERE f.`tipoFuncionario` = 'Instrutor' AND u.`nome` = 'Hotel Venus';
