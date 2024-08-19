-- Inserções na tabela Funcionario
INSERT INTO `rede-hoteis`.`Funcionario` (nome, salario, logradouro, numero, CEP, bairro, cidade, estado, tipoFuncionario) VALUES
-- Gerentes
('Marco Aurélia', 3500.00, 'Rua A', 101, '12345678', 'Centro', 'São Paulo', 'SP', 'Gerente'),
('Julio Cesar', 3400.00, 'Rua B', 1010, '01234567', 'Centro', 'Manaus', 'AM', 'Gerente'),
('Franz Kafka', 3100.00, 'Rua C', 404, '45678901', 'Copacabana', 'Salvador', 'BA', 'Gerente'),
-- Cozinheiros
('Erick Jacquin', 2800.00, 'Rua D', 303, '34567890', 'Vila Madalena', 'Belo Horizonte', 'MG', 'Cozinheiro'),
('Paola Carosella', 3200.00, 'Rua E', 707, '78901234', 'Centro', 'Porto Alegre', 'RS', 'Cozinheiro'),
-- Instrutores
('Ramon Dino', 3300.00, 'Rua I', 909, '90123456', 'Vila Mariana', 'Recife', 'PE', 'Instrutor'),
('Renato Cariani', 3600.00, 'Rua J', 132, '54321123', 'Funcionarios', 'Belo Horizonte', 'MG', 'Instrutor'),
-- Atendentes
('Juscelino Kubitschek', 2500.00, 'Avenida K', 202, '23456789', 'Jardins', 'Rio de Janeiro', 'RJ', 'Atendente'),
('Getúlio Vargas', 2200.00, 'Rua L', 606, '67890123', 'Leblon', 'Curitiba', 'PR', 'Atendente'),
-- Faxineiros
('Taylor Swift', 3000.00, 'Avenida M', 505, '56789012', 'Ipanema', 'Brasília', 'DF', 'Faxineiro'),
('Gusttavo Lima', 2700.00, 'Avenida N', 900, '12312312', 'Centro', 'Santos', 'SP', 'Faxineiro');

-- Inserções na tabela Cliente
INSERT INTO `rede-hoteis`.`Cliente` (CPF, nome, logradouro, numero, CEP, bairro, cidade, estado) VALUES
('12345678901', 'Pedro Militão', 'Rua Z', 111, '65432109', 'Centro', 'São Paulo', 'SP'),
('23456789012', 'Otávio Sbampato', 'Avenida Y', 222, '76543210', 'Jardins', 'Rio de Janeiro', 'RJ'),
('34567890123', 'Gabriel Coelho', 'Rua X', 333, '87654321', 'Vila Madalena', 'Belo Horizonte', 'MG'),
('45678901234', 'Henrique Cesar', 'Rua W', 444, '98765432', 'Copacabana', 'Salvador', 'BA'),
('56789012345', 'Isac Cunha', 'Avenida V', 555, '09876543', 'Ipanema', 'Brasília', 'DF'),
('67890123456', 'Fulano da Silva', 'Rua U', 666, '10987654', 'Leblon', 'Curitiba', 'PR'),
('78901234567', 'Ciclano Ribeiro', 'Rua T', 777, '21098765', 'Centro', 'Porto Alegre', 'RS'),
('89012345678', 'Beltrano Ferreira', 'Avenida S', 888, '32109876', 'Jardins', 'Fortaleza', 'CE'),
('90123456789', 'John Doe', 'Rua R', 999, '43210987', 'Vila Mariana', 'Recife', 'PE'),
('01234567890', 'Jane Doe', 'Rua Q', 1000, '54321098', 'Centro', 'Manaus', 'AM');

-- Inserções na tabela Unidade
INSERT INTO `rede-hoteis`.`Unidade` (nome, logradouro, numero, CEP, bairro, cidade, estado, dataInicio, idGerente) VALUES
('Hotel Mercurio', 'Rua AZ', 111, '12309876', 'Centro', 'São Paulo', 'SP', '2020-01-01', 1),
('Hotel Venus', 'Avenida BY', 222, '23410987', 'Jardins', 'Rio de Janeiro', 'RJ', '2020-02-01', 1),
('Hotel Terra', 'Rua CX', 333, '34521098', 'Vila Madalena', 'Belo Horizonte', 'MG', '2020-03-01', 1),
('Hotel Marte', 'Rua DW', 444, '45632109', 'Copacabana', 'Salvador', 'BA', '2020-04-01', 2),
('Hotel Jupiter', 'Avenida EV', 555, '56743210', 'Ipanema', 'Brasília', 'DF', '2020-05-01', 2),
('Hotel Saturno', 'Rua FU', 666, '67854321', 'Leblon', 'Curitiba', 'PR', '2020-06-01', 2),
('Hotel Urano', 'Avenida GT', 777, '78965432', 'Centro', 'Porto Alegre', 'RS', '2020-07-01', 3),
('Hotel Netuno', 'Rua HS', 888, '89076543', 'Jardins', 'Fortaleza', 'CE', '2020-08-01', 3),
('Hotel Plutão', 'Avenida IR', 999, '90187654', 'Vila Mariana', 'Recife', 'PE', '2020-09-01', 3),
('Hotel Sol', 'Rua JQ', 1000, '01298765', 'Centro', 'Manaus', 'AM', '2020-10-01', 1);

-- Inserções na tabela Quarto
INSERT INTO `rede-hoteis`.`Quarto` (idUnidade, numQuarto, numCamas, disponibilidade, tipoQuarto) VALUES
-- Disponíveis
(1, 101, 2, 'D', 'Simples'),
(1, 102, 1, 'D', 'Simples'),
(2, 201, 2, 'D', 'Suíte'),
(2, 202, 3, 'D', 'Suíte'),
(3, 301, 4, 'D', 'Suíte'),
(3, 302, 2, 'D', 'Simples'),
(4, 401, 3, 'D', 'Suíte'),
(4, 402, 1, 'D', 'Simples'),
(5, 501, 2, 'D', 'Simples'),
(5, 502, 1, 'D', 'Simples'),
-- Indisponíveis
(1, 300, 1, 'I', 'Suíte'),
(2, 901, 2, 'I', 'Simples'),
(2, 902, 1, 'I', 'Simples');

-- Inserções na tabela Atrativo
INSERT INTO `rede-hoteis`.`Atrativo` (nomeAtrativo, idUnidade, numAtrativo) VALUES
-- Academias
('Academia Primavera', 1, 100),
('Academia Verão', 1, 101),
('Academia Outono', 2, 200),
('Academia Inverno', 2, 201),
('Academia Estação', 3, 100),
-- Restaurantes
('Restaurante Chinês', 4, 101),
('Restaurante Alemão', 5, 900),
('Cozinha Árabe', 8, 901),
('Cozinha Brasileira', 9, 800),
('Restaurante Kids', 10, 801);

-- Inserções na tabela Reserva
INSERT INTO `rede-hoteis`.`Reserva` (idReserva, valorTotal, dataCheckIn, dataCheckOut, idCliente) VALUES
('R001', 1200.00, '2024-08-01', '2024-08-05', 1),
('R002', 800.00, '2024-08-02', '2024-08-06', 2),
('R003', 1500.00, '2024-08-03', '2024-08-07', 3),
('R004', 1100.00, '2024-08-04', '2024-08-08', 4),
('R005', 900.00, '2024-08-05', '2024-08-09', 5),
('R006', 1300.00, '2024-08-06', '2024-08-10', 6),
('R007', 1400.00, '2024-08-07', '2024-08-11', 7),
('R008', 1000.00, '2024-08-08', '2024-08-12', 8),
('R009', 1100.00, '2024-08-09', null, 9),
('R010', 1250.00, '2024-08-10', null, 10);

-- Inserções na tabela engloba
INSERT INTO `rede-hoteis`.`engloba` (idReserva, idQuarto) VALUES
('R001', 1),
('R002', 2),
('R003', 4),
('R004', 5),
('R005', 6),
('R006', 7),
('R007', 9),
('R008', 10),
('R009', 11),
('R010', 12),
('R010', 13);

-- Inserções na tabela Telefone
INSERT INTO `rede-hoteis`.`Telefone` (idCliente, telefone) VALUES
-- Mais de 1 (por cliente)
(1, '11987654321'),
(1, '11121314151'),
(1, '21222324252'),
(2, '31323334353'),
(2, '41424344454'),
(3, '51525354555'),
(3, '61626364656'),
-- Apenas 1 (por cliente)
(4, '41987654321'),
(5, '51987654321'),
(6, '61987654321'),
(7, '71987654321'),
(8, '81987654321'),
(9, '91987654321'),
(10, '01987654321');

-- Inserções na tabela Academia
INSERT INTO `rede-hoteis`.`Academia` (idAtrativo, numAparelhos) VALUES
(1, 10),
(2, 13),
(3, 15),
(4, 7),
(5, 6);

-- Inserções na tabela Restaurante
INSERT INTO `rede-hoteis`.`Restaurante` (idAtrativo, estrelas, numMesas) VALUES
(6, 5, 9),
(7, 3, 12),
(8, 4, 15),
(9, 5, 10),
(10, 2, 8);

-- Inserções na tabela trabalha-em-restaurante
INSERT INTO `rede-hoteis`.`trabalha-em-restaurante` (idAtrativo, idFunc) VALUES
(6, 4),   -- Cozinheiro
(7, 5),   -- Cozinheiro
(8, 5);
-- Inserções na tabela trabalha-em-academia
INSERT INTO `rede-hoteis`.`trabalha-em-academia` (idAtrativo, idFunc) VALUES
(1, 6),   -- Instrutor
(2, 7),   -- Instrutor
(3, 7);   -- Instrutor

-- Inserções na tabela é-empregado-por
INSERT INTO `rede-hoteis`.`é-empregado-por` (idUnidade, idFunc) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10); 



