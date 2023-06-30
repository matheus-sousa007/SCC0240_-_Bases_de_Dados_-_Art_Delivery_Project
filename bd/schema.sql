DROP TABLE IF EXISTS Responde;
DROP TABLE IF EXISTS Mensagens;
DROP TABLE IF EXISTS Renegocia;
DROP TABLE IF EXISTS Aceitacao;
DROP TABLE IF EXISTS AssinaturaArtistaCliente;
DROP TABLE IF EXISTS Banimentos;
DROP TABLE IF EXISTS Segue;
DROP TABLE IF EXISTS Bloqueia;
DROP TABLE IF EXISTS ClassificacaoRequisicao;
DROP TABLE IF EXISTS PostsAlbumCliente;
DROP TABLE IF EXISTS TagClassificaAlbumArtista;
DROP TABLE IF EXISTS TagClassificaAlbumCliente;
DROP TABLE IF EXISTS PostsAlbumArtista;
DROP TABLE IF EXISTS ClassificacaoEdicao;
DROP TABLE IF EXISTS ClassificacaoPost;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS Requisicao;
DROP TABLE IF EXISTS AlbumCliente;
DROP TABLE IF EXISTS AlbumArtista;
DROP TABLE IF EXISTS Edicao;
DROP TABLE IF EXISTS Post;
DROP TABLE IF EXISTS Reage;
DROP TABLE IF EXISTS Reposta;
DROP TABLE IF EXISTS ClassificacaoComum;
DROP TABLE IF EXISTS ClassificacaoUsuario;
DROP TABLE IF EXISTS Artista;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS ADMINISTRADOR;



CREATE TABLE ADMINISTRADOR (
    NomeUsuario VARCHAR(32) PRIMARY KEY
);

CREATE TABLE Cliente (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    NroRequisiçõesEmAberto INTEGER NOT NULL,
    NroRequisiçõesEmProgresso INTEGER NOT NULL,
    NroRequisiçõesNaoSucedida INTEGER NOT NULL,
    NroRequisiçõesFeitas INTEGER NOT NULL,
    NroAlbums INTEGER NOT NULL,
    NroReposts INTEGER NOT NULL,
    NroAssinaturas INTEGER NOT NULL
);

CREATE TABLE Artista (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    Preco VARCHAR(32),
    ContaBancaria VARCHAR(32),
    NroAssinantes INTEGER NOT NULL,
    NroPosts INTEGER NOT NULL,
    NroRequisiçõesFinalizadas INTEGER NOT NULL,
    NroRequisiçõesEmAndamento INTEGER NOT NULL
);

CREATE TABLE ClassificacaoUsuario (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    TipoUsuario VARCHAR(13)  NOT NULL, -- [ADMINISTRADOR, COMUM]
    Senha VARCHAR(32) NOT NULL,
    Nome VARCHAR(32) NOT NULL,
    Endereco VARCHAR(32),
    Telefone VARCHAR(32),
    Email VARCHAR(32) NOT NULL,
    DataNasc VARCHAR(32),
    FotoPerfil VARCHAR(32),             -- link?
    DataIngresso TIMESTAMP
);

CREATE TABLE ClassificacaoComum (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    TipoComum VARCHAR(7) NOT NULL,      -- [CLIENTE, ARTISTA]
    NumSeguindo INTEGER NOT NULL,
    NumSegidores INTEGER NOT NULL,
    NroAlbuns INTEGER NOT NULL
);

CREATE TABLE Reposta (
    cliente VARCHAR(32),
    post INTEGER,
    dataRepostagem timestamp,
    PRIMARY KEY(cliente, post, dataRepostagem)
);

CREATE TABLE Reage (
    cliente VARCHAR(32),
    post INTEGER,
    reacao VARCHAR(7),          --[Like, Dislike, Amei ou Choro]

    PRIMARY KEY(cliente, post, reacao)
);

CREATE TABLE Post (
    id INTEGER PRIMARY KEY,
    DataCriacao VARCHAR(32) NOT NULL,
    Artista VARCHAR(32) NOT NULL,
    DataUltimaEdicao TIMESTAMP,
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32),                  -- tamanho?
    Arte VARCHAR(32) NOT NULL,
    Visibilidade VARCHAR(10) NOT NULL,
    NroRepostagens INTEGER NOT NULL,
    NroAlbuns INTEGER NOT NULL,
    NroLikes INTEGER NOT NULL,
    NroDislikes INTEGER NOT NULL,
    NroAmei INTEGER NOT NULL,
    NroChoro INTEGER NOT NULL,
    NroEdicoes INTEGER NOT NULL,

    CONSTRAINT SEC_KEY_Post UNIQUE(DataCriacao, artista)
    
);

CREATE TABLE Edicao (
    id INTEGER PRIMARY KEY,
    DataCriacaoEdicao TIMESTAMP,
    post INTEGER,
    DataEdicaoAnterior TIMESTAMP,
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32) NOT NULL,
    Arte VARCHAR(32) NOT NULL,              -- ?
    Visibilidade VARCHAR(10) NOT NULL,      -- [assinantes, geral]

    CONSTRAINT SEC_KEY_Edicao UNIQUE(DataCriacaoEdicao, post)
);

CREATE TABLE AlbumArtista (
    Titulo VARCHAR(32),
    Artista VARCHAR(32),
    TipoVisualizacao VARCHAR(7) NOT NULL,      --[PUBLICO, PRIVADO]
    DataCriacao TIMESTAMP NOT NULL,
    NroPosts INTEGER NOT NULL,
    CONSTRAINT PK_AlbumArtista PRIMARY KEY(Titulo, Artista)

);

CREATE TABLE AlbumCliente (
    Titulo VARCHAR(32),
    Cliente VARCHAR(32),
    TipoVisualizacao VARCHAR(7) NOT NULL,      --[PUBLICO, PRIVADO]
    DataCriacao TIMESTAMP NOT NULL,
    NroReposts INTEGER NOT NULL,
    CONSTRAINT PK_AlbumCliente PRIMARY KEY(Titulo, Cliente)

);

CREATE TABLE Requisicao (
    DataCriacao TIMESTAMP,
    Cliente VARCHAR(32),
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32),
    Minimo INTEGER NOT NULL,
    Maximo INTEGER NOT NULL,
    Tipo VARCHAR(32) NOT NULL,
    AvaliacaoArtista VARCHAR(32),       -- verificar tipo
    AvaliacaoCliente VARCHAR(32),
    estado VARCHAR(32) NOT NULL,
    DataTermino TIMESTAMP,
    NroAceitacoesExclusivas INTEGER NOT NULL,
    NroAceitacoesGerais INTEGER NOT NULL,
    NroAceitacoesAbertasTotal INTEGER NOT NULL,
    NroAceitacoesRejeitadas INTEGER NOT NULL,
    CONSTRAINT PK_Requisicao PRIMARY KEY(DataCriacao, Cliente)
);

CREATE TABLE Tag (
    Nome VARCHAR(32) PRIMARY KEY,
    Tipo VARCHAR(32) NOT NULL,
    NroPostsRestritos INTEGER NOT NULL,
    NroPostsPublicos INTEGER NOT NULL,
    NroAlbuns timestamp NOT NULL
);

CREATE TABLE ClassificacaoPost (
    post INTEGER,
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_ClassificacaoPost PRIMARY KEY(post, Tag)

);

CREATE TABLE ClassificacaoEdicao (
    PostEditado VARCHAR(32),
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_ClassificacaoEdicao PRIMARY KEY(PostEditado, Tag)

);

CREATE TABLE PostsAlbumArtista (
    Titulo VARCHAR(32),
    Artista VARCHAR(32),
    post INTEGER,
    CONSTRAINT PK_PostsAlbumArtista PRIMARY KEY(titulo, Artista, post)
);

CREATE TABLE TagClassificaAlbumCliente  (
    titulo VARCHAR(32),
    cliente VARCHAR(32),
    tag VARCHAR(32),
    Prioridade INTEGER,
    CONSTRAINT PK_TagClassificaAlbumCliente PRIMARY KEY(titulo, cliente, tag)

);

CREATE TABLE TagClassificaAlbumArtista (
    titulo VARCHAR(32),
    artista VARCHAR(32),
    tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_TagClassificaAlbumArtista PRIMARY KEY(titulo, artista, tag)
);

CREATE TABLE PostsAlbumCliente (
    titulo VARCHAR(32),
    cliente VARCHAR(32),
    post INTEGER,
    CONSTRAINT PK_PostsAlbumCliente PRIMARY KEY(titulo, cliente, post)
);

CREATE TABLE ClassificacaoRequisicao (
    DataRequisição VARCHAR(32),
    Cliente VARCHAR(32),
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_ClassificacaoRequisicao PRIMARY KEY(DataRequisição, Cliente, Tag)
);

CREATE TABLE Bloqueia (
    UsuarioBloqueia VARCHAR(32),
    UsuarioBloqueado VARCHAR(32),
    data timestamp,
    CONSTRAINT PK_Bloqueia PRIMARY KEY(UsuarioBloqueia, UsuarioBloqueado, data)
);

CREATE TABLE Segue (
    UsuarioSegue VARCHAR(32),
    UsuarioSeguido VARCHAR(32),
    data TIMESTAMP,
    CONSTRAINT PK_Segue PRIMARY KEY(usuarioSegue, usuarioSeguido, data)
);

CREATE TABLE Banimentos (
    Administrador VARCHAR(32),
    Usuario VARCHAR(32),
    data VARCHAR(32),
    Motivo VARCHAR(32) NOT NULL,
    DataTermino TIMESTAMP,
    CONSTRAINT PK_Banimentos PRIMARY KEY(Administrador, Usuario, data)
);

CREATE TABLE AssinaturaArtistaCliente (
    Artista VARCHAR(32),
    Cliente VARCHAR(32),
    DataAssinatura VARCHAR(32) NOT NULL,
    DataLimiteAssinatura VARCHAR(32) NOT NULL,
    CONSTRAINT PK_AssinaturaArtistaCliente PRIMARY KEY(artista, cliente)
);

CREATE TABLE Aceitacao (
    ID VARCHAR(32) PRIMARY KEY,
    artista VARCHAR(32) NOT NULL,
    dataRequisição TIMESTAMP NOT NULL,
    cliente VARCHAR(32) NOT NULL,
    tipoDeaceitacao VARCHAR(32),
    valor VARCHAR(32) NOT NULL,
    escopo VARCHAR(32) NOT NULL,
    estado VARCHAR(32) NOT NULL,
    destinatario VARCHAR(32) NOT NULL,
    dataaceitacao VARCHAR(32) NOT NULL,
    ajusteEscopo VARCHAR(32),
    ajusteValor VARCHAR(32),
    UNIQUE(artista, dataRequisição, cliente)
);

CREATE TABLE Renegocia (
    aceitacao VARCHAR(32) PRIMARY KEY,
    remetente VARCHAR(32) NOT NULL,
    destinatario VARCHAR(32) NOT NULL,
    ajusteEscopo VARCHAR(32),
    ajusteValor VARCHAR(32)
);

CREATE TABLE Mensagens ( 
    ID VARCHAR(32) PRIMARY KEY,
    aceitacao VARCHAR(32) NOT NULL,
    dataEnvio VARCHAR(32) NOT NULL,
    Remetente VARCHAR(32) NOT NULL,
    Destinatario VARCHAR(32) NOT NULL,
    conteudo VARCHAR(32),
    anexo VARCHAR(32),           -- ?
    CONSTRAINT SEC_KEY_Mensagens UNIQUE(aceitacao, dataEnvio, remetente)
);

CREATE TABLE Responde (
    aceitacao VARCHAR(32),
    MensagemRespondida VARCHAR(32),
    MensagemResposta VARCHAR(32),
    CONSTRAINT PK_Responde PRIMARY KEY(aceitacao, MensagemRespondida, MensagemResposta)
);

