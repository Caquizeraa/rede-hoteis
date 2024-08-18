ALTER TABLE `rede-hoteis`.`Funcionario`
    ALTER `salario` SET DEFAULT 1412.00;

ALTER TABLE `rede-hoteis`.`Quarto`
    ALTER `numCamas` SET DEFAULT 1,
    ALTER `tipoQuarto` SET DEFAULT 'Simples';