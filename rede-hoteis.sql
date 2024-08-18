-- MySQL Script generated by MySQL Workbench
-- Fri Aug 16 20:27:05 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rede-hoteis
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `rede-hoteis` ;

-- -----------------------------------------------------
-- Schema rede-hoteis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rede-hoteis` DEFAULT CHARACTER SET utf8 ;
USE `rede-hoteis` ;

-- -----------------------------------------------------
-- Table `rede-hoteis`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Funcionario` (
  `idFunc` INT(6) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `salario` REAL(8,2) NOT NULL,
  `logradouro` VARCHAR(40) NOT NULL,
  `numero` INT(4) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  `bairro` VARCHAR(30) NOT NULL,
  `cidade` VARCHAR(30) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `tipoFuncionario` VARCHAR(12) NOT NULL,
  CONSTRAINT pk_Funcionario PRIMARY KEY (`idFunc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Cliente` (
  `idCliente` INT(6) NOT NULL AUTO_INCREMENT,
  `CPF` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(80) NOT NULL,
  `logradouro` VARCHAR(40) NOT NULL,
  `numero` INT(4) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  `bairro` VARCHAR(30) NOT NULL,
  `cidade` VARCHAR(30) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  CONSTRAINT pk_Cliente PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Reserva` (
  `idReserva` VARCHAR(8) NOT NULL,
  `valorTotal` REAL(8,2) NOT NULL,
  `dataCheckIn` DATE NOT NULL,
  `dataCheckOut` DATE NULL,
  `idCliente` INT(6) NOT NULL,
  -- INDEX `fk_Reserva_Cliente1_idx` (`Cliente_CPF` ASC) VISIBLE,
  CONSTRAINT pk_Reserva PRIMARY KEY (`idReserva`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Unidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Unidade` (
  `idUnidade` INT(3) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(40) NOT NULL,
  `logradouro` VARCHAR(40) NOT NULL,
  `numero` INT(4) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  `bairro` VARCHAR(30) NOT NULL,
  `cidade` VARCHAR(30) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `dataInicio` DATE NOT NULL,
  `idGerente` INT(6) NOT NULL,
  CONSTRAINT pk_Unidade PRIMARY KEY (`idUnidade`),
  INDEX `fk_Unidade_Funcionario1_idx` (`idGerente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Atrativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Atrativo` (
  `idAtrativo` INT(3) NOT NULL AUTO_INCREMENT,
  `nomeAtrativo` VARCHAR(40) NOT NULL,
  `idUnidade` INT(3) NOT NULL,
  CONSTRAINT pk_Atrativo PRIMARY KEY (`idAtrativo`),
  INDEX `fk_Atrativo_Unidade1_idx` (`idUnidade` ASC) VISIBLE,
  UNIQUE INDEX `Unidade_idUnidade_UNIQUE` (`idUnidade` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Quarto` (
  `idQuarto` INT(3) NOT NULL AUTO_INCREMENT,
  `idUnidade` INT(3) NOT NULL,
  `numQuarto` INT(3) NOT NULL,
  `numCamas` INT(1) NOT NULL,
  `disponibilidade` VARCHAR(1) NOT NULL,
  `tipoQuarto` VARCHAR(7) NOT NULL,
  CONSTRAINT pk_Quarto PRIMARY KEY (`idQuarto`),
  INDEX `fk_Quarto_Unidade1_idx` (`idUnidade` ASC) VISIBLE,
  UNIQUE INDEX `Unidade_idUnidade_UNIQUE` (`idUnidade` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Telefone` (
  `idCliente` INT(6) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  CONSTRAINT pk_Telefone PRIMARY KEY (`idCliente`, `telefone`),
  -- INDEX `fk_Telefone_Cliente1_idx` (`Cliente_CPF` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Academia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Academia` (
  `idAtrativo` INT(3) NOT NULL,
  `numAparelhos` INT(3) NOT NULL,
  CONSTRAINT pk_Academia PRIMARY KEY (`idAtrativo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`Restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`Restaurante` (
  `idAtrativo` INT(3) NOT NULL,
  `estrelas` INT(1) NOT NULL,
  `numMesas` INT(3) NOT NULL,
  CONSTRAINT pk_Restaurante PRIMARY KEY (`idAtrativo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`trabalha-em-restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`trabalha-em-restaurante` (
  `idAtrativo` INT(3) NOT NULL,
  `idFunc` INT(6) NOT NULL,
  CONSTRAINT pk_trabalhaRestaurante PRIMARY KEY (`idAtrativo`, `idFunc`),
  INDEX `fk_Restaurante_has_Funcionario_Funcionario1_idx` (`idFunc` ASC) VISIBLE,
  INDEX `fk_Restaurante_has_Funcionario_Restaurante1_idx` (`idAtrativo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`trabalha-em-academia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`trabalha-em-academia` (
  `idAtrativo` INT(3) NOT NULL,
  `idFunc` INT(6) NOT NULL,
  CONSTRAINT pk_trabalhaAcademia PRIMARY KEY (`idAtrativo`, `idFunc`),
  INDEX `fk_Academia_has_Funcionario_Funcionario1_idx` (`idFunc` ASC) VISIBLE,
  INDEX `fk_Academia_has_Funcionario_Academia1_idx` (`idAtrativo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`é-empregado-por`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`é-empregado-por` (
  `idUnidade` INT(3) NOT NULL,
  `idFunc` INT(6) NOT NULL,
  CONSTRAINT pk_EmpregadoPor PRIMARY KEY (`idUnidade`, `idFunc`),
  INDEX `fk_Unidade_has_Funcionario_Funcionario1_idx` (`idFunc` ASC) VISIBLE,
  INDEX `fk_Unidade_has_Funcionario_Unidade1_idx` (`idUnidade` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede-hoteis`.`engloba`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede-hoteis`.`engloba` (
  `idReserva` VARCHAR(8) NOT NULL,
  `idQuarto` INT(3) NOT NULL,
  CONSTRAINT pk_Engloba PRIMARY KEY (`idReserva`, `idQuarto`),
  INDEX `fk_Reserva_has_Quarto_Quarto1_idx` (`idQuarto` ASC) VISIBLE,
  INDEX `fk_Reserva_has_Quarto_Reserva1_idx` (`idReserva` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
