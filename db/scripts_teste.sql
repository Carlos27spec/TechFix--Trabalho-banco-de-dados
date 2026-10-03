-- ATIVA AS CHAVES ENTRAGEIRAS DO SQLITE
PRAGMA foreign_keys = 1;

-- Verifica se as chaves estrangeiras estao ativas.
PRAGMA foreign_keys;

CREATE TABLE
    cargo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,
        status INTEGER NOT NULL DEFAULT 1
    ) STRICT;

CREATE TABLE
    funcionario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_funcionario TEXT NOT NULL COLLATE NOCASE,
        id_cargo INTEGER NOT NULL,
        status INTEGER NOT NULL DEFAULT 1,
        data_cadastro TEXT NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
        FOREIGN KEY (id_cargo) REFERENCES cargo (id) ON UPDATE CASCADE ON DELETE CASCADE,
        UNIQUE (id, id_cargo)
    ) STRICT;

INSERT INTO
    cargo (nome_cargo)
VALUES
    ('Gerente'),
    ('Atendente'),
    ('Técnico');

-- 1 Gerente
INSERT INTO
    funcionario (nome_funcionario, id_cargo, status)
VALUES
    (
        'Carlos Andrade',
        (
            SELECT
                id
            FROM
                cargo
            WHERE
                nome_cargo = 'Gerente'
        ),
        1
    );

-- 2 Atendentes
INSERT INTO
    funcionario (nome_funcionario, id_cargo, status)
VALUES
    (
        'Fernanda Souza',
        (
            SELECT
                id
            FROM
                cargo
            WHERE
                nome_cargo = 'Atendente'
        ),
        1
    ),
    (
        'Rafael Lima',
        (
            SELECT
                id
            FROM
                cargo
            WHERE
                nome_cargo = 'Atendente'
        ),
        1
    );

-- 3 Técnicos
INSERT INTO
    funcionario (nome_funcionario, id_cargo, status)
VALUES
    (
        'João Pereira',
        (
            SELECT
                id
            FROM
                cargo
            WHERE
                nome_cargo = 'Técnico'
        ),
        1
    ),
    (
        'Marcos Vieira',
        (
            SELECT
                id
            FROM
                cargo
            WHERE
                nome_cargo = 'Técnico'
        ),
        1
    ),
    (
        'Bruno Costa',
        (
            SELECT
                id
            FROM
                cargo
            WHERE
                nome_cargo = 'Técnico'
        ),
        1
    );

CREATE TABLE
    cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_cliente TEXT NOT NULL COLLATE NOCASE,
        email TEXT NOT NULL COLLATE NOCASE UNIQUE,
        status INTEGER NOT NULL DEFAULT 1,
        id_funcionario INTEGER NOT NULL,
        -- CHECK: Avalia o usuário inserido tem o id de cargo definido na tabela de funcionário
        id_funcionario_cargo INTEGER NOT NULL CHECK (
            id_funcionario_cargo = 1
            OR id_funcionario_cargo = 2
        ),
        data_cadastro TEXT NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
        FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
    ) STRICT;

INSERT INTO
    cliente (
        nome_cliente,
        email,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Marcos',
        'marcos@gmail.com',
        3,
        (
            SELECT
                id_cargo
            FROM
                funcionario
            WHERE
                id = 3
        )
    );

CREATE TABLE
    categoria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_categoria TEXT NOT NULL COLLATE NOCASE UNIQUE,
        id_funcionario INTEGER NOT NULL,
        id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
        status INTEGER NOT NULL DEFAULT 1,
        data_cadastro TEXT NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
        FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
    ) STRICT;

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'computadores',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'celulares',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'smart tvs',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'redes',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'videogames',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'áudio',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'recuperação de dados',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'eletrônica avançada',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'informática',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'insumos',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'acessórios',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'telas',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'baterias',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'componentes',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'carcaças',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

INSERT INTO
    categoria (
        nome_categoria,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'tvs',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario f
            WHERE
                id = 1
        )
    );

CREATE TABLE
    servico (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_servico TEXT NOT NULL COLLATE NOCASE UNIQUE,
        id_categoria INTEGER NOT NULL,
        preco INTEGER NOT NULL,
        horas_trabalho REAL NOT NULL,
        id_funcionario INTEGER NOT NULL,
        id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
        status INTEGER NOT NULL DEFAULT 1,
        data_cadastro TEXT NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
        FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo),
        FOREIGN KEY (id_categoria) REFERENCES categoria (id)
    ) STRICT;

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Formatação e Instalação de Sistema Operacional',
        1,
        12000,
        2.0,
        1,
        1
    );

-- Computadores (id 1)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Formatação e Instalação de Sistema Operacional',
        1,
        12000,
        2.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Limpeza Interna e Troca de Pasta Térmica',
        1,
        15000,
        1.5,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Upgrade de Hardware (RAM/SSD)',
        1,
        8000,
        1.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Remoção de Vírus e Malwares',
        1,
        10000,
        1.5,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    ('Troca de Tela de Notebook', 1, 18000, 1.5, 1, 1);

-- Celulares (id 2)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Troca de Display/Frontal de Celular',
        2,
        15000,
        1.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Troca de Bateria de Smartphone',
        2,
        9000,
        0.5,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Desoxidação após Contato com Líquido',
        2,
        20000,
        3.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Reparo em Conector de Carga (Micro USB / Type-C)',
        2,
        11000,
        1.5,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Troca de Vidro Traseiro de Smartphone a Laser / Manual',
        2,
        18000,
        2.5,
        1,
        1
    );

-- Smart TVs (id 3)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Troca de Barra de LED de Smart TV',
        3,
        35000,
        3.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Reparo na Placa Principal de Smart TV',
        3,
        28000,
        2.5,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Conserto de Fonte de Alimentação Interna (TV)',
        3,
        22000,
        2.0,
        1,
        1
    );

-- Redes (id 4)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Configuração de Rede e Roteador Wi-Fi',
        4,
        9000,
        1.0,
        1,
        1
    );

-- Videogames (id 5)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Higienização e Troca de Metal Líquido / Pasta Térmica (Console)',
        5,
        22000,
        2.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Reparo de Drift em Analógico de Controle (Joy-Con / DualSense / Xbox)',
        5,
        8000,
        1.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Substituição de HDMI / Conector de Vídeo (Console)',
        5,
        25000,
        2.5,
        1,
        1
    );

-- Áudio (id 6)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Troca de Bateria de Caixa de Som Portátil (Bluetooth)',
        6,
        12000,
        1.5,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Troca de Almofadas / Reparo de Cabo de Headset Gamer',
        6,
        7000,
        1.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Reparo e Solda de Conector Jack P2/P10 de Mesa de Som ou Amplificador',
        6,
        9500,
        1.0,
        1,
        1
    );

-- Recuperação de Dados (id 7)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Recuperação de Dados de HD / SSD / Pendrive Danificado',
        7,
        30000,
        4.0,
        1,
        1
    );

-- Eletrônica Avançada (id 8)
INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Rebaling / Reparo de BGA em Placa Mãe ou Placa de Vídeo',
        8,
        45000,
        5.0,
        1,
        1
    );

INSERT INTO
    servico (
        nome_servico,
        id_categoria,
        preco,
        horas_trabalho,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Gravação e Reprogramação de BIOS Eprom (Notebook / Desktop)',
        8,
        16000,
        2.0,
        1,
        1
    );

CREATE TABLE
    peca (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_peca TEXT NOT NULL COLLATE NOCASE UNIQUE,
        id_categoria INTEGER NOT NULL,
        preco_de_compra INTEGER NOT NULL,
        preco_venda INTEGER NOT NULL,
        estoque_real INTEGER NOT NULL,
        id_funcionario INTEGER NOT NULL,
        id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
        status INTEGER NOT NULL DEFAULT 1,
        data_cadastro TEXT NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
        FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo),
        FOREIGN KEY (id_categoria) REFERENCES categoria (id)
    ) STRICT;

-- Informática / Computadores
INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    ('SSD NVMe 512GB M.2', 9, 26000, 14000, 15, 1, 1);

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'SSD SATA III 480GB 2.5"',
        9,
        21000,
        11000,
        20,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Memória RAM DDR4 8GB 2666MHz (Notebook)',
        9,
        17000,
        9000,
        12,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Memória RAM DDR4 16GB 3200MHz (Desktop)',
        9,
        32000,
        18000,
        8,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Pasta Térmica de Alta Performance (Bisnaga 4g)',
        10,
        6000,
        2500,
        25,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Fonte ATX 500W 80 Plus Bronze',
        9,
        34000,
        19000,
        6,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Bateria Célula Moeda CR2032 (Cartela c/ 5)',
        10,
        2500,
        800,
        30,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Cooler para Processador Socket Universal',
        9,
        9500,
        4500,
        10,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Cabo SATA III 6Gbps 50cm',
        11,
        1500,
        300,
        50,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Tela LED 15.6" Slim 30 Pinos Full HD',
        12,
        48000,
        28000,
        5,
        1,
        1
    );

-- Smartphones / Celulares
INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Display Frontal Completo iPhone 11',
        12,
        35000,
        18000,
        4,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Display Frontal Completo Samsung Galaxy A54',
        12,
        31000,
        16000,
        6,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Display Frontal Completo Motorola Moto G84',
        12,
        28000,
        14000,
        5,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Bateria Compatível iPhone 11 (3110mAh)',
        13,
        16000,
        7500,
        8,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Bateria Compatível Samsung Galaxy A32',
        13,
        13000,
        6000,
        7,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Bateria Compatível Moto G30',
        13,
        12000,
        5500,
        6,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Conector de Carga Type-C Universal (Unidade)',
        14,
        2000,
        250,
        100,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Conector de Carga Micro USB V8',
        14,
        1500,
        150,
        100,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Flex de Carga e Microfone Moto G9 Play',
        14,
        5500,
        1800,
        10,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Tampa Traseira de Vidro iPhone 12',
        15,
        11000,
        4000,
        4,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Câmera Traseira Principal Redmi Note 11',
        14,
        14000,
        6500,
        3,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Alto-Falante Auricular Universal',
        14,
        2500,
        500,
        40,
        1,
        1
    );

-- Smart TVs
INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Barra de LED TV Samsung 50" (Kit com 3 barras)',
        16,
        23000,
        11000,
        4,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Barra de LED TV LG 43" (Kit com 3 barras)',
        16,
        19500,
        9500,
        5,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Placa Fonte TV Samsung UN50TU8000',
        16,
        31000,
        16000,
        2,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Placa Principal TV LG 43UP7500',
        16,
        42000,
        21000,
        2,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Cabo Flat T-Con para Display TV 55"',
        16,
        6500,
        2200,
        8,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Receptor Infravermelho para Controle Remoto TV',
        14,
        2000,
        400,
        15,
        1,
        1
    );

-- Insumos e Componentes Genéricos
INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)',
        10,
        15000,
        8500,
        3,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Álcool Isopropílico 99.8% 1 Litro',
        10,
        4500,
        2200,
        12,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Fita Kapton Térmica 10mm x 33m',
        10,
        3000,
        1200,
        15,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Fita Dupla Face Fixação de Telas (3mm x 50m)',
        10,
        3500,
        1500,
        10,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Fusível de Louça 5A 250V (Pacote c/ 10)',
        14,
        1800,
        500,
        20,
        1,
        1
    );

INSERT INTO
    peca (
        nome_peca,
        id_categoria,
        preco_venda,
        preco_de_compra,
        estoque_real,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'Capacitor Eletrolítico 1000uF x 25V',
        14,
        500,
        80,
        150,
        1,
        1
    );

CREATE VIEW
    vw_preco_venda_maior_1000 AS
SELECT
    id,
    nome_peca,
    preco_venda,
    estoque_real
FROM
    peca p
WHERE
    p.preco_venda >= 10000;

SELECT
    *
FROM
    vw_preco_venda_maior_1000 vpvm;