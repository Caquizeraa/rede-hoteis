

SELECT F.idFunc, F.nome  FROM `rede-hoteis`.`Funcionario` F 
    JOIN `rede-hoteis`.`Unidade` U ON U.idGerente = F.idFunc
    GROUP BY F.idFunc, F.nome;