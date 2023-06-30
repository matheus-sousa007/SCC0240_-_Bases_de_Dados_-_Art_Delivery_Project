
CREATE TABLE ClassificacaoUsuario (
    NomeUsuario VARCHAR(40) PRIMARY KEY,    
    TipoUsuario VARCHAR(13) NOT NULL,
    Senha VARCHAR(20) NOT NULL,
    Nome VARCHAR(40) NOT NULL,
    Logradouro VARCHAR(50),
    numeroEndereco INTEGER,
    cidade VARCHAR(32),
    Telefone VARCHAR(11),
    Email VARCHAR(32) NOT NULL,
    DataNasc DATE,
    DataIngresso TIMESTAMP,
    FotoPerfil BYTEA,
    CONSTRAINT CHECK_ClassificacaoUsuario_tipoUsuario CHECK(UPPER(TipoUsuario) in  ('ADMINISTRADOR', 'COMUM'))
);

CREATE TABLE ClassificacaoComum (
    NomeUsuario VARCHAR(40) PRIMARY KEY,
    TipoComum VARCHAR(7) NOT NULL,      -- [CLIENTE, ARTISTA]
    NumSeguindo INTEGER NOT NULL DEFAULT 0,
    NumSegidores INTEGER NOT NULL DEFAULT 0,
    NroAlbums INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT FK_ClassificacaoComum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoUsuario(NomeUsuario),
    CONSTRAINT CHECK_ClassificacaoComum_positive CHECK((NumSeguindo >= 0) AND (NumSegidores >= 0) AND (NroAlbums >= 0)),
    CONSTRAINT CHECK_ClassificacaoComum_tipoComum CHECK(UPPER(TipoComum) in  ('CLIENTE', 'ARTISTA'))

);

CREATE TABLE Administrador (
    nomeUsuario VARCHAR(40) PRIMARY KEY,
    CONSTRAINT FK_Admnistrador_comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoUsuario(NomeUsuario)

);

CREATE TABLE Cliente (
    nomeUsuario VARCHAR(40) PRIMARY KEY,
    NroRequisiçõesEmAberto INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesEmProgresso INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesNaoSucedida INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesFeitas INTEGER NOT NULL DEFAULT 0,
    NroAlbums INTEGER NOT NULL DEFAULT 0,
    NroReposts INTEGER NOT NULL DEFAULT 0,
    NroAssinaturas INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT FK_Cliente_comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT CHECK_Cliente_positive 
        CHECK(
            (NroRequisiçõesEmAberto >= 0) AND (NroRequisiçõesEmProgresso >= 0) AND 
            (NroRequisiçõesNaoSucedida >= 0) AND (NroRequisiçõesFeitas >= 0) AND 
            (NroAlbums >= 0) AND (NroReposts >= 0) AND (NroAssinaturas >= 0)
        )

);

CREATE TABLE Artista (
    nomeUsuario VARCHAR(40) PRIMARY KEY,
    Preco INTEGER,
    ContaBancaria VARCHAR(32),
    NroAssinantes INTEGER NOT NULL DEFAULT 0,
    NroPosts INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesFinalizadas INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesEmAndamento INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT FK_Artista_comum 
        FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT CHECK_Artista_positive
        CHECK(
            (NroAssinantes >= 0) AND (NroPosts >= 0) AND 
            (NroRequisiçõesFinalizadas >= 0) AND (NroRequisiçõesEmAndamento >= 0)
        )
    CONSTRAINT CHECK_Artista_positive CHECK((Preco = NULL) OR (Preco >= 0))

);


CREATE TABLE Post (
    id INTEGER PRIMARY KEY,
    DataCriacao TIMESTAMP NOT NULL,
    artista VARCHAR(40) NOT NULL,
    DataUltimaEdicao TIMESTAMP,
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32),                  -- tamanho?
    Arte VARCHAR(32) NOT NULL,
    Visibilidade VARCHAR(10) NOT NULL,
    NroRepostagens INTEGER NOT NULL DEFAULT 0,
    NroAlbums INTEGER NOT NULL DEFAULT 0,
    NroLikes INTEGER NOT NULL DEFAULT 0,
    NroDislikes INTEGER NOT NULL DEFAULT 0,
    NroAmei INTEGER NOT NULL DEFAULT 0,
    NroChoro INTEGER NOT NULL DEFAULT 0,
    NroEdicoes INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT SEC_KEY_Post UNIQUE(DataCriacao, artista),
    CONSTRAINT FK_Post_artista FOREIGN KEY(artista) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT CHECK_Post_positive 
        CHECK(
            (NroRepostagens >= 0) AND (NroAlbums >= 0) AND 
            (NroLikes >= 0) AND (NroDislikes >= 0) AND 
            (NroAmei >= 0) AND (NroChoro >= 0) AND (NroEdicoes >= 0)
        )
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
    artista VARCHAR(40),
    TipoVisualizacao VARCHAR(7) NOT NULL,
    DataCriacao TIMESTAMP NOT NULL,
    NroPosts INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT PK_AlbumArtista PRIMARY KEY(Titulo, Artista),
    CONSTRAINT FK_AlbumArtista_artista FOREIGN KEY(Artista) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT CHECK_AlbumArtista_positive CHECK(NroPosts >= 0),
    CONSTRAINT CHECK_AlbumArtista_TipoVisualizacao CHECK(UPPER(TipoVisualizacao) in  ('PUBLICO', 'PRIVADO'))

);

CREATE TABLE AlbumCliente (
    Titulo VARCHAR(32),
    Cliente VARCHAR(32),
    TipoVisualizacao VARCHAR(7) NOT NULL, 
    DataCriacao TIMESTAMP NOT NULL,
    NroReposts INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT PK_AlbumCliente PRIMARY KEY(Titulo, Cliente),
    CONSTRAINT FK_AlbumCliente_cliente FOREIGN KEY(cliente) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT CHECK_AlbumCliente_positive CHECK(NroReposts >= 0),
    CONSTRAINT CHECK_AlbumCliente_TipoVisualizacao CHECK(UPPER(TipoVisualizacao) in  ('PUBLICO', 'PRIVADO'))

);

CREATE TABLE Requisicao (
    DataCriacao TIMESTAMP,
    Cliente VARCHAR(32),
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32),
    Minimo INTEGER NOT NULL,
    Maximo INTEGER NOT NULL,
    Tipo VARCHAR(32) NOT NULL,
    Avaliacaoartista NUMERIC(3,1),       -- verificar tipo
    AvaliacaoCliente NUMERIC(3,1),
    estado VARCHAR(32) NOT NULL,
    DataTermino TIMESTAMP,
    NroAceitacoesExclusivas INTEGER NOT NULL DEFAULT 0,
    NroAceitacoesGerais INTEGER NOT NULL DEFAULT 0,
    NroAceitacoesAbertasTotal INTEGER NOT NULL DEFAULT 0,
    NroAceitacoesRejeitadas INTEGER NOT NULL,

    CONSTRAINT PK_Requisicao PRIMARY KEY(DataCriacao, Cliente),
    CONSTRAINT FK_Requisicao_cliente FOREIGN KEY(Cliente) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT CHECK_Requisicao_estados CHECK(estado in  ('1', '2', '3', '4', '5', '6')),
    CONSTRAINT CHECK_Requisicao_avaliacaoArtista CHECK(Avaliacaoartista = NULL OR Avaliacaoartista BETWEEN 0 AND 10) 
    CONSTRAINT CHECK_Requisicao_positive 
        CHECK(
            (NroAceitacoesExclusivas >= 0) AND (NroAceitacoesGerais >= 0) AND 
            (NroAceitacoesAbertasTotal >= 0) AND (NroAceitacoesRejeitadas >= 0)
        ),
    

);

CREATE TABLE Tag (
    Nome VARCHAR(32) PRIMARY KEY,
    Tipo VARCHAR(32) NOT NULL,
    NroPostsRestritos INTEGER NOT NULL DEFAULT 0,
    NroPostsPublicos INTEGER NOT NULL DEFAULT 0,
    NroAlbuns INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT CHECK_Requisicao_positive 
        CHECK(
            (NroPostsRestritos >= 0) AND (NroPostsPublicos >= 0)
        )
);

CREATE TABLE ClassificacaoPost (
    post INTEGER,
    Tag VARCHAR(32),
    prioridade INTEGER,

    CONSTRAINT PK_ClassificacaoPost PRIMARY KEY(post, Tag),
    CONSTRAINT FK_ClassificacaoPost_post FOREIGN KEY(post) REFERENCES post(id),
    CONSTRAINT FK_ClassificacaoPost_tag FOREIGN KEY(Tag) REFERENCES tag(nome),
    
    CONSTRAINT CHECK_ClassificacaoPost_positive CHECK(prioridade >= 0)

);

CREATE TABLE ClassificacaoEdicao (
    PostEditado INTEGER,
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_ClassificacaoEdicao PRIMARY KEY(PostEditado, Tag),
    CONSTRAINT FK_ClassificacaoEdicao_post FOREIGN KEY(postEditado) REFERENCES post(id),
    CONSTRAINT FK_ClassificacaoEdicao_tag FOREIGN KEY(Tag) REFERENCES tag(nome),
    CONSTRAINT CHECK_ClassificacaoEdicao_positive CHECK(prioridade >= 0)


);

CREATE TABLE PostsAlbumArtista (
    Titulo VARCHAR(32),
    artista VARCHAR(40),
    post INTEGER,
    CONSTRAINT PK_PostsAlbumArtista PRIMARY KEY(titulo, Artista, post),
    CONSTRAINT FK_PostsAlbumArtista_album FOREIGN KEY(titulo, artista) REFERENCES AlbumArtista(titulo, artista),
    CONSTRAINT FK_PostsAlbumArtista_post FOREIGN KEY(post) REFERENCES Post(id)
);

CREATE TABLE TagClassificaAlbumCliente (
    titulo VARCHAR(32),
    cliente VARCHAR(40),
    tag VARCHAR(32),
    Prioridade INTEGER,
    CONSTRAINT PK_TagClassificaAlbumCliente PRIMARY KEY(titulo, cliente, tag),
    CONSTRAINT FK_TagClassificaAlbumCliente_album FOREIGN KEY(titulo, cliente) REFERENCES AlbumCliente(titulo, cliente),
    CONSTRAINT FK_TagClassificaAlbumCliente_tag FOREIGN KEY(tag) REFERENCES Tag(nome),
    CONSTRAINT CHECK_TagClassificaAlbumCliente_positive CHECK(prioridade >= 0)



);

CREATE TABLE TagClassificaAlbumArtista (
    titulo VARCHAR(32),
    artista VARCHAR(40),
    tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_TagClassificaAlbumArtista PRIMARY KEY(titulo, artista, tag),
    CONSTRAINT FK_TagClassificaAlbumArtista_album FOREIGN KEY(titulo, artista) REFERENCES AlbumArtista(titulo, artista),
    CONSTRAINT FK_TagClassificaAlbumArtista_tag FOREIGN KEY(tag) REFERENCES Tag(nome),
    CONSTRAINT CHECK_TagClassificaAlbumArtista_positive CHECK(prioridade >= 0)

);

CREATE TABLE PostsAlbumCliente (
    titulo VARCHAR(32),
    cliente VARCHAR(40),
    post INTEGER,
    CONSTRAINT PK_PostsAlbumCliente PRIMARY KEY(titulo, cliente, post),
    CONSTRAINT FK_PostsAlbumCliente_album FOREIGN KEY(titulo, cliente) REFERENCES AlbumCliente(titulo, cliente),
    CONSTRAINT FK_PostsAlbumCliente_post FOREIGN KEY(post) REFERENCES Post(id)
);

CREATE TABLE ClassificacaoRequisicao (
    dataRequisicao TIMESTAMP,
    cliente VARCHAR(40),
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT PK_ClassificacaoRequisicao PRIMARY KEY(dataRequisicao, Cliente, Tag),
    CONSTRAINT FK_ClassificacaoRequisicao_requisicao FOREIGN KEY(dataRequisicao, cliente) REFERENCES Requisicao(dataCriacao, cliente),
    CONSTRAINT FK_ClassificacaoRequisicao_tag FOREIGN KEY(Tag) REFERENCES Tag(nome),
    CONSTRAINT CHECK_ClassificacaoRequisicao_positive CHECK(prioridade >= 0)

);

CREATE TABLE Bloqueia (
    UsuarioBloqueia VARCHAR(40),
    UsuarioBloqueado VARCHAR(40),
    data timestamp,
    CONSTRAINT PK_Bloqueia PRIMARY KEY(UsuarioBloqueia, UsuarioBloqueado, data),
    CONSTRAINT FK_Bloqueia_UsuarioBloqueia FOREIGN KEY(UsuarioBloqueia) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT FK_Bloqueia_UsuarioBloqueado FOREIGN KEY(UsuarioBloqueado) REFERENCES ClassificacaoComum(NomeUsuario)
);

CREATE TABLE Segue (
    UsuarioSegue VARCHAR(40),
    UsuarioSeguido VARCHAR(40),
    data TIMESTAMP,
    CONSTRAINT PK_Segue PRIMARY KEY(usuarioSegue, usuarioSeguido, data),
    CONSTRAINT FK_Segue_UsuarioSegue FOREIGN KEY(UsuarioSegue) REFERENCES ClassificacaoComum(NomeUsuario),
    CONSTRAINT FK_Segue_UsuarioSeguido FOREIGN KEY(UsuarioSeguido) REFERENCES ClassificacaoComum(NomeUsuario)
);

CREATE TABLE Banimentos (
    Administrador VARCHAR(40),
    Usuario VARCHAR(40),
    data VARCHAR(32),
    Motivo VARCHAR(32) NOT NULL,
    DataTermino TIMESTAMP,
    CONSTRAINT PK_Banimentos PRIMARY KEY(Administrador, Usuario, data),
    CONSTRAINT FK_Banimentos_admnistrador FOREIGN KEY(Administrador) REFERENCES ClassificacaoUsuario(NomeUsuario)
    
);

CREATE TABLE AssinaturaArtistaCliente (
    artista VARCHAR(40),
    cliente VARCHAR(32),
    DataAssinatura TIMESTAMP NOT NULL,
    DataLimiteAssinatura TIMESTAMP NOT NULL,
    CONSTRAINT PK_AssinaturaArtistaCliente PRIMARY KEY(artista, cliente),
    CONSTRAINT FK_AssinaturaArtistaCliente_artitsta FOREIGN KEY(artista) REFERENCES Artista(NomeUsuario),
    CONSTRAINT FK_AssinaturaArtistaCliente_cliente FOREIGN KEY(cliente) REFERENCES Cliente(NomeUsuario)
);

CREATE TABLE Aceitacao (
    ID VARCHAR(32) PRIMARY KEY,
    artista VARCHAR(40) NOT NULL,
    dataRequisicao TIMESTAMP NOT NULL,
    cliente VARCHAR(32) NOT NULL,
    tipoDeAceitacao VARCHAR(32),
    valor INTEGER NOT NULL,
    escopo VARCHAR(32) NOT NULL,            -- ?
    estados CHAR(1) NOT NULL,
    destinatario VARCHAR(32) NOT NULL,
    dataaceitacao TIMESTAMP NOT NULL,
    ajusteEscopo VARCHAR(32),               -- = escopo
    ajusteValor INTEGER,
    UNIQUE(artista, dataRequisicao, cliente),
    CONSTRAINT FK_Aceitacao_artista FOREIGN KEY(artista) REFERENCES artista(NomeUsuario),
    CONSTRAINT FK_Aceitacao_requisicao FOREIGN KEY(dataRequisicao, cliente) REFERENCES Requisicao(dataCriacao, cliente),
    CONSTRAINT CHECK_Aceitacao_estados CHECK(estados in  ('1', '2', '3', '4', '5', '6')),
    CONSTRAINT CHECK_Aceitacao_positive CHECK((ajusteValor = NULL) OR (ajusteValor >= 0))

);

CREATE TABLE Renegocia (
    aceitacao VARCHAR(32) PRIMARY KEY,
    remetente VARCHAR(32) NOT NULL,
    destinatario VARCHAR(32) NOT NULL,
    ajusteEscopo VARCHAR(32),
    ajusteValor INTEGER,

    CONSTRAINT FK_Renegocia_aceitacao FOREIGN KEY(aceitacao) REFERENCES aceitacao(id),
    CONSTRAINT CHECK_Renegocia_positive CHECK((ajusteValor = NULL) OR (ajusteValor >= 0))


);

CREATE TABLE Mensagens ( 
    ID VARCHAR(32) PRIMARY KEY,
    aceitacao VARCHAR(32) NOT NULL,
    dataEnvio TIMESTAMP NOT NULL,
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

