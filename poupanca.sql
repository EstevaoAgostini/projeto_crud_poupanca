-- 1. criando o banco
CREATE DATABASE IF NOT EXISTS poupanca
DEFAULT CHARACTER utf8
DEFAULT COLLATE utf8_general_ci;

USE poupanca;

-- 2. tabela de usuários
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. tabela das contas poupança
CREATE TABLE conta_poupanca (
    id_conta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    numero_conta VARCHAR(20) NOT NULL UNIQUE,
    saldo DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_conta_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
);

-- 4. tabela das transações
CREATE TABLE transacao (
    id_transacao INT AUTO_INCREMENT PRIMARY KEY,
    id_conta INT NOT NULL,
    tipo ENUM('DEPOSITO', 'SAQUE') NOT NULL,
    valor DECIMAL(12,2) NOT NULL,
    saldo_apos_transacao DECIMAL(12,2) NOT NULL,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_transacao_conta
        FOREIGN KEY (id_conta)
        REFERENCES conta_poupanca(id_conta)
        ON DELETE CASCADE,
);

-- 5. tabela dos logins de acesso
CREATE TABLE log_acesso (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip VARCHAR(45) NOT NULL,

    CONSTRAINT fk_log_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
);