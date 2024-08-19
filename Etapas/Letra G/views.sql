CREATE VIEW GastoCliente (nomeCliente, valorTotal) AS
    SELECT C.nome, SUM(R.valorTotal) FROM Cliente C 
        JOIN Reserva R ON C.idCliente = R.idCliente
        JOIN engloba E ON E.idReserva = R.idReserva
        GROUP BY C.nome;

SELECT MAX(valorTotal) AS maiorGasto FROM GastoCliente;
SELECT SUM(valorTotal) AS receitaReserva FROM GastoCliente;

-------------------------------------------------------------------------------

CREATE VIEW MelhoresRestaurantes (idAtrativo, nome, estrelas, numMesas) AS
    SELECT R.idAtrativo, nomeAtrativo, estrelas, numMesas FROM Restaurante R 
        JOIN Atrativo A ON R.idAtrativo = A.idAtrativo 
        WHERE estrelas >= 4;

SELECT F.nome FROM MelhoresRestaurantes M 
	JOIN `trabalha-em-restaurante` T ON T.idAtrativo = M.idAtrativo
    JOIN Funcionario F ON F.idFunc = T.idFunc;

-------------------------------------------------------------------------------

CREATE VIEW QuartosDisponiveis AS
    SELECT * FROM Quarto WHERE disponibilidade = 'D';

SELECT * FROM QuartosDisponiveis;