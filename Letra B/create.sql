-- -----------------------------------------------------
-- Table `rede-hoteis`.`exemplo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`exemplo` (
  `idExemplo` INT(6) NOT NULL AUTO_INCREMENT,
  `textoExemplo` VARCHAR(11) NOT NULL,
  CONSTRAINT pk_Exemplo PRIMARY KEY (`idExemplo`))
ENGINE = InnoDB;