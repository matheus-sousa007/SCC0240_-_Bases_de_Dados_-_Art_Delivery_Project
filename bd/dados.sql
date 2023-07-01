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
    'Rupestre',
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


INSERT INTO Cliente VALUES(
    'rupestre123',
    2,
    1,
    0,
    3,
    0,
    8,
    1
);

INSERT INTO Artista VALUES(
    'johndoe',
    2,
    1,
    0,
    3,
    0,
    8,
    1
);

INSERT INTO Post (id, DataCriacao, artista, DataUltimaEdicao, Titulo, Descricao, Arte, Visibilidade, NroRepostagens, NroAlbums, NroLikes, NroDislikes, NroAmei, NroChoro, NroEdicoes)
VALUES(
    0
   '2023-04-10 09:45:00',
   'johndoe',
    '2023-06-30 10:30:00',
    'A arte da vida é viver a arte.',
    'Viver a arte é a arte da vida.',
    'imagem1.jpg',
    'Público',
    5,
    2,
    10,
    2,
    8,
    3,
    1
)

INSERT INTO Post (id, DataCriacao, artista, DataUltimaEdicao, Titulo, Descricao, Arte, Visibilidade, NroRepostagens, NroAlbums, NroLikes, NroDislikes, NroAmei, NroChoro, NroEdicoes)
VALUES (
    1,
    '2023-01-10 09:45:00',
    'johndoe',
    '2023-06-30 11:00:00',
    'Explorando a criatividade',
    'Descubra o poder da criatividade em sua vida.',
    'imagem2.jpg',
    'Privado',
    5,
    2,
    10,
    2,
    8,
    3,
    1
)

INSERT INTO Reage (cliente, post, reacao)
VALUES (
    'Rupestre',
    1,
    'Like'
)


INSERT INTO Reage (cliente, post, reacao)
VALUES (
    'Rupestre',
    1,
    'Like'
)

INSERT INTO Edicao (id, DataCriacaoEdicao, post, DataEdicaoAnterior, Titulo, Descricao, Arte, Visibilidade)
VALUES (
    1,
    '2023-06-30 09:00:00',
    1,
    '2023-06-29 14:30:00',
    'Nova Edição',
    'Descrição da nova edição',
    'imagem2.jpg',
    'assinantes'
);