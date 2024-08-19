DROP PROCEDURE EncerrarReserva;

DELIMITER //
CREATE PROCEDURE EncerrarReserva(IN pIdReserva VARCHAR(8))
BEGIN
    DECLARE dataAtual DATE DEFAULT CURDATE();
    DECLARE quartoReserva INT;

    DECLARE done INT DEFAULT 0;
    DECLARE quartosReservaCursor CURSOR FOR
    SELECT Q.idQuarto FROM `rede-hoteis`.`Reserva` R JOIN engloba E ON R.idReserva = E.idReserva 
        JOIN `rede-hoteis`.`Quarto` Q ON Q.idQuarto = E.idQuarto 
        WHERE R.idReserva = pIdReserva; 

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN quartosReservaCursor;
    read_loop: LOOP
        FETCH quartosReservaCursor INTO quartoReserva;

        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE `rede-hoteis`.`Quarto` SET disponibilidade = 'D' WHERE idQuarto = quartoReserva;

    END LOOP;
    CLOSE quartosReservaCursor;

    UPDATE `rede-hoteis`.`Reserva` SET dataCheckOut = dataAtual WHERE idReserva = pIdReserva;

END //
DELIMITER ;

CALL EncerrarReserva('R010');

---------------------------------------------------------------------------------------------

DROP PROCEDURE AumentoGerentes;

DELIMITER //
CREATE PROCEDURE AumentoGerentes(IN porcentagemAumento DECIMAL(5,2))
BEGIN
    
    DECLARE vIdGerente INT;
    DECLARE done INT DEFAULT 0;
    DECLARE gerentesCursor CURSOR FOR
        SELECT F.idFunc FROM `rede-hoteis`.`Funcionario` F 
            JOIN `rede-hoteis`.`Unidade` U ON U.idGerente = F.idFunc
            GROUP BY F.idFunc;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN gerentesCursor;
    read_loop: LOOP
        FETCH gerentesCursor INTO vIdGerente;

        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE Funcionario SET salario = (1 + porcentagemAumento/100) * salario WHERE idFunc = vIdGerente;

    END LOOP;
    CLOSE gerentesCursor;

END //
DELIMITER ;

CALL AumentoGerentes(12.5);

---------------------------------------------------------------------------------------------

DROP PROCEDURE EmpregaFuncionario;

DELIMITER //
CREATE PROCEDURE EmpregaFuncionario(IN vIdAtrativo INT, IN vIdFunc INT, IN atrativo VARCHAR(60))
BEGIN
    
    IF atrativo = 'restaurante' THEN
        INSERT INTO `rede-hoteis`.`trabalha-em-restaurante` (idAtrativo, idFunc) VALUES (vIdAtrativo, vIdFunc);
    ELSEIF atrativo = 'academia' THEN
        INSERT INTO `rede-hoteis`.`trabalha-em-academia` (idAtrativo, idFunc) VALUES (vIdAtrativo, vIdFunc);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Tipo de atrativo invalido.';
    END IF;

END //
DELIMITER ;

CALL EmpregaFuncionario(6, 1, 'restaurante');
CALL EmpregaFuncionario(1, 1, 'academia');
CALL EmpregaFuncionario(1, 1, 'SPA');