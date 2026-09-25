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