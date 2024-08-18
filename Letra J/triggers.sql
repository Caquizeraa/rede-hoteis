DROP TRIGGER before_insert_ehEmpregadoPor;

DELIMITER //
CREATE TRIGGER before_insert_ehEmpregadoPor
BEFORE INSERT ON `rede-hoteis`.`é-empregado-por`
FOR EACH ROW
BEGIN
    DECLARE salarioFunc, salarioGerente DOUBLE(8, 2);

    SELECT F.salario INTO salarioGerente FROM `rede-hoteis`.`Funcionario` F JOIN `rede-hoteis`.`Unidade` U 
        ON F.idFunc = U.idGerente 
        WHERE U.idUnidade = NEW.idUnidade;

    SELECT salario INTO salarioFunc FROM `rede-hoteis`.`Funcionario` F
        WHERE idFunc = NEW.idFunc;

    IF salarioFunc > salarioGerente  THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Salario do funcionario nao pode ser superior ao do gerente da unidade.';
    END IF;
END;
//
DELIMITER ;

-----------------------------------------------------------------------------------------------

INSERT INTO `rede-hoteis`.`é-empregado-por` (idUnidade, idFunc) VALUES (1, 18); 

-----------------------------------------------------------------------------------------------

DROP TRIGGER before_update_Reserva;

DELIMITER //
CREATE TRIGGER before_update_Reserva
BEFORE UPDATE ON `rede-hoteis`.`Reserva`
FOR EACH ROW
BEGIN
    
    IF 
        NEW.dataCheckOut IS NOT NULL AND
        (OLD.dataCheckOut IS NULL OR OLD.dataCheckOut != NEW.dataCheckOut) AND 
        NEW.dataCheckOut < NEW.dataCheckIn 
        THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Data de checkOut invalida.';
    END IF;
END;
//
DELIMITER ;

-----------------------------------------------------------------------------------------------

INSERT INTO `rede-hoteis`.`Reserva` (idReserva, valorTotal, dataCheckIn, dataCheckOut, idCliente) VALUES ('R099', 5000.00, '2024-08-10', null, 10);
UPDATE `rede-hoteis`.`Reserva` SET dataCheckOut = '2024-08-09' WHERE idReserva = 'R099';

-----------------------------------------------------------------------------------------------

DROP TRIGGER before_delete_Telefone;

DELIMITER //
CREATE TRIGGER before_delete_Telefone
BEFORE DELETE ON `rede-hoteis`.`Telefone`
FOR EACH ROW
BEGIN
    
    DECLARE numTelefones INT;

    SELECT COUNT(*) INTO numTelefones FROM Cliente C NATURAL JOIN Telefone T WHERE T.idCliente = OLD.idCliente;

    IF numTelefones = 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Cliente deve possuir ao menos um telefone de contato.';
    END IF;
END;
//
DELIMITER ;


-----------------------------------------------------------------------------------------------

DELETE FROM `rede-hoteis`.`Telefone` WHERE idCliente = 1;

-----------------------------------------------------------------------------------------------

