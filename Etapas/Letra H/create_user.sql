-- Criação de usuários
CREATE USER IF NOT EXISTS 'admin_hotel'@'localhost' IDENTIFIED BY 'senha_segura_admin123';
CREATE USER IF NOT EXISTS 'func_hotel'@'localhost' IDENTIFIED BY 'senha_segura_func456';

-- Revogar todos os privilégios existentes (para garantir um estado limpo)
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'admin_hotel'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'func_hotel'@'localhost';

-- Concessão de permissões para o administrador
GRANT ALL PRIVILEGES ON `rede-hoteis`.* TO 'admin_hotel'@'localhost';
GRANT GRANT OPTION ON `rede-hoteis`.* TO 'admin_hotel'@'localhost';

-- Restringir o privilégio DELETE na tabela Funcionario para o admin_hotel
GRANT SELECT, INSERT, UPDATE ON `rede-hoteis`.Funcionario TO 'admin_hotel'@'localhost';

-- Concessão de permissões para o funcionário regular
GRANT SELECT ON `rede-hoteis`.* TO 'func_hotel'@'localhost';
GRANT INSERT, UPDATE ON `rede-hoteis`.Reserva TO 'func_hotel'@'localhost';
GRANT INSERT ON `rede-hoteis`.Cliente TO 'func_hotel'@'localhost';
GRANT INSERT, UPDATE ON `rede-hoteis`.Telefone TO 'func_hotel'@'localhost';

-- Não concedemos nenhum privilégio específico na tabela Unidade para func_hotel

-- Aplicando as mudanças
FLUSH PRIVILEGES;

-- Verificação das permissões concedidas
SHOW GRANTS FOR 'admin_hotel'@'localhost';
SHOW GRANTS FOR 'func_hotel'@'localhost';