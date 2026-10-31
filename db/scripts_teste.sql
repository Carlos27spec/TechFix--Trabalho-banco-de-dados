-- ATIVA AS CHAVES ENTRAGEIRAS DO SQLITE
PRAGMA foreign_keys = 1;

-- Verifica se as chaves estrangeiras estao ativas.
PRAGMA foreign_keys;

CREATE TABLE cargo(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,
	status INTEGER NOT NULL DEFAULT 1
) STRICT;

CREATE TABLE funcionario (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_funcionario TEXT NOT NULL COLLATE NOCASE,
	id_cargo INTEGER NOT NULL,
	status INTEGER  NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT ( DATETIME('now', 'localtime')),
	FOREIGN KEY (id_cargo) REFERENCES cargo(id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE (id, id_cargo)
) STRICT;

INSERT INTO cargo (nome_cargo) VALUES ('Gerente'), ('Atendente'), ('Técnico');

-- 1 Gerente
INSERT INTO funcionario (nome_funcionario, id_cargo, status)
VALUES ('Carlos Andrade', (SELECT id FROM cargo WHERE nome_cargo = 'Gerente'), 1);

-- 2 Atendentes
INSERT INTO funcionario (nome_funcionario, id_cargo, status)
VALUES 
('Fernanda Souza', (SELECT id FROM cargo WHERE nome_cargo = 'Atendente'), 1),
('Rafael Lima',    (SELECT id FROM cargo WHERE nome_cargo = 'Atendente'), 1);	

-- 3 Técnicos
INSERT INTO funcionario (nome_funcionario, id_cargo, status)
VALUES 
('João Pereira',   (SELECT id FROM cargo WHERE nome_cargo = 'Técnico'), 1),
('Marcos Vieira',  (SELECT id FROM cargo WHERE nome_cargo = 'Técnico'), 1),
('Bruno Costa',    (SELECT id FROM cargo WHERE nome_cargo = 'Técnico'), 1);

CREATE TABLE cliente (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_cliente TEXT NOT NULL COLLATE NOCASE,
	email TEXT NOT NULL COLLATE NOCASE UNIQUE,
	status INTEGER  NOT NULL DEFAULT 1,
	id_funcionario INTEGER NOT NULL ,
	-- CHECK: Avalia o usuário inserido tem o id de cargo definido na tabela de funcionário
	id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
	data_cadastro TEXT NOT NULL DEFAULT ( DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;


INSERT INTO cliente (nome_cliente, email, id_funcionario, id_funcionario_cargo)
VALUES ('Marcos', 'marcos@gmail.com', 3, (SELECT id_cargo FROM funcionario WHERE id = 3));
('Ana Souza',  'ana@gmail.com',   2, 2),
('Pedro Lima', 'pedro@gmail.com', 3, 2);

CREATE TABLE categoria (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_categoria TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_funcionario INTEGER NOT NULL, 
	id_funcionario_cargo INTEGER NOT NULL CHECK  (id_funcionario_cargo = 1),
	status INTEGER NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('computadores', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('celulares', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('smart tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('redes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('videogames', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('áudio', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('recuperação de dados', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('eletrônica avançada', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('informática', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('insumos', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('acessórios', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('telas', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('baterias', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('componentes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('carcaças', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

CREATE TABLE servico (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_servico TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_categoria INTEGER NOT NULL,
	preco INTEGER NOT NULL,
	horas_trabalho REAL NOT NULL,
	id_funcionario INTEGER NOT NULL, 
	id_funcionario_cargo INTEGER NOT NULL CHECK  (id_funcionario_cargo = 1),
	status INTEGER NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo),
	FOREIGN KEY (id_categoria) REFERENCES categoria(id)
) STRICT;

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Formatação e Instalação de Sistema Operacional', 1, 12000, 2.0, 1, 1);

-- Computadores (id 1)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Formatação e Instalação de Sistema Operacional', 1, 12000, 2.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Limpeza Interna e Troca de Pasta Térmica', 1, 15000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Upgrade de Hardware (RAM/SSD)', 1, 8000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Remoção de Vírus e Malwares', 1, 10000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Tela de Notebook', 1, 18000, 1.5, 1, 1);

-- Celulares (id 2)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Display/Frontal de Celular', 2, 15000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Bateria de Smartphone', 2, 9000, 0.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Desoxidação após Contato com Líquido', 2, 20000, 3.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo em Conector de Carga (Micro USB / Type-C)', 2, 11000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Vidro Traseiro de Smartphone a Laser / Manual', 2, 18000, 2.5, 1, 1);

-- Smart TVs (id 3)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Barra de LED de Smart TV', 3, 35000, 3.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo na Placa Principal de Smart TV', 3, 28000, 2.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Conserto de Fonte de Alimentação Interna (TV)', 3, 22000, 2.0, 1, 1);

-- Redes (id 4)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Configuração de Rede e Roteador Wi-Fi', 4, 9000, 1.0, 1, 1);

-- Videogames (id 5)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Higienização e Troca de Metal Líquido / Pasta Térmica (Console)', 5, 22000, 2.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo de Drift em Analógico de Controle (Joy-Con / DualSense / Xbox)', 5, 8000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Substituição de HDMI / Conector de Vídeo (Console)', 5, 25000, 2.5, 1, 1);

-- Áudio (id 6)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Bateria de Caixa de Som Portátil (Bluetooth)', 6, 12000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Almofadas / Reparo de Cabo de Headset Gamer', 6, 7000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo e Solda de Conector Jack P2/P10 de Mesa de Som ou Amplificador', 6, 9500, 1.0, 1, 1);

-- Recuperação de Dados (id 7)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Recuperação de Dados de HD / SSD / Pendrive Danificado', 7, 30000, 4.0, 1, 1);

-- Eletrônica Avançada (id 8)
INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Rebaling / Reparo de BGA em Placa Mãe ou Placa de Vídeo', 8, 45000, 5.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Gravação e Reprogramação de BIOS Eprom (Notebook / Desktop)', 8, 16000, 2.0, 1, 1);

CREATE TABLE peca (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_peca TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_categoria INTEGER NOT NULL,
	preco_sugerido INTEGER NOT NULL,
	estoque_real INTEGER NOT NULL,
	id_funcionario INTEGER NOT NULL, 
	id_funcionario_cargo INTEGER NOT NULL CHECK  (id_funcionario_cargo = 1),
	status INTEGER NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo),
	FOREIGN KEY (id_categoria) REFERENCES categoria(id)
) STRICT;

INSERT INTO peca (nome_peca, id_categoria, preco_sugerido, estoque_real, id_funcionario, id_funcionario_cargo)
VALUES
-- Informática / Computadores
('SSD NVMe 512GB M.2', 9, 26000, 15, 1, 1),
('SSD SATA III 480GB 2.5"', 9, 21000, 20, 1, 1),
('Memória RAM DDR4 8GB 2666MHz (Notebook)', 9, 17000, 12, 1, 1),
('Memória RAM DDR4 16GB 3200MHz (Desktop)', 9, 32000, 8, 1, 1),
('Pasta Térmica de Alta Performance (Bisnaga 4g)', 10, 6000, 25, 1, 1),
('Fonte ATX 500W 80 Plus Bronze', 9, 34000, 6, 1, 1),
('Bateria Célula Moeda CR2032 (Cartela c/ 5)', 10, 2500, 30, 1, 1),
('Cooler para Processador Socket Universal', 9, 9500, 10, 1, 1),
('Cabo SATA III 6Gbps 50cm', 11, 1500, 50, 1, 1),
('Tela LED 15.6" Slim 30 Pinos Full HD', 12, 48000, 5, 1, 1),

-- Smartphones / Celulares
('Display Frontal Completo iPhone 11', 12, 35000, 4, 1, 1),
('Display Frontal Completo Samsung Galaxy A54', 12, 31000, 6, 1, 1),
('Display Frontal Completo Motorola Moto G84', 12, 28000, 5, 1, 1),
('Bateria Compatível iPhone 11 (3110mAh)', 13, 16000, 8, 1, 1),
('Bateria Compatível Samsung Galaxy A32', 13, 13000, 7, 1, 1),
('Bateria Compatível Moto G30', 13, 12000, 6, 1, 1),
('Conector de Carga Type-C Universal (Unidade)', 14, 2000, 100, 1, 1),
('Conector de Carga Micro USB V8', 14, 1500, 100, 1, 1),
('Flex de Carga e Microfone Moto G9 Play', 14, 5500, 10, 1, 1),
('Tampa Traseira de Vidro iPhone 12', 15, 11000, 4, 1, 1),
('Câmera Traseira Principal Redmi Note 11', 14, 14000, 3, 1, 1),
('Alto-Falante Auricular Universal', 14, 2500, 40, 1, 1),

-- Smart TVs
('Barra de LED TV Samsung 50" (Kit com 3 barras)', 16, 23000, 4, 1, 1),
('Barra de LED TV LG 43" (Kit com 3 barras)', 16, 19500, 5, 1, 1),
('Placa Fonte TV Samsung UN50TU8000', 16, 31000, 2, 1, 1),
('Placa Principal TV LG 43UP7500', 16, 42000, 2, 1, 1),
('Cabo Flat T-Con para Display TV 55"', 16, 6500, 8, 1, 1),
('Receptor Infravermelho para Controle Remoto TV', 14, 2000, 15, 1, 1),

-- Insumos e Componentes Genéricos
('Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)', 10, 15000, 3, 1, 1),
('Álcool Isopropílico 99.8% 1 Litro', 10, 4500, 12, 1, 1),
('Fita Kapton Térmica 10mm x 33m', 10, 3000, 15, 1, 1),
('Fita Dupla Face Fixação de Telas (3mm x 50m)', 10, 3500, 10, 1, 1),
('Fusível de Louça 5A 250V (Pacote c/ 10)', 14, 1800, 20, 1, 1),
('Capacitor Eletrolítico 1000uF x 25V', 14, 500, 150, 1, 1);

CREATE VIEW vw_preco_venda_maior_1000 AS SELECT 	id, nome_peca, preco_venda, estoque_real FROM peca p WHERE p.preco_venda >= 10000;
--
--DROP VIEW IF EXISTS vw_preco_venda_maior_1000;
--
--CREATE VIEW vw_preco_sugerido_maior_1000 AS
--SELECT id, nome_peca, preco_sugerido, estoque_real
--FROM peca
--WHERE preco_sugerido >= 10000;

CREATE TABLE modelo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_modelo TEXT NOT NULL COLLATE NOCASE,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE tipo (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_tipo TEXT NOT NULL COLLATE NOCASE,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE marca (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_marca TEXT NOT NULL COLLATE NOCASE,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE equipamento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_tipo INTEGER NOT NULL,
    id_marca INTEGER NOT NULL,
    id_modelo INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    numero_serie TEXT COLLATE NOCASE,
    imei TEXT COLLATE NOCASE UNIQUE,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_tipo) REFERENCES tipo(id),
	FOREIGN KEY (id_marca) REFERENCES marca(id),
    FOREIGN KEY (id_modelo) REFERENCES modelo(id),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE ordem (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	descricao_defeito TEXT NOT NULL,
	defeito_constatado TEXT COLLATE NOCASE,
	valor_total INTEGER,
	id_equipamento INTEGER NOT NULL,
	id_forma_pagamento INTEGER NOT NULL,
	id_funcionario_abertura INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
	id_situacao_atual INTEGER NOT NULL,
	id_tecnico INTEGER NOT NULL,
	id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
	data_fechamento TEXT, --TRIGGER para registrar a DATA de alteração
	data_abertura TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_situacao_atual) REFERENCES situacao (id),
	FOREIGN KEY (id_equipamento) REFERENCES equipamento(id),
	FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id),
	FOREIGN KEY (id_funcionario_abertura, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo),
    FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT; 

CREATE TABLE forma_pagamento (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_forma_pagamento TEXT NOT NULL COLLATE NOCASE,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL,
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
)STRICT;


CREATE TABLE ordem_pagamento(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	id_ordem INTEGER NOT NULL,
	id_forma_pagamento INTEGER NOT NULL,
	FOREIGN KEY (id_ordem) REFERENCES ordem (id),
	FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id)
)STRICT;

CREATE TABLE situacao (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_situacao TEXT NOT NULL COLLATE NOCASE UNIQUE,
	status INTEGER NOT NULL DEFAULT 1
) STRICT;

CREATE TABLE ordem_situacao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ordem INTEGER NOT NULL,
    id_nova_situacao INTEGER NOT NULL DEFAULT 1,
    id_funcionario INTEGER NOT NULL,
    data_situacao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_ordem) REFERENCES ordem(id),
    FOREIGN KEY (id_nova_situacao) REFERENCES situacao(id),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id)
) STRICT;


CREATE TABLE ordem_peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ordem INTEGER NOT NULL,
    id_peca INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    valor_unitario INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
    data_situacao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_ordem) REFERENCES ordem(id),
    FOREIGN KEY (id_peca) REFERENCES peca(id),
    FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT; 

CREATE TABLE ordem_servico (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ordem INTEGER NOT NULL,
    id_servico INTEGER NOT NULL,
    quantidade_servico INTEGER NOT NULL,
    preco_praticado INTEGER NOT NULL,
    data_execucao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_ordem) REFERENCES ordem(id),
    FOREIGN KEY (id_servico) REFERENCES servico(id)
) STRICT;

INSERT INTO situacao (nome_situacao, status) VALUES
('Aberta', 1),
('Em análise', 1),
('Aguardando peça', 1),
('Em manutenção', 1),
('Aguardando aprovação', 1),
('Concluída', 1),
('Cancelada', 1),
('Entregue', 1);

INSERT INTO modelo
(nome_modelo, id_funcionario, id_funcionario_cargo, status)
VALUES
('Galaxy S23', 1, 1, 1),
('iPhone 13', 1, 1, 1),
('Redmi Note 12', 2, 2, 1),
('Moto G84', 2, 2, 1),
('Galaxy A54', 1, 1, 1),
('iPhone 15', 1, 1, 1);

INSERT INTO tipo
(nome_tipo, id_funcionario, id_funcionario_cargo, status)
VALUES
('Smartphone', 1, 1, 1),
('Notebook', 1, 1, 1),
('Tablet', 2, 2, 1),
('Smartwatch', 2, 2, 1),
('Computador', 1, 1, 1);

INSERT INTO marca
(nome_marca, id_funcionario, id_funcionario_cargo, status)
VALUES
('Samsung', 1, 1, 1),
('Apple', 1, 1, 1),
('Xiaomi', 2, 2, 1),
('Motorola', 2, 2, 1),
('Lenovo', 1, 1, 1),
('Acer', 2, 2, 1);

INSERT INTO equipamento
(id_tipo, id_marca, id_modelo, id_cliente, numero_serie, imei,
 id_funcionario, id_funcionario_cargo, status)
VALUES
(1, 1, 1, 1, 'SN-S23-001', '111111111111111', 1, 1, 1),
(1, 2, 2, 2, 'SN-IP13-002', '222222222222222', 1, 1, 1),
(1, 3, 3, 3, 'SN-RN12-003', '333333333333333', 2, 2, 1),
(1, 4, 4, 1, 'SN-MG84-004', '444444444444444', 2, 2, 1),
(1, 1, 5, 2, 'SN-A54-005', '555555555555555', 1, 1, 1);

INSERT INTO forma_pagamento
(nome_forma_pagamento, id_funcionario, id_funcionario_cargo, status)
VALUES
('Dinheiro', 1, 1, 1),
('Cartão de crédito', 1, 1, 1),
('Cartão de débito', 2, 2, 1),
('PIX', 2, 2, 1),
('Transferência bancária', 1, 1, 1);

INSERT INTO ordem
(descricao_defeito, defeito_constatado, valor_total,
 id_equipamento, id_forma_pagamento,
 id_funcionario_abertura, id_funcionario_cargo,
 id_situacao_atual, id_tecnico, id_tecnico_cargo)
VALUES
('Celular não liga',                        'Falha na bateria',            25000, 1, 4, 1, 1, 1, 4, 3),
('Tela quebrada',                           'Display danificado',          45000, 2, 2, 1, 1, 2, 5, 3),
('Celular desligando sozinho',              'Problema na placa',           30000, 3, 4, 2, 2, 4, 6, 3),
('Aparelho com problema no carregamento',   'Conector de carga danificado',18000, 4, 1, 2, 2, 3, 4, 3);

INSERT INTO ordem_pagamento
(id_ordem, id_forma_pagamento)
VALUES
(1, 4),
(2, 2),
(3, 4),
(4, 1);

INSERT INTO ordem_situacao (id_ordem, id_nova_situacao, id_funcionario)
VALUES
(1, 1, 2),
(1, 2, 4),  
(2, 1, 2),
(2, 2, 5),
(3, 1, 3),
(3, 4, 6),
(4, 1, 3),
(4, 3, 4);

INSERT INTO ordem_peca (
    id_ordem,
    id_peca,
    quantidade,
    valor_unitario,
    id_tecnico,
    id_tecnico_cargo
) VALUES
(1, 1, 1, 15000, 4, 3),
(2, 2, 1, 30000, 5, 3),
(3, 3, 1, 12000, 6, 3),
(4, 1, 1, 8000, 4, 3);

INSERT INTO ordem_servico (id_ordem, id_servico, quantidade_servico, preco_praticado)
VALUES
(1, 1, 1, 10000),
(2, 2, 1, 15000),
(3, 3, 1, 18000),
(4, 1, 1, 10000);

SELECT 'ordem' AS tabela, COUNT(*) FROM ordem
UNION ALL SELECT 'equipamento', COUNT(*) FROM equipamento
UNION ALL SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL SELECT 'forma_pagamento', COUNT(*) FROM forma_pagamento
UNION ALL SELECT 'situacao', COUNT(*) FROM situacao
UNION ALL SELECT 'funcionario', COUNT(*) FROM funcionario;

SELECT 'tipo', COUNT(*) FROM tipo
UNION ALL SELECT 'marca', COUNT(*) FROM marca
UNION ALL SELECT 'modelo', COUNT(*) FROM modelo;

CREATE TABLE entrada_peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_peca INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_de_compra INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_peca) REFERENCES peca(id),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE saida_peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_peca INTEGER NOT NULL,
    quantidade_saida INTEGER NOT NULL,
    preco_de_compra INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
    data_saida TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_peca) REFERENCES peca(id),
    FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

--DROP TRIGGER IF EXISTS trg_ai_ordem_servico_atualiza_valor_total_ordem;

CREATE TRIGGER trg_ai_ordem_servico_atualiza_valor_total_ordem
AFTER INSERT ON ordem_servico
FOR EACH ROW
BEGIN
    UPDATE ordem
    SET valor_total = COALESCE(valor_total,0) + (NEW.preco_praticado * NEW.quantidade_servico)
    WHERE id = NEW.id_ordem;
END;

INSERT INTO ordem_servico (id_ordem, id_servico, preco_praticado, quantidade_servico)
VALUES (1,6, (SELECT preco FROM servico s WHERE id = 6), 1); 

--DROP TRIGGER IF EXISTS trg_ad_ordem_servico_atualiza_valor_total_ordem;

CREATE TRIGGER trg_ad_ordem_servico_atualiza_valor_total_ordem
AFTER DELETE ON ordem_servico
FOR EACH ROW
BEGIN
    UPDATE ordem
    SET valor_total = COALESCE(valor_total,0) - (OLD.preco_praticado * OLD.quantidade_servico)
    WHERE id = OLD.id_ordem;
END;

CREATE TRIGGER trg_au_ordem_servico_atualiza_valor_total_ordem
AFTER UPDATE OF id_ordem, quantidade_servico, preco_praticado ON ordem_servico
FOR EACH ROW
BEGIN
    UPDATE ordem SET valor_total = COALESCE(valor_total,0) - (OLD.preco_praticado * OLD.quantidade_servico)
    WHERE id = OLD.id_ordem;
    UPDATE ordem SET valor_total = COALESCE(valor_total,0) + (NEW.preco_praticado * NEW.quantidade_servico)
    WHERE id = NEW.id_ordem;
END;

--DROP TRIGGER trg_bi_ordem_peca_valida_estoque;

CREATE TRIGGER trg_bi_ordem_peca_valida_estoque
BEFORE INSERT ON ordem_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Quantidade deve ser maior que zero.')
    WHERE NEW.quantidade <= 0;

    SELECT RAISE(ABORT, 'Ordem encerrada: não é possível adicionar peças.')
    WHERE (SELECT data_fechamento FROM ordem WHERE id = NEW.id_ordem) IS NOT NULL;

    SELECT RAISE(ABORT, 'Peça inativa ou inexistente.')
    WHERE (SELECT status FROM peca WHERE id = NEW.id_peca) IS NOT 1;

    SELECT RAISE(ABORT, 'Estoque insuficiente para a quantidade solicitada.')
    WHERE (SELECT estoque_real FROM peca WHERE id = NEW.id_peca) < NEW.quantidade;
END;

--DROP TRIGGER trg_ai_ordem_peca_baixa_estoque_soma_total

CREATE TRIGGER trg_ai_ordem_peca_baixa_estoque_soma_total
AFTER INSERT ON ordem_peca
FOR EACH ROW
BEGIN
    UPDATE peca SET estoque_real = estoque_real - NEW.quantidade WHERE id = NEW.id_peca;
    UPDATE ordem
    SET valor_total = COALESCE(valor_total,0) + (NEW.quantidade * NEW.valor_unitario)
    WHERE id = NEW.id_ordem;
END;

--DROP TRIGGER trg_ad_ordem_peca_devolve_estoque_subtrai_total

CREATE TRIGGER trg_ad_ordem_peca_devolve_estoque_subtrai_total
AFTER DELETE ON ordem_peca
FOR EACH ROW 
BEGIN
	UPDATE peca SET estoque_real = estoque_real + OLD.quantidade WHERE id = OLD.id_peca;
	UPDATE ordem
	SET valor_total = COALESCE(valor_total,0) - (OLD.quantidade * OLD.valor_unitario)
	WHERE id = OLD.id_ordem;
END;

--DROP TRIGGER trg_bu_ordem_peca_valida

CREATE TRIGGER trg_bu_ordem_peca_valida
BEFORE UPDATE ON ordem_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Não é permitido trocar ordem ou peça; exclua e insira novamente.')
    WHERE NEW.id_ordem <> OLD.id_ordem OR NEW.id_peca <> OLD.id_peca;

    SELECT RAISE(ABORT, 'Estoque insuficiente.')
    WHERE NEW.quantidade <= 0
       OR (SELECT estoque_real FROM peca WHERE id = NEW.id_peca) + OLD.quantidade < NEW.quantidade;
END;

--DROP TRIGGER trg_au_ordem_peca_ajusta_estoque_total

CREATE TRIGGER trg_au_ordem_peca_ajusta_estoque_total
AFTER UPDATE ON ordem_peca
FOR EACH ROW
BEGIN
    UPDATE peca SET estoque_real = estoque_real + OLD.quantidade - NEW.quantidade
    WHERE id = NEW.id_peca;
    UPDATE ordem
    SET valor_total = COALESCE(valor_total,0)
                    - (OLD.quantidade * OLD.valor_unitario)
                    + (NEW.quantidade * NEW.valor_unitario)
    WHERE id = NEW.id_ordem;
END;

--DROP TRIGGER trg_ai_entrada_peca_soma_estoque

CREATE TRIGGER trg_ai_entrada_peca_soma_estoque
AFTER INSERT ON entrada_peca
FOR EACH ROW
BEGIN
    UPDATE peca SET estoque_real = estoque_real + NEW.quantidade WHERE id = NEW.id_peca;
END;

--DROP TRIGGER trg_bi_saida_peca_valida_estoque

CREATE TRIGGER trg_bi_saida_peca_valida_estoque
BEFORE INSERT ON saida_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Peça inativa ou inexistente.')
    WHERE (SELECT status FROM peca WHERE id = NEW.id_peca) IS NOT 1;
    SELECT RAISE(ABORT, 'Estoque insuficiente.')
    WHERE NEW.quantidade_saida <= 0
       OR (SELECT estoque_real FROM peca WHERE id = NEW.id_peca) < NEW.quantidade_saida;
END;

--DROP TRIGGER trg_ai_saida_peca_baixa_estoque

CREATE TRIGGER trg_ai_saida_peca_baixa_estoque
AFTER INSERT ON saida_peca
FOR EACH ROW
BEGIN
    UPDATE peca SET estoque_real = estoque_real - NEW.quantidade_saida WHERE id = NEW.id_peca;
END;

--DROP TRIGGER trg_ai_ordem_registra_situacao_inicial

CREATE TRIGGER trg_ai_ordem_registra_situacao_inicial
AFTER INSERT ON ordem
FOR EACH ROW
BEGIN
    INSERT INTO ordem_situacao (id_ordem, id_nova_situacao, id_funcionario)
    VALUES (NEW.id, NEW.id_situacao_atual, NEW.id_funcionario_abertura);
END;

--DROP TRIGGER trg_ai_ordem_situacao_atualiza_ordem

CREATE TRIGGER trg_ai_ordem_situacao_atualiza_ordem
AFTER INSERT ON ordem_situacao
FOR EACH ROW
BEGIN
    UPDATE ordem SET id_situacao_atual = NEW.id_nova_situacao WHERE id = NEW.id_ordem;
END;

--DROP TRIGGER trg_au_ordem_registra_data_fechamento

CREATE TRIGGER trg_au_ordem_registra_data_fechamento
AFTER UPDATE OF id_situacao_atual ON ordem
FOR EACH ROW
BEGIN
    UPDATE ordem
    SET data_fechamento = CASE WHEN NEW.id_situacao_atual IN (7, 8)
                               THEN DATETIME('now','localtime') ELSE NULL END
    WHERE id = NEW.id;
END;

--DROP TRIGGER trg_bi_ordem_servico_valida

CREATE TRIGGER trg_bi_ordem_servico_valida
BEFORE INSERT ON ordem_servico
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Ordem encerrada.')
    WHERE (SELECT data_fechamento FROM ordem WHERE id = NEW.id_ordem) IS NOT NULL;
    SELECT RAISE(ABORT, 'Serviço inativo ou inexistente.')
    WHERE (SELECT status FROM servico WHERE id = NEW.id_servico) IS NOT 1;
    SELECT RAISE(ABORT, 'Quantidade deve ser maior que zero.')
    WHERE NEW.quantidade_servico <= 0;
END;

--DROP TRIGGER trg_bi_ordem_situacao_valida_ordem_aberta

CREATE TRIGGER trg_bi_ordem_situacao_valida_ordem_aberta
BEFORE INSERT ON ordem_situacao
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Ordem já encerrada.')
    WHERE (SELECT data_fechamento FROM ordem WHERE id = NEW.id_ordem) IS NOT NULL
      AND (SELECT COUNT(*) FROM ordem_situacao WHERE id_ordem = NEW.id_ordem) > 0;
END;

--DROP TRIGGER trg_bd_cliente_bloqueia_delete

CREATE TRIGGER trg_bd_cliente_bloqueia_delete
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Exclusão física não permitida. Use status = 0.');
END;


-- =====================================================================
-- TESTES DOS TRIGGERS (SQLite)
-- Rode DEPOIS do script completo (tabelas + seeds + triggers).
-- Pressupostos: ordens de exemplo 1 a 4 ja existem, entao as novas
-- ordens de teste serao a 5 e a 6 (confira no passo 1).
-- As secoes 6 e 7 testam ERROS: execute uma instrucao por vez,
-- pois o cliente SQL pode parar o script no primeiro erro.
-- =====================================================================
PRAGMA foreign_keys = 1;

-- ---------------------------------------------------------------------
-- 0) PRE-REQUISITO: clientes 2 e 3 (os equipamentos de exemplo usam)
--    As linhas soltas depois do INSERT do cliente 'Marcos' davam erro.
-- ---------------------------------------------------------------------
INSERT OR IGNORE INTO cliente (nome_cliente, email, id_funcionario, id_funcionario_cargo) VALUES
('Marcos',     'marcos@gmail.com', 3, 2),
('Ana Souza',  'ana@gmail.com',    2, 2),
('Pedro Lima', 'pedro@gmail.com',  3, 2);

-- Estoque inicial das pecas usadas nos testes (esperado: 17=100, 21=3, 22=40)
SELECT id, nome_peca, estoque_real FROM peca WHERE id IN (17, 21, 22);

-- ---------------------------------------------------------------------
-- 1) ABERTURA DE ORDEM  -> trg_ai_ordem_registra_situacao_inicial
--    Ordem 5 = ciclo completo | Ordem 6 = testes de erro
-- ---------------------------------------------------------------------
INSERT INTO ordem (descricao_defeito, defeito_constatado, valor_total,
                   id_equipamento, id_forma_pagamento,
                   id_funcionario_abertura, id_funcionario_cargo,
                   id_situacao_atual, id_tecnico, id_tecnico_cargo)
VALUES ('TESTE A - ciclo completo', NULL, 0, 5, 4, 2, 2, 1, 5, 3);

INSERT INTO ordem (descricao_defeito, defeito_constatado, valor_total,
                   id_equipamento, id_forma_pagamento,
                   id_funcionario_abertura, id_funcionario_cargo,
                   id_situacao_atual, id_tecnico, id_tecnico_cargo)
VALUES ('TESTE B - cenarios de erro', NULL, 0, 4, 1, 3, 2, 1, 4, 3);

-- ESPERADO: ordens 5 e 6 com 1 linha cada no historico (situacao 1)
SELECT id, descricao_defeito, valor_total, id_situacao_atual, data_fechamento
FROM ordem WHERE id IN (5, 6);
SELECT * FROM ordem_situacao WHERE id_ordem IN (5, 6);

-- ---------------------------------------------------------------------
-- 2) ORDEM_SERVICO -> triggers ai / au / ad de valor_total
-- ---------------------------------------------------------------------
-- 2.1 Servico 7 (Troca de Bateria, 9000) x1
INSERT INTO ordem_servico (id_ordem, id_servico, quantidade_servico, preco_praticado)
VALUES (5, 7, 1, (SELECT preco FROM servico WHERE id = 7));
-- ESPERADO valor_total = 9000

-- 2.2 Servico 2 (Limpeza Interna, 15000) x2
INSERT INTO ordem_servico (id_ordem, id_servico, quantidade_servico, preco_praticado)
VALUES (5, 2, 2, (SELECT preco FROM servico WHERE id = 2));
-- ESPERADO valor_total = 9000 + 30000 = 39000

-- 2.3 UPDATE: servico 7 passa de x1 para x2
UPDATE ordem_servico SET quantidade_servico = 2
WHERE id_ordem = 5 AND id_servico = 7;
-- ESPERADO valor_total = 18000 + 30000 = 48000

-- 2.4 DELETE: remove o servico 2
DELETE FROM ordem_servico WHERE id_ordem = 5 AND id_servico = 2;
-- ESPERADO valor_total = 18000

SELECT id, valor_total FROM ordem WHERE id = 5;

-- ---------------------------------------------------------------------
-- 3) ORDEM_PECA -> validacao, baixa/devolucao de estoque e valor_total
--    (tecnico 5 = Marcos Vieira, cargo 3)
-- ---------------------------------------------------------------------
-- 3.1 Peca 17 (Conector Type-C, 2000) x3
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (5, 17, 3, (SELECT preco_sugerido FROM peca WHERE id = 17), 5, 3);
-- ESPERADO: estoque peca 17 = 97 | valor_total = 18000 + 6000 = 24000

-- 3.2 Peca 21 (Camera Traseira, 14000) x2
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (5, 21, 2, (SELECT preco_sugerido FROM peca WHERE id = 21), 5, 3);
-- ESPERADO: estoque peca 21 = 1 | valor_total = 24000 + 28000 = 52000

-- 3.3 UPDATE: peca 17 passa de x3 para x5
UPDATE ordem_peca SET quantidade = 5
WHERE id_ordem = 5 AND id_peca = 17;
-- ESPERADO: estoque peca 17 = 95 | valor_total = 52000 + 4000 = 56000

-- 3.4 DELETE: remove a peca 21 da ordem
DELETE FROM ordem_peca WHERE id_ordem = 5 AND id_peca = 21;
-- ESPERADO: estoque peca 21 = 3 | valor_total = 56000 - 28000 = 28000

SELECT id, nome_peca, estoque_real FROM peca WHERE id IN (17, 21);
SELECT id, valor_total FROM ordem WHERE id = 5;

-- ---------------------------------------------------------------------
-- 4) ENTRADA_PECA / SAIDA_PECA -> estoque
-- ---------------------------------------------------------------------
-- 4.1 Entrada de 10 unidades da peca 21 (gerente, id 1)
INSERT INTO entrada_peca (id_peca, quantidade, preco_de_compra, id_funcionario, id_funcionario_cargo)
VALUES (21, 10, 9000, 1, 1);
-- ESPERADO: estoque peca 21 = 13

-- 4.2 Saida avulsa de 4 unidades da peca 21 (tecnico 4, id cargo 3)
INSERT INTO saida_peca (id_peca, quantidade_saida, preco_de_compra, id_tecnico, id_tecnico_cargo)
VALUES (21, 4, 9000, 4, 3);
-- ESPERADO: estoque peca 21 = 9

SELECT id, nome_peca, estoque_real FROM peca WHERE id = 21;

-- ---------------------------------------------------------------------
-- 5) FLUXO DE SITUACOES -> ordem_situacao atualiza ordem e data_fechamento
-- ---------------------------------------------------------------------
-- 5.1 Em analise (2), Em manutencao (4), Concluida (6): NAO encerram
INSERT INTO ordem_situacao (id_ordem, id_nova_situacao, id_funcionario) VALUES (5, 2, 5);
INSERT INTO ordem_situacao (id_ordem, id_nova_situacao, id_funcionario) VALUES (5, 4, 5);
INSERT INTO ordem_situacao (id_ordem, id_nova_situacao, id_funcionario) VALUES (5, 6, 5);
-- ESPERADO: id_situacao_atual = 6 | data_fechamento = NULL
SELECT id, id_situacao_atual, data_fechamento FROM ordem WHERE id = 5;

-- 5.2 Entregue (8): encerra a ordem
INSERT INTO ordem_situacao (id_ordem, id_nova_situacao, id_funcionario) VALUES (5, 8, 2);
-- ESPERADO: id_situacao_atual = 8 | data_fechamento preenchida
SELECT id, id_situacao_atual, data_fechamento FROM ordem WHERE id = 5;
SELECT * FROM ordem_situacao WHERE id_ordem = 5 ORDER BY id;

-- ---------------------------------------------------------------------
-- 6) ERROS EM ORDEM ENCERRADA (ordem 5) - execute UM POR VEZ
-- ---------------------------------------------------------------------
-- 6.1 DEVE FALHAR: 'Ordem encerrada: não é possível adicionar peças.'
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (5, 22, 1, 2500, 5, 3);

-- 6.2 DEVE FALHAR: 'Ordem encerrada.'
INSERT INTO ordem_servico (id_ordem, id_servico, quantidade_servico, preco_praticado)
VALUES (5, 3, 1, 8000);

-- 6.3 DEVE FALHAR: 'Ordem já encerrada.'
INSERT INTO ordem_situacao (id_ordem, id_nova_situacao, id_funcionario) VALUES (5, 4, 5);

-- ---------------------------------------------------------------------
-- 7) ERROS EM ORDEM ABERTA (ordem 6) - execute UM POR VEZ
-- ---------------------------------------------------------------------
-- 7.1 DEVE FALHAR: 'Quantidade deve ser maior que zero.'
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (6, 22, 0, 2500, 4, 3);

-- 7.2 DEVE FALHAR: 'Peça inativa ou inexistente.' (peca 9999 nao existe)
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (6, 9999, 1, 1000, 4, 3);

-- 7.3 DEVE FALHAR: 'Estoque insuficiente para a quantidade solicitada.'
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (6, 21, 999, 14000, 4, 3);

-- 7.4 Peca inativa: desative, tente inserir (deve falhar) e reative
UPDATE peca SET status = 0 WHERE id = 18;
-- DEVE FALHAR: 'Peça inativa ou inexistente.'
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (6, 18, 1, 1500, 4, 3);
-- RESTAURA (execute mesmo apos o erro):
UPDATE peca SET status = 1 WHERE id = 18;

-- 7.5 Servico inativo: desative, tente inserir (deve falhar) e reative
UPDATE servico SET status = 0 WHERE id = 3;
-- DEVE FALHAR: 'Serviço inativo ou inexistente.'
INSERT INTO ordem_servico (id_ordem, id_servico, quantidade_servico, preco_praticado)
VALUES (6, 3, 1, 8000);
-- RESTAURA:
UPDATE servico SET status = 1 WHERE id = 3;

-- 7.6 DEVE FALHAR: 'Quantidade deve ser maior que zero.'
INSERT INTO ordem_servico (id_ordem, id_servico, quantidade_servico, preco_praticado)
VALUES (6, 4, 0, 10000);

-- 7.7 Preparacao (DEVE FUNCIONAR): peca 22 x1 na ordem 6
INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)
VALUES (6, 22, 1, (SELECT preco_sugerido FROM peca WHERE id = 22), 4, 3);
-- ESPERADO: estoque peca 22 = 39 | valor_total ordem 6 = 2500

-- 7.8 DEVE FALHAR: 'Estoque insuficiente.' (UPDATE de quantidade acima do estoque)
UPDATE ordem_peca SET quantidade = 9999 WHERE id_ordem = 6 AND id_peca = 22;

-- 7.9 DEVE FALHAR: 'Não é permitido trocar ordem ou peça; ...'
UPDATE ordem_peca SET id_peca = 17 WHERE id_ordem = 6 AND id_peca = 22;

-- 7.10 DEVE FALHAR: 'Estoque insuficiente.' (saida avulsa)
INSERT INTO saida_peca (id_peca, quantidade_saida, preco_de_compra, id_tecnico, id_tecnico_cargo)
VALUES (21, 9999, 9000, 4, 3);

-- 7.11 DEVE FALHAR: 'Estoque insuficiente.' (quantidade zero)
INSERT INTO saida_peca (id_peca, quantidade_saida, preco_de_compra, id_tecnico, id_tecnico_cargo)
VALUES (21, 0, 9000, 4, 3);

-- 7.12 DEVE FALHAR: 'Exclusão física não permitida. Use status = 0.'
DELETE FROM cliente WHERE id = 1;

-- ---------------------------------------------------------------------
-- 8) CONFERENCIA FINAL
-- ---------------------------------------------------------------------
-- total_gravado deve ser IGUAL a total_calculado nas ordens 5 e 6.
-- (Ordens 1 a 4 podem divergir: seus itens foram inseridos antes dos triggers.)
SELECT o.id,
       o.valor_total AS total_gravado,
       COALESCE((SELECT SUM(quantidade * valor_unitario)
                 FROM ordem_peca WHERE id_ordem = o.id), 0)
     + COALESCE((SELECT SUM(quantidade_servico * preco_praticado)
                 FROM ordem_servico WHERE id_ordem = o.id), 0) AS total_calculado
FROM ordem o
WHERE o.id IN (5, 6);

-- Estoque final esperado: peca 17 = 95 | peca 21 = 9 | peca 22 = 39
SELECT id, nome_peca, estoque_real FROM peca WHERE id IN (17, 21, 22);

-- Situacao atual da ordem x ultimo registro do historico (devem bater)
SELECT o.id, o.id_situacao_atual,
       (SELECT id_nova_situacao FROM ordem_situacao
        WHERE id_ordem = o.id ORDER BY id DESC LIMIT 1) AS ultima_no_historico
FROM ordem o;