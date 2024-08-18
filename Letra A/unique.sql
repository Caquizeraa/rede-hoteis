ALTER TABLE `rede-hoteis`.`Cliente` ADD
    CONSTRAINT `uq_CPF` UNIQUE (`CPF`);

ALTER TABLE `rede-hoteis`.`Atrativo` ADD
    CONSTRAINT `uq_Atrativo` UNIQUE (`idUnidade`, `numAtrativo`);

ALTER TABLE `rede-hoteis`.`Quarto` ADD
    CONSTRAINT `uq_Quarto` UNIQUE (`idUnidade`, `numQuarto`);