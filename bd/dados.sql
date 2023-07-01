-- Comentarios da tabela para ajudar na insercao

/*  
ClassificacaoUsuario (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    TipoUsuario VARCHAR(13) NOT NULL, -- [ADMINISTRADOR, COMUM]
    Senha VARCHAR(32) NOT NULL,
    Nome VARCHAR(32) NOT NULL,
    Logradouro VARCHAR(32),
    numeroEndereco INTEGER,
    cidade VARCHAR(32),
    Telefone VARCHAR(32),
    Email VARCHAR(32) NOT NULL,
    DataNasc DATE,
    DataIngresso TIMESTAMP,
    FotoPerfil VARCHAR(32),             -- link?
);

INSERT INTO ClassificacaoComum (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    TipoComum VARCHAR(7) NOT NULL,      -- [CLIENTE, ARTISTA]
    NumSeguindo INTEGER NOT NULL,
    NumSegidores INTEGER NOT NULL,
    NroAlbums INTEGER NOT NULL,
)


CREATE TABLE Administrador (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    CONSTRAINT FK_Admnistrador_comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoUsuario(NomeUsuario)

);
*/

/*dados a serem inseridos*/
INSERT INTO ClassificacaoUsuario VALUES(
    'Rupestre',
    'COMUM',
    '123456',
    'Pedro da Silva Souza',
    'Av. Trabalhador Sao Carlense',
    87,
    'Jardim Diniz',
    'Riacho Belo',
    '10990096718',
    'pedrosilsou@gmail.com',
    '1996-12-02',
    current_timestamp,
    'NULL'
)
INSERT INTO ClassificacaoUsuario VALUES(
    'johndoe',
    'COMUM',
    'password123',
    'John Doe',
    'Rua das Flores',
    123,
    'São Paulo',
    '1199887766',
    'john.doe@example.com',
    '1990-05-15',
    current_timestamp,
    NULL
)

INSERT INTO ClassificacaoUsuario VALUES(
    'rockstar87',
    'ADMINISTRADOR',
    'admin123',
    'Maria Oliveira',
    'Avenida Principal',
    456,
    'Rio de Janeiro',
    '2199887766',
    'maria.oliveira@example.com',
    '1987-03-25',
    current_timestamp,
    'NULL'
)

INSERT INTO ClassificacaoUsuario VALUES(
    'janesmith',
    'ADMINISTRADOR',
    'pass123',
    'Jane Smith',
    'Avenida das Palmeiras',
    789,
    'Belo Horizonte',
    '3199776655',
    'jane.smith@example.com',
    '1985-09-10',
    current_timestamp,
    NULL
)

INSERT INTO ClassificacaoComum VALUES (
    'rupestre123',
    'CLIENTE',
    100,
    200,
    0
);

INSERT INTO ClassificacaoComum VALUES (
    'johndoe',
    'ARTISTA',
    500,
    1000,
    5
);

INSERT INTO Administrador (nomeUsuario)
VALUES ('rockstar87');

INSERT INTO Administrador (nomeUsuario)
VALUES ('janesmith');

