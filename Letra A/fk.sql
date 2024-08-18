-- FK CONSTRAINT's

ALTER TABLE `rede-hoteis`.`Reserva` ADD
    CONSTRAINT `fk_Reserva_Cliente1`
        FOREIGN KEY (`idCliente`)
        REFERENCES `rede-hoteis`.`Cliente` (`idCliente`)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT;

ALTER TABLE `rede-hoteis`.`Unidade` ADD
    CONSTRAINT `fk_Unidade_Funcionario1`
        FOREIGN KEY (`idGerente`)
        REFERENCES `rede-hoteis`.`Funcionario` (`idFunc`)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT;

ALTER TABLE `rede-hoteis`.`Atrativo` ADD
    CONSTRAINT `fk_Atrativo_Unidade1`
        FOREIGN KEY (`idUnidade`)
        REFERENCES `rede-hoteis`.`Unidade` (`idUnidade`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`Quarto` ADD
    CONSTRAINT `fk_Quarto_Unidade1`
        FOREIGN KEY (`idUnidade`)
        REFERENCES `rede-hoteis`.`Unidade` (`idUnidade`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`Telefone` ADD
    CONSTRAINT `fk_Telefone_Cliente1`
        FOREIGN KEY (`idCliente`)
        REFERENCES `rede-hoteis`.`Cliente` (`idCliente`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`Academia` ADD
    CONSTRAINT `fk_Academia_Atrativo1`
        FOREIGN KEY (`idAtrativo`)
        REFERENCES `rede-hoteis`.`Atrativo` (`idAtrativo`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`Restaurante` ADD
    CONSTRAINT `fk_Restaurante_Atrativo1`
        FOREIGN KEY (`idAtrativo`)
        REFERENCES `rede-hoteis`.`Atrativo` (`idAtrativo`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`trabalha-em-restaurante` 
    ADD CONSTRAINT `fk_Restaurante_has_Funcionario_Restaurante1`
        FOREIGN KEY (`idAtrativo`)
        REFERENCES `rede-hoteis`.`Restaurante` (`idAtrativo`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_Restaurante_has_Funcionario_Funcionario1`
        FOREIGN KEY (`idFunc`)
        REFERENCES `rede-hoteis`.`Funcionario` (`idFunc`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`trabalha-em-academia`
    ADD CONSTRAINT `fk_Academia_has_Funcionario_Academia1`
        FOREIGN KEY (`idAtrativo`)
        REFERENCES `rede-hoteis`.`Academia` (`idAtrativo`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_Academia_has_Funcionario_Funcionario1`
        FOREIGN KEY (`idFunc`)
        REFERENCES `rede-hoteis`.`Funcionario` (`idFunc`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`é-empregado-por`
    ADD CONSTRAINT `fk_Unidade_has_Funcionario_Unidade1`
        FOREIGN KEY (`idUnidade`)
        REFERENCES `rede-hoteis`.`Unidade` (`idUnidade`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_Unidade_has_Funcionario_Funcionario1`
        FOREIGN KEY (`idFunc`)
        REFERENCES `rede-hoteis`.`Funcionario` (`idFunc`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE `rede-hoteis`.`engloba`
    ADD CONSTRAINT `fk_Reserva_has_Quarto_Reserva1`
        FOREIGN KEY (`idReserva`)
        REFERENCES `rede-hoteis`.`Reserva` (`idReserva`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_Reserva_has_Quarto_Quarto1`
        FOREIGN KEY (`idQuarto`)
        REFERENCES `rede-hoteis`.`Quarto` (`idQuarto`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;


