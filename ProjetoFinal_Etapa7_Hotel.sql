/* =========================================================
PROJETO BANCO DE DADOS – SISTEMA DE RESERVA DE HOTEL
SCRIPT COMPLETO (DDL + DML + VIEWS + TRIGGERS + PROCEDURES)
   ========================================================= */


/* =========================================================
DDL – CRIAÇÃO DAS TABELAS
   ========================================================= */

-- Criação da tabela de hóspedes
CREATE TABLE hospedes (
    id_hospede SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    documento VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20)
);

-- Criação da tabela de quartos
CREATE TABLE quartos (
    id_quarto SERIAL PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE,
    tipo VARCHAR(10) NOT NULL,
    capacidade INTEGER NOT NULL,
    tarifa_base NUMERIC(10,2) NOT NULL,
    status VARCHAR(15) NOT NULL DEFAULT 'DISPONIVEL',

    CONSTRAINT chk_tipo_quarto 
    CHECK (tipo IN ('SIMPLES','DUPLO','LUXO')),

    CONSTRAINT chk_status_quarto 
    CHECK (status IN ('DISPONIVEL','OCUPADO','MANUTENCAO','BLOQUEADO')),

    CONSTRAINT chk_capacidade 
    CHECK (capacidade > 0),

    CONSTRAINT chk_tarifa 
    CHECK (tarifa_base >= 0)
);

-- Criação da tabela de reservas
CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,

    id_hospede INTEGER NOT NULL,
    id_quarto INTEGER NOT NULL,

    data_entrada DATE NOT NULL DEFAULT CURRENT_DATE,
    data_saida DATE NOT NULL,

    numero_hospedes INTEGER NOT NULL,

    origem VARCHAR(10) NOT NULL,

    status VARCHAR(15) NOT NULL DEFAULT 'PENDENTE',

    valor_total NUMERIC(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_hospede
    FOREIGN KEY (id_hospede)
    REFERENCES hospedes(id_hospede)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

    CONSTRAINT fk_quarto
    FOREIGN KEY (id_quarto)
    REFERENCES quartos(id_quarto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

    CONSTRAINT chk_datas
    CHECK (data_saida > data_entrada),

    CONSTRAINT chk_num_hospedes
    CHECK (numero_hospedes > 0),

    CONSTRAINT chk_origem
    CHECK (origem IN ('SITE','TELEFONE','BALCAO')),

    CONSTRAINT chk_status_reserva
    CHECK (status IN ('PENDENTE','CONFIRMADA','CHECKIN','CHECKOUT','CANCELADA','NO_SHOW')),

    CONSTRAINT chk_valor
    CHECK (valor_total >= 0)
);


/* =========================================================
DML – INSERÇÃO DE DADOS DE TESTE
   ========================================================= */

-- Inserindo hóspedes
INSERT INTO hospedes (nome, documento, email, telefone) VALUES
('João Silva', '123456', 'joao@email.com', '999999999'),
('Maria Souza', '654321', 'maria@email.com', '988888888'),
('Pedro Oliveira', '111222', 'pedro@email.com', '977777777');

-- Inserindo quartos
INSERT INTO quartos (numero, tipo, capacidade, tarifa_base, status) VALUES
(101, 'SIMPLES', 1, 100.00, 'DISPONIVEL'),
(102, 'DUPLO', 2, 150.00, 'DISPONIVEL'),
(201, 'LUXO', 4, 300.00, 'DISPONIVEL');

-- Inserindo reservas
INSERT INTO reservas
(id_hospede, id_quarto, data_entrada, data_saida, numero_hospedes, origem, status, valor_total)
VALUES
(1, 1, '2026-03-15', '2026-03-17', 1, 'SITE', 'CONFIRMADA', 200.00),
(2, 2, '2026-03-18', '2026-03-20', 2, 'BALCAO', 'PENDENTE', 300.00),
(3, 3, '2026-03-21', '2026-03-25', 3, 'TELEFONE', 'CHECKIN', 900.00);


/* =========================================================
CONSULTAS DE TESTE
   ========================================================= */

-- Listar hóspedes
SELECT * FROM hospedes;

-- Listar quartos
SELECT * FROM quartos;

-- Listar reservas
SELECT * FROM reservas;


/* =========================================================
VIEWS
   ========================================================= */

-- View de reservas detalhadas
CREATE VIEW vw_reservas_detalhadas AS
SELECT
    r.id_reserva,
    h.nome AS hospede,
    h.email,
    q.numero AS numero_quarto,
    q.tipo AS tipo_quarto,
    r.data_entrada,
    r.data_saida,
    r.numero_hospedes,
    r.status,
    r.valor_total
FROM reservas r
JOIN hospedes h ON r.id_hospede = h.id_hospede
JOIN quartos q ON r.id_quarto = q.id_quarto;

-- Materialized view de relatório de quartos
CREATE MATERIALIZED VIEW mv_relatorio_quartos AS
SELECT
    q.id_quarto,
    q.numero,
    q.tipo,
    COUNT(r.id_reserva) AS total_reservas,
    SUM(r.valor_total) AS faturamento_total
FROM quartos q
LEFT JOIN reservas r ON q.id_quarto = r.id_quarto
GROUP BY q.id_quarto, q.numero, q.tipo;


/* =========================================================
TRIGGERS
   ========================================================= */

-- Função para validar valor da reserva
CREATE OR REPLACE FUNCTION fn_validar_valor_reserva()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.valor_total < 0 THEN
        NEW.valor_total := 0;
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

-- Trigger para validação de valor
CREATE TRIGGER trg_validar_valor_reserva
BEFORE INSERT OR UPDATE ON reservas
FOR EACH ROW
EXECUTE FUNCTION fn_validar_valor_reserva();


-- Função para atualizar status do quarto
CREATE OR REPLACE FUNCTION fn_atualizar_status_quarto()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.status = 'CHECKIN' THEN
        UPDATE quartos
        SET status = 'OCUPADO'
        WHERE id_quarto = NEW.id_quarto;

    ELSIF NEW.status = 'CHECKOUT' THEN
        UPDATE quartos
        SET status = 'DISPONIVEL'
        WHERE id_quarto = NEW.id_quarto;

    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar status
CREATE TRIGGER trg_atualizar_status_quarto
AFTER UPDATE OF status ON reservas
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_status_quarto();


/* =========================================================
PROCEDURES
   ========================================================= */

-- Procedure para cancelar reservas expiradas
CREATE OR REPLACE PROCEDURE cancelar_reservas_expiradas()
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE reservas
    SET status = 'CANCELADA'
    WHERE status = 'PENDENTE'
    AND data_entrada < CURRENT_DATE;

END;
$$;


/* =========================================================
OTIMIZAÇÃO – CRIAÇÃO DE ÍNDICES
   ========================================================= */

CREATE INDEX idx_reservas_id_hospede
ON reservas (id_hospede);

CREATE INDEX idx_reservas_data_entrada
ON reservas (data_entrada);

CREATE INDEX idx_reservas_id_quarto
ON reservas (id_quarto);


/* =========================================================
ANALISE DE PERFORMANCE
   ========================================================= */

-- Consulta simples
EXPLAIN
SELECT *
FROM reservas
WHERE id_hospede = 1;

-- Análise detalhada de execução
EXPLAIN ANALYZE
SELECT *
FROM reservas
WHERE id_quarto = 1;

-- Consulta com JOIN entre tabelas
EXPLAIN ANALYZE
SELECT
    h.nome,
    q.numero,
    r.data_entrada,
    r.data_saida
FROM reservas r
JOIN hospedes h ON r.id_hospede = h.id_hospede
JOIN quartos q ON r.id_quarto = q.id_quarto;