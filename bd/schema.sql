
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
    NroAlbuns INTEGER NOT NULL,
    CONSTRAINT FK_ClassificacaoComum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoUsuario(NomeUsuario)
);

CREATE TABLE Administrador (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    CONSTRAINT FK_Admnistrador_comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoUsuario(NomeUsuario)

);

CREATE TABLE Cliente (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    NroRequisiçõesEmAberto INTEGER NOT NULL,
    NroRequisiçõesEmProgresso INTEGER NOT NULL,
    NroRequisiçõesNaoSucedida INTEGER NOT NULL,
    NroRequisiçõesFeitas INTEGER NOT NULL,
    NroAlbums INTEGER NOT NULL,
    NroReposts INTEGER NOT NULL,
    NroAssinaturas INTEGER NOT NULL,
    CONSTRAINT FK_Cliente_comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoComum(NomeUsuario)

);

CREATE TABLE Artista (
    NomeUsuario VARCHAR(32) PRIMARY KEY,
    Preco VARCHAR(32),
    ContaBancaria VARCHAR(32),
    NroAssinantes INTEGER NOT NULL,
    NroPosts INTEGER NOT NULL,
    NroRequisiçõesFinalizadas INTEGER NOT NULL,
    NroRequisiçõesEmAndamento INTEGER NOT NULL,
    CONSTRAINT FK_Artista_comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoComum(NomeUsuario)

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

    CONSTRAINT SEC_KEY_Post UNIQUE(DataCriacao, artista),
    CONSTRAINT FK_Post_artista FOREIGN KEY(artista) REFERENCES ClassificacaoComum(NomeUsuario)
    
);

CREATE TABLE Reposta (
    cliente VARCHAR(32),
    post INTEGER,
    dataRepostagem timestamp,
    CONSTRAINT PK_Reposta PRIMARY KEY(cliente, post, dataRepostagem),
    CONSTRAINT FK_Reposta_cliente FOREIGN KEY(cliente) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT FK_Reposta_post FOREIGN KEY(post) REFERENCES post(id)
);

CREATE TABLE Reage (
    cliente VARCHAR(32),
    post INTEGER,
    reacao VARCHAR(7),          --[Like, Dislike, Amei ou Choro]

    CONSTRAINT PK_Reage PRIMARY KEY(cliente, post, reacao),
    CONSTRAINT FK_Reage_cliente FOREIGN KEY(cliente) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT FK_Reage_post FOREIGN KEY(post) REFERENCES post(id)

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

    CONSTRAINT SEC_KEY_Edicao UNIQUE(DataCriacaoEdicao, post),
    CONSTRAINT FK_Edicao_post FOREIGN KEY(post) REFERENCES post(id)
);

CREATE TABLE AlbumArtista (
    Titulo VARCHAR(32),
    Artista VARCHAR(32),
    TipoVisualizacao VARCHAR(7) NOT NULL,      --[PUBLICO, PRIVADO]
    DataCriacao TIMESTAMP NOT NULL,
    NroPosts INTEGER NOT NULL,
    CONSTRAINT PK_AlbumArtista PRIMARY KEY(Titulo, Artista),
    CONSTRAINT FK_AlbumArtista_artista FOREIGN KEY(Artista) REFERENCES ClassificacaoComum(NomeUsuario)

);

CREATE TABLE AlbumCliente (
    Titulo VARCHAR(32),
    Cliente VARCHAR(32),
    TipoVisualizacao VARCHAR(7) NOT NULL,      --[PUBLICO, PRIVADO]
    DataCriacao TIMESTAMP NOT NULL,
    NroReposts INTEGER NOT NULL,
    CONSTRAINT PK_AlbumCliente PRIMARY KEY(Titulo, Cliente),
    CONSTRAINT FK_AlbumCliente_cliente FOREIGN KEY(cliente) REFERENCES ClassificacaoComum(NomeUsuario)



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
    CONSTRAINT PK_Requisicao PRIMARY KEY(DataCriacao, Cliente),
    CONSTRAINT FK_Requisicao_cliente FOREIGN KEY(Cliente) REFERENCES ClassificacaoComum(NomeUsuario)

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
    CONSTRAINT PK_ClassificacaoPost PRIMARY KEY(post, Tag),
    CONSTRAINT FK_ClassificacaoPost_post FOREIGN KEY(post) REFERENCES post(id),
    CONSTRAINT FK_ClassificacaoPost_tag FOREIGN KEY(Tag) REFERENCES tag(nome)


);

CREATE TABLE ClassificacaoEdicao (
    PostEditado INTEGER,
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_ClassificacaoEdicao PRIMARY KEY(PostEditado, Tag),
    CONSTRAINT FK_ClassificacaoEdicao_post FOREIGN KEY(postEditado) REFERENCES post(id),
    CONSTRAINT FK_ClassificacaoEdicao_tag FOREIGN KEY(Tag) REFERENCES tag(nome)

);

CREATE TABLE PostsAlbumArtista (
    Titulo VARCHAR(32),
    Artista VARCHAR(32),
    post INTEGER,
    CONSTRAINT PK_PostsAlbumArtista PRIMARY KEY(titulo, Artista, post),
    CONSTRAINT FK_PostsAlbumArtista_album FOREIGN KEY(titulo, artista) REFERENCES AlbumArtista(titulo, artista),
    CONSTRAINT FK_PostsAlbumArtista_post FOREIGN KEY(post) REFERENCES Post(id)
);

CREATE TABLE TagClassificaAlbumCliente  (
    titulo VARCHAR(32),
    cliente VARCHAR(32),
    tag VARCHAR(32),
    Prioridade INTEGER,
    CONSTRAINT PK_TagClassificaAlbumCliente PRIMARY KEY(titulo, cliente, tag),
    CONSTRAINT FK_TagClassificaAlbumCliente_album FOREIGN KEY(titulo, cliente) REFERENCES AlbumCliente(titulo, cliente),
    CONSTRAINT FK_TagClassificaAlbumCliente_tag FOREIGN KEY(tag) REFERENCES Tag(nome)


);

CREATE TABLE TagClassificaAlbumArtista (
    titulo VARCHAR(32),
    artista VARCHAR(32),
    tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_TagClassificaAlbumArtista PRIMARY KEY(titulo, artista, tag),
    CONSTRAINT FK_TagClassificaAlbumArtista_album FOREIGN KEY(titulo, artista) REFERENCES AlbumArtista(titulo, artista),
    CONSTRAINT FK_TagClassificaAlbumArtista_tag FOREIGN KEY(tag) REFERENCES Tag(nome)
);

CREATE TABLE PostsAlbumCliente (
    titulo VARCHAR(32),
    cliente VARCHAR(32),
    post INTEGER,
    CONSTRAINT PK_PostsAlbumCliente PRIMARY KEY(titulo, cliente, post),
    CONSTRAINT FK_PostsAlbumCliente_album FOREIGN KEY(titulo, cliente) REFERENCES AlbumCliente(titulo, cliente),
    CONSTRAINT FK_PostsAlbumCliente_post FOREIGN KEY(post) REFERENCES Post(id)
);

CREATE TABLE ClassificacaoRequisicao (
    dataRequisicao TIMESTAMP,
    cliente VARCHAR(32),
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_ClassificacaoRequisicao PRIMARY KEY(dataRequisicao, Cliente, Tag),
    CONSTRAINT FK_ClassificacaoRequisicao_requisicao FOREIGN KEY(dataRequisicao, cliente) REFERENCES Requisicao(dataCriacao, cliente),
    CONSTRAINT FK_ClassificacaoRequisicao_tag FOREIGN KEY(Tag) REFERENCES Tag(nome)
);

CREATE TABLE Bloqueia (
    UsuarioBloqueia VARCHAR(32),
    UsuarioBloqueado VARCHAR(32),
    data timestamp,
    CONSTRAINT PK_Bloqueia PRIMARY KEY(UsuarioBloqueia, UsuarioBloqueado, data),
    CONSTRAINT FK_Bloqueia_UsuarioBloqueia FOREIGN KEY(UsuarioBloqueia) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT FK_Bloqueia_UsuarioBloqueado FOREIGN KEY(UsuarioBloqueado) REFERENCES ClassificacaoComum(NomeUsuario)
);

CREATE TABLE Segue (
    UsuarioSegue VARCHAR(32),
    UsuarioSeguido VARCHAR(32),
    data TIMESTAMP,
    CONSTRAINT PK_Segue PRIMARY KEY(usuarioSegue, usuarioSeguido, data),
    CONSTRAINT FK_Segue_UsuarioSegue FOREIGN KEY(UsuarioSegue) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT FK_Segue_UsuarioSeguido FOREIGN KEY(UsuarioSeguido) REFERENCES ClassificacaoComum(NomeUsuario)
);

CREATE TABLE Banimentos (
    Administrador VARCHAR(32),
    Usuario VARCHAR(32),
    data VARCHAR(32),
    Motivo VARCHAR(32) NOT NULL,
    DataTermino TIMESTAMP,
    CONSTRAINT PK_Banimentos PRIMARY KEY(Administrador, Usuario, data),
    CONSTRAINT FK_Banimentos_admnistrador FOREIGN KEY(Administrador) REFERENCES ClassificacaoUsuario(NomeUsuario)
    
);

CREATE TABLE AssinaturaArtistaCliente (
    artista VARCHAR(32),
    cliente VARCHAR(32),
    DataAssinatura VARCHAR(32) NOT NULL,
    DataLimiteAssinatura VARCHAR(32) NOT NULL,
    CONSTRAINT PK_AssinaturaArtistaCliente PRIMARY KEY(artista, cliente),
    CONSTRAINT FK_AssinaturaArtistaCliente_artitsta FOREIGN KEY(artista) REFERENCES Artista(NomeUsuario),
    CONSTRAINT FK_AssinaturaArtistaCliente_cliente FOREIGN KEY(cliente) REFERENCES Cliente(NomeUsuario)
);

CREATE TABLE Aceitacao (
    ID VARCHAR(32) PRIMARY KEY,
    artista VARCHAR(32) NOT NULL,
    dataRequisicao TIMESTAMP NOT NULL,
    cliente VARCHAR(32) NOT NULL,
    tipoDeAceitacao VARCHAR(32),
    valor VARCHAR(32) NOT NULL,
    escopo VARCHAR(32) NOT NULL,
    estado VARCHAR(32) NOT NULL,
    destinatario VARCHAR(32) NOT NULL,
    dataaceitacao VARCHAR(32) NOT NULL,
    ajusteEscopo VARCHAR(32),
    ajusteValor VARCHAR(32),
    UNIQUE(artista, dataRequisicao, cliente),
    CONSTRAINT FK_Aceitacao_artista FOREIGN KEY(artista) REFERENCES artista(NomeUsuario),
    CONSTRAINT FK_Aceitacao_requisicao FOREIGN KEY(dataRequisicao, cliente) REFERENCES Requisicao(dataCriacao, cliente)
);

CREATE TABLE Renegocia (
    aceitacao VARCHAR(32) PRIMARY KEY,
    remetente VARCHAR(32) NOT NULL,
    destinatario VARCHAR(32) NOT NULL,
    ajusteEscopo VARCHAR(32),
    ajusteValor VARCHAR(32),
    CONSTRAINT FK_Renegocia_aceitacao FOREIGN KEY(aceitacao) REFERENCES aceitacao(id)
);

CREATE TABLE Mensagens ( 
    ID VARCHAR(32) PRIMARY KEY,
    aceitacao VARCHAR(32) NOT NULL,
    dataEnvio VARCHAR(32) NOT NULL,
    Remetente VARCHAR(32) NOT NULL,
    Destinatario VARCHAR(32) NOT NULL,
    conteudo VARCHAR(32),
    anexo VARCHAR(32),           -- ?
    CONSTRAINT SEC_KEY_Mensagens UNIQUE(aceitacao, dataEnvio, remetente),
    CONSTRAINT FK_Mensagens_aceitacao FOREIGN KEY(aceitacao) REFERENCES aceitacao(id)
);

CREATE TABLE Responde (
    aceitacao VARCHAR(32),
    MensagemRespondida VARCHAR(32),
    MensagemResposta VARCHAR(32),
    CONSTRAINT PK_Responde PRIMARY KEY(aceitacao, MensagemRespondida, MensagemResposta),
    CONSTRAINT FK_Responde_aceitacao FOREIGN KEY(aceitacao) REFERENCES aceitacao(id),
    CONSTRAINT FK_Responde_MensagemRespondida FOREIGN KEY(MensagemRespondida) REFERENCES mensagens(id),
    CONSTRAINT FK_Responde_MensagemResposta FOREIGN KEY(MensagemResposta) REFERENCES mensagens(id)
);

