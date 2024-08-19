DELETE FROM `rede-hoteis`.`Funcionario`
WHERE `nome` = 'Getúlio Vargas';

DELETE FROM `rede-hoteis`.`Quarto`
WHERE `idUnidade` = 1 AND `numQuarto` = 102;

DELETE FROM `rede-hoteis`.`Funcionario`
WHERE `tipoFuncionario` = 'Faxineiro';

DELETE FROM `rede-hoteis`.`Unidade`
WHERE `nome` = 'Hotel Planeta';

DELETE f
FROM `rede-hoteis`.`Funcionario` f
JOIN `trabalha-em-academia` as t
ON f.`idFunc` = t.`idFunc`
JOIN `atrativo` as a 
ON t.`idAtrativo` = a.`idAtrativo`
JOIN `unidade` as u 
ON a.`idUnidade` = u.`idUnidade`
WHERE f.`tipoFuncionario` = 'Instrutor' AND u.`nome` = 'Hotel Venus';
