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