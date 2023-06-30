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
*/

INSERT INTO ClassificacaoUsuario(
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
    FotoPerfil VARCHAR(32), 
)


INSERT INTO ClassificacaoUsuario(
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
    FotoPerfil VARCHAR(32), 
)

INSERT INTO ClassificacaoComum (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    TipoComum VARCHAR(7) NOT NULL,      -- [CLIENTE, ARTISTA]
    NumSeguindo INTEGER NOT NULL,
    NumSegidores INTEGER NOT NULL,
    NroAlbums INTEGER NOT NULL,
)


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




