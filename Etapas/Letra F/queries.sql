-- Descrição: Lista funcionários com salário acima de 3000, que são gerentes ou recepcionistas, ordenados por salário decrescente.
SELECT nome, salario, tipoFuncionario
FROM Funcionario
WHERE salario > 3000 AND tipoFuncionario IN ('Gerente', 'Recepcionista')
ORDER BY salario DESC;

 
-- Descrição: Mostra unidades com mais de 2 quartos, exibindo o total de quartos e a média de camas por unidade.
SELECT idUnidade, COUNT(*) as total_quartos, AVG(numCamas) as media_camas
FROM Quarto
GROUP BY idUnidade
HAVING total_quartos > 2
ORDER BY total_quartos DESC;

 
 -- Descrição: Lista funcionários que trabalham em unidades abertas nos últimos 5 anos, incluindo seus salários e o nome da unidade (se disponível).
SELECT f.nome, f.salario, u.nome AS nome_unidade
FROM Funcionario f
LEFT OUTER JOIN `é-empregado-por` e ON f.idFunc = e.idFunc
INNER JOIN Unidade u ON e.idUnidade = u.idUnidade
WHERE u.dataInicio BETWEEN DATE_SUB(CURDATE(), INTERVAL 5 YEAR) AND CURDATE();


-- Descrição: Combina a lista de funcionários e clientes, mostrando nome, cidade e estado, identificando o tipo de cada registro.
SELECT 'Funcionário' as tipo, nome, cidade, estado
FROM Funcionario
UNION
SELECT 'Cliente' as tipo, nome, cidade, estado
FROM Cliente
ORDER BY estado, cidade;


-- Descrição: Encontra funcionários que trabalham em unidades localizadas em São Paulo.
SELECT f.nome, f.tipoFuncionario
FROM Funcionario f
WHERE EXISTS (
    SELECT 1
    FROM `é-empregado-por` e
    JOIN Unidade u ON e.idUnidade = u.idUnidade
    WHERE e.idFunc = f.idFunc AND u.cidade = 'São Paulo'
);


 -- Descrição: Calcula a distribuição percentual de tipos de quarto em relação ao total de quartos.
SELECT tipo_quarto, total_quartos, 
       (total_quartos * 100.0 / (SELECT COUNT(*) FROM Quarto)) AS percentagem
FROM (
    SELECT tipoQuarto as tipo_quarto, COUNT(*) as total_quartos
    FROM Quarto
    GROUP BY tipoQuarto
) AS quartos_por_tipo;


-- Descrição: Busca clientes com reservas no último ano, mostrando o número de reservas em quartos suites.
 SELECT c.idCliente, c.nome, c.cidade,
       (SELECT COUNT(DISTINCT r.idReserva)
        FROM Reserva r
        JOIN engloba e ON r.idReserva = e.idReserva
        JOIN Quarto q ON e.idQuarto = q.idQuarto
        WHERE r.idCliente = c.idCliente AND q.tipoQuarto = 'Suíte') AS reservas_suite
FROM Cliente c
WHERE EXISTS (
      SELECT 1
      FROM Reserva r
      WHERE r.idCliente = c.idCliente
        AND r.dataCheckIn > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
  );


-- Descrição: Lista unidades com atrativos, mostrando quartos disponíveis, valor médio de reserva e ranking baseado nesse valor.
SELECT u.nome AS nome_unidade, 
       (SELECT COUNT(*) 
        FROM Quarto q 
        WHERE q.idUnidade = u.idUnidade AND q.disponibilidade = 'D') AS quartos_disponiveis,
       (SELECT AVG(r.valorTotal)
        FROM Reserva r
        JOIN engloba e ON r.idReserva = e.idReserva
        JOIN Quarto q ON e.idQuarto = q.idQuarto
        WHERE q.idUnidade = u.idUnidade) AS valor_medio_reserva,
       RANK() OVER 
			(ORDER BY 
				(SELECT AVG(r.valorTotal)
					FROM Reserva r
						JOIN engloba e ON r.idReserva = e.idReserva
						JOIN Quarto q ON e.idQuarto = q.idQuarto
							WHERE q.idUnidade = u.idUnidade) DESC) AS ranking_valor
FROM Unidade u
WHERE EXISTS (
    SELECT 1 FROM Atrativo a WHERE a.idUnidade = u.idUnidade
)
ORDER BY valor_medio_reserva DESC;

 
-- Descrição: Encontra clientes com reservas acima da média em unidades gerenciadas por funcionários bem pagos (salario > avg).
SELECT DISTINCT c.nome, c.cidade, r.valorTotal
FROM Cliente c
JOIN Reserva r ON c.idCliente = r.idCliente
JOIN engloba e ON r.idReserva = e.idReserva
JOIN Quarto q ON e.idQuarto = q.idQuarto
JOIN Unidade u ON q.idUnidade = u.idUnidade
WHERE r.valorTotal > ANY (
    SELECT AVG(r2.valorTotal)
    FROM Reserva r2
    JOIN engloba e2 ON r2.idReserva = e2.idReserva
    JOIN Quarto q2 ON e2.idQuarto = q2.idQuarto
    WHERE q2.idUnidade = u.idUnidade
)
AND u.idGerente IN (
    SELECT idFunc
    FROM Funcionario
    WHERE salario > (SELECT AVG(salario) FROM Funcionario)
);
 
 
-- Descrição: Lista funcionários com salário acima da média de todos os tipos de funcionário e que trabalharam em mais de uma cidade.
SELECT f.nome, f.salario, f.tipoFuncionario,
       (SELECT COUNT(DISTINCT e.idUnidade)
        FROM `é-empregado-por` e
        WHERE e.idFunc = f.idFunc) AS num_unidades_trabalhadas
FROM Funcionario f
WHERE f.salario > ALL (
    SELECT AVG(f2.salario)
    FROM Funcionario f2
    GROUP BY f2.tipoFuncionario
)
AND f.idFunc IN (
    SELECT DISTINCT ep.idFunc
    FROM `é-empregado-por` ep
    JOIN Unidade u ON ep.idUnidade = u.idUnidade
    GROUP BY ep.idFunc
    HAVING COUNT(DISTINCT u.cidade) > 1
);


-- Descrição: Mostra reservas para 2024 de clientes, que não incluem quartos suites, e o número de atrativos disponíveis.
SELECT r.idReserva, r.dataCheckIn, r.dataCheckOut, r.valorTotal,
       (SELECT COUNT(DISTINCT a.idAtrativo)
        FROM Atrativo a
        JOIN Unidade u ON a.idUnidade = u.idUnidade
        JOIN Quarto q ON u.idUnidade = q.idUnidade
        JOIN engloba e ON q.idQuarto = e.idQuarto
        WHERE e.idReserva = r.idReserva) AS num_atrativos_disponiveis
FROM Reserva r
JOIN Cliente c ON r.idCliente = c.idCliente
WHERE r.dataCheckIn BETWEEN '2024-01-01' AND '2024-12-31'
  AND NOT EXISTS (
    SELECT 1
    FROM engloba e
    JOIN Quarto q ON e.idQuarto = q.idQuarto
    WHERE e.idReserva = r.idReserva AND q.tipoQuarto = 'Suíte'
  );

   
-- Descrição: Fornece uma análise detalhada do desempenho das unidades, incluindo eficiência financeira, características dos quartos e engajamento de clientes.   
WITH UnidadeStats AS (
    SELECT u.idUnidade, u.nome AS nome_unidade, 
           COUNT(DISTINCT CASE WHEN r.dataCheckIn >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) THEN r.idReserva END) AS total_reservas,
           AVG(CASE WHEN r.dataCheckIn >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) THEN r.valorTotal END) AS valor_medio_reserva,
           (SELECT COUNT(*)
            FROM Funcionario f
            JOIN `é-empregado-por` ep ON f.idFunc = ep.idFunc
            WHERE ep.idUnidade = u.idUnidade) AS total_funcionarios
    FROM Unidade u
    LEFT JOIN Quarto q ON u.idUnidade = q.idUnidade
    LEFT JOIN engloba e ON q.idQuarto = e.idQuarto
    LEFT JOIN Reserva r ON e.idReserva = r.idReserva
    LEFT JOIN Atrativo a ON u.idUnidade = a.idUnidade
    GROUP BY u.idUnidade, u.nome
)
SELECT us.nome_unidade, 
       COALESCE(us.total_reservas, 0) AS total_reservas, 
       COALESCE(us.valor_medio_reserva, 0) AS valor_medio_reserva, 
       COALESCE(us.total_funcionarios, 0) AS total_funcionarios,
       CASE 
           WHEN us.total_funcionarios > 0 THEN (us.total_reservas * COALESCE(us.valor_medio_reserva, 0) / us.total_funcionarios)
           ELSE 0
       END AS receita_por_funcionario,
       RANK() OVER (ORDER BY 
           CASE 
               WHEN us.total_funcionarios > 0 THEN (us.total_reservas * COALESCE(us.valor_medio_reserva, 0) / us.total_funcionarios)
               ELSE 0
           END DESC
       ) AS ranking_eficiencia,
       COALESCE((SELECT AVG(q.numCamas)
                 FROM Quarto q
                 WHERE q.idUnidade = us.idUnidade), 0) AS media_camas_por_quarto,
       COALESCE((SELECT COUNT(DISTINCT c.idCliente)
                 FROM Cliente c
                 JOIN Reserva r ON c.idCliente = r.idCliente
                 JOIN engloba e ON r.idReserva = e.idReserva
                 JOIN Quarto q ON e.idQuarto = q.idQuarto
                 WHERE q.idUnidade = us.idUnidade
                   AND r.dataCheckIn >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)), 0) AS clientes_unicos_ultimo_ano
FROM UnidadeStats us
ORDER BY receita_por_funcionario DESC;

 
 