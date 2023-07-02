CREATE TABLE ClassificacaoUsuario (
    NomeUsuario VARCHAR(40) PRIMARY KEY,    
    TipoUsuario VARCHAR(13) NOT NULL,
    Senha VARCHAR(20) NOT NULL,
    Nome VARCHAR(40) NOT NULL,
    Logradouro VARCHAR(50),
    nroEndereco INTEGER,
    cidade VARCHAR(32),
    TelefoneFixo VARCHAR(11),
	TelefoneMovel VARCHAR(11),
    Email VARCHAR(32) NOT NULL,
    DataNasc DATE,
    DataIngresso TIMESTAMP,
    FotoPerfil BYTEA,
    CONSTRAINT ck_ClassificacaoUsuario_tipoUsuario CHECK(UPPER(TipoUsuario) in  ('ADMINISTRADOR', 'COMUM'))
);

CREATE TABLE ClassificacaoComum (
    NomeUsuario VARCHAR(40) PRIMARY KEY,
    TipoComum VARCHAR(7) NOT NULL,      -- [CLIENTE, ARTISTA]
    NumSeguindo INTEGER NOT NULL DEFAULT 0,
    NumSeguidores INTEGER NOT NULL DEFAULT 0,
    NroAlbums INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT fk_ClassificacaoComum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoUsuario(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_ClassificacaoComum_Positive CHECK((NumSeguindo >= 0) AND (NumSeguidores >= 0) AND (NroAlbums >= 0)),
    CONSTRAINT ck_ClassificacaoComum_TipoComum CHECK(UPPER(TipoComum) in ('CLIENTE', 'ARTISTA'))
);
CREATE TABLE Administrador (
    NomeUsuario VARCHAR(40) PRIMARY KEY,
    CONSTRAINT fk_Adm_Usuario FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoUsuario(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Post (
    id SERIAL,
    DataCriacao TIMESTAMP NOT NULL,
    artista VARCHAR(40) NOT NULL,
    DataUltimaEdicao TIMESTAMP,
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32),
    Arte VARCHAR(32) NOT NULL,
    Visibilidade VARCHAR(10) NOT NULL,
    NroRepostagens INTEGER NOT NULL DEFAULT 0,
    NroAlbums INTEGER NOT NULL DEFAULT 0,
    NroLikes INTEGER NOT NULL DEFAULT 0,
    NroDislikes INTEGER NOT NULL DEFAULT 0,
    NroAmei INTEGER NOT NULL DEFAULT 0,
    NroChoro INTEGER NOT NULL DEFAULT 0,
    NroEdicoes INTEGER NOT NULL DEFAULT 0,
	CONSTRAINT pk_Post PRIMARY KEY (id),
    CONSTRAINT sk_Post UNIQUE(DataCriacao, artista),
    CONSTRAINT fk_Post_Artista FOREIGN KEY(artista) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT ck_Post_Reacoes 
        CHECK((NroAlbums >= 0) AND 
            (NroLikes >= 0) AND (NroDislikes >= 0) AND 
            (NroAmei >= 0) AND (NroChoro >= 0)
		),
	CONSTRAINT ck_Post_Repost CHECK (NroRepostagens >= 0),
	CONSTRAINT ck_Post_Edicoes CHECK (NroEdicoes >= 0)
);

CREATE TABLE Cliente (
    NomeUsuario VARCHAR(40) PRIMARY KEY,
    NroRequisiçõesEmAberto INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesEmProgresso INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesNaoSucedida INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesFeitas INTEGER NOT NULL DEFAULT 0,
    NroReposts INTEGER NOT NULL DEFAULT 0,
    NroAssinaturas INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT fk_Cliente_Comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_Cliente_Positive 
        CHECK(
            (NroRequisiçõesEmAberto >= 0) AND (NroRequisiçõesEmProgresso >= 0) AND 
            (NroRequisiçõesNaoSucedida >= 0) AND (NroRequisiçõesFeitas >= 0) AND 
            (NroReposts >= 0) AND (NroAssinaturas >= 0)
        )
);

CREATE TABLE Artista (
    NomeUsuario VARCHAR(40),
    Preco NUMERIC(10, 2),
    ContaBancaria VARCHAR(32),
    NroAssinantes INTEGER NOT NULL DEFAULT 0,
    NroPosts INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesFinalizadas INTEGER NOT NULL DEFAULT 0,
    NroRequisiçõesEmAndamento INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT pk_Artista PRIMARY KEY (NomeUsuario),
    CONSTRAINT fk_Artista_comum FOREIGN KEY(NomeUsuario) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_Artista_positive
        CHECK(
            (NroAssinantes >= 0) AND (NroPosts >= 0) AND 
            (NroRequisiçõesFinalizadas >= 0) AND (NroRequisiçõesEmAndamento >= 0)
        ),
    CONSTRAINT ck_Artista_preco CHECK((Preco = NULL) OR (Preco >= 0))
);

CREATE TABLE Bloqueia (
    UsuarioBloqueia VARCHAR(40),
    UsuarioBloqueado VARCHAR(40),
    data timestamp,
    CONSTRAINT pk_Bloqueia PRIMARY KEY(UsuarioBloqueia, UsuarioBloqueado, data),
    CONSTRAINT fk_Bloqueia_UsuarioBloqueia FOREIGN KEY(UsuarioBloqueia) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_Bloqueia_UsuarioBloqueado FOREIGN KEY(UsuarioBloqueado) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Segue (
    UsuarioSegue VARCHAR(40),
    UsuarioSeguido VARCHAR(40),
    data TIMESTAMP,
    CONSTRAINT pk_Segue PRIMARY KEY(usuarioSegue, usuarioSeguido, data),
    CONSTRAINT fk_Segue_UsuarioSegue FOREIGN KEY(UsuarioSegue) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_Segue_UsuarioSeguido FOREIGN KEY(UsuarioSeguido) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Banimento (
    Administrador VARCHAR(40),
    Usuario VARCHAR(40),
    data TIMESTAMP,
    Motivo VARCHAR(32) NOT NULL,
    DataTermino TIMESTAMP,
    CONSTRAINT pk_banimento PRIMARY KEY(Administrador, Usuario, data),
    CONSTRAINT fk_banimento_adm FOREIGN KEY(Administrador) REFERENCES ClassificacaoUsuario(NomeUsuario) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_banimento_comum FOREIGN KEY(Usuario) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Repostagem (
    cliente VARCHAR(32),
    post INTEGER,
    dataRepostagem timestamp,
    CONSTRAINT pk_Repostagem PRIMARY KEY(cliente, post, dataRepostagem),
    CONSTRAINT fk_Repostagem_Cliente FOREIGN KEY(cliente) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_Repostagem_Post FOREIGN KEY(post) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Reacao (
    cliente VARCHAR(32),
    post INTEGER,
    reacao VARCHAR(7),          --[Like, Dislike, Amei ou Choro]
    CONSTRAINT pk_Reacao PRIMARY KEY(cliente, post, reacao),
    CONSTRAINT fk_Reacao_Cliente FOREIGN KEY(cliente) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_Reacao_Post FOREIGN KEY(post) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE Edicao (
    id SERIAL,
    DataCriacaoEdicao TIMESTAMP,
    post SERIAL,
    DataEdicaoAnterior TIMESTAMP,
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32) NOT NULL,
    Arte VARCHAR(32) NOT NULL,              -- ?
    Visibilidade VARCHAR(10) NOT NULL,      -- [assinante, publico, privado]
	CONSTRAINT pk_Edicao PRIMARY KEY (id),
    CONSTRAINT sk_Edicao UNIQUE(DataCriacaoEdicao, post),
    CONSTRAINT fk_Edicao_Post FOREIGN KEY (post) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE AlbumArtista (
    Titulo VARCHAR(32),
    artista VARCHAR(40),
    TipoVisualizacao VARCHAR(15) NOT NULL,
    DataCriacao TIMESTAMP NOT NULL,
    NroPosts INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT pk_AlbumArtista PRIMARY KEY(Titulo, Artista),
    CONSTRAINT fk_AlbumArtista_artista FOREIGN KEY(Artista) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT ck_AlbumArtista_positive CHECK(NroPosts >= 0),
    CONSTRAINT ck_album_artista_tipoVisualizacao CHECK(UPPER(TipoVisualizacao) in  ('PUBLICO', 'PRIVADO', 'ASSINANTE'))

);
 
CREATE TABLE AlbumCliente (
    Titulo VARCHAR(32),
    Cliente VARCHAR(32),
    TipoVisualizacao VARCHAR(15) NOT NULL, 
    DataCriacao TIMESTAMP NOT NULL,
    NroReposts INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT pk_AlbumCliente PRIMARY KEY(Titulo, Cliente),
    CONSTRAINT fk_AlbumCliente_cliente FOREIGN KEY(cliente) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT ck_AlbumCliente_positive CHECK(NroReposts >= 0),
    CONSTRAINT ck_AlbumCliente_TipoVisualizacao CHECK(UPPER(TipoVisualizacao) in  ('PUBLICO', 'PRIVADO', 'ASSINANTE'))

);

CREATE TABLE Requisicao (
    DataCriacao TIMESTAMP,
    Cliente VARCHAR(32),
    Titulo VARCHAR(32) NOT NULL,
    Descricao VARCHAR(32),
    Minimo INTEGER NOT NULL,
    Maximo INTEGER NOT NULL,
    Tipo VARCHAR(32) NOT NULL,                  -- ['EXCLUSIVO', 'NORMAL']
    Avaliacaoartista NUMERIC(2,1),              -- Nota entre 0.0 até 10.0
    AvaliacaoCliente NUMERIC(2,1),              -- Nota entre 0.0 até 10.0
    -- Status:
    -- '1' -> Arquivado
    -- '2' -> Em Aberto
    -- '3' -> Cheio e Aguardando Autorização
    -- '4' -> Aceitando e Aguardando Autorização
    -- '5' -> Em Progresso
    -- '6' -> Concluído
    -- '7' -> Disponível
    -- '8' -> Entregue
    status CHAR(1) NOT NULL,
    DataTermino TIMESTAMP,
    NroAceitacoesExclusivas INTEGER NOT NULL DEFAULT 0,
    NroAceitacoesGerais INTEGER NOT NULL DEFAULT 0,
    NroAceitacoesAbertasTotal INTEGER NOT NULL DEFAULT 0,
    NroAceitacoesRejeitadas INTEGER NOT NULL,

    CONSTRAINT pk_Requisicao PRIMARY KEY(DataCriacao, Cliente),
    CONSTRAINT fk_Requisicao_Cliente FOREIGN KEY(Cliente) REFERENCES ClassificacaoComum(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_Requisicao_Estados CHECK(status in  ('1', '2', '3', '4', '5', '6', '7', '8')),
    CONSTRAINT ck_Requisicao_AvaliacaoArtista CHECK(Avaliacaoartista = NULL OR Avaliacaoartista BETWEEN 0 AND 10), 
    CONSTRAINT ck_Requisicao_Positive 
        CHECK(
            (NroAceitacoesExclusivas >= 0) AND (NroAceitacoesGerais >= 0) AND 
            (NroAceitacoesAbertasTotal >= 0) AND (NroAceitacoesRejeitadas >= 0)
        ),
    CONSTRAINT ck_TipoRequisicao CHECK (Tipo in ('EXCLUSIVO', 'NORMAL'))
);

CREATE TABLE Tag (
    Nome VARCHAR(32) PRIMARY KEY,
    Tipo VARCHAR(32) NOT NULL,
    NroPostsRestritos INTEGER NOT NULL DEFAULT 0,
    NroPostsPublicos INTEGER NOT NULL DEFAULT 0,
    NroAlbuns INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT ck_Requisicao_positive 
        CHECK(
            (NroPostsRestritos >= 0) AND (NroPostsPublicos >= 0)
        )
);

CREATE TABLE ClassificacaoPost (
    post SERIAL,
    Tag VARCHAR(32),
    prioridade INTEGER,

    CONSTRAINT pk_ClassificacaoPost PRIMARY KEY(post, Tag),
    CONSTRAINT fk_ClassificacaoPost_post FOREIGN KEY(post) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_ClassificacaoPost_tag FOREIGN KEY(Tag) REFERENCES tag(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_ClassificacaoPost_positive CHECK(prioridade >= 0)

);

CREATE TABLE ClassificacaoEdicao (
    PostEditado SERIAL,
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT pk_ClassificacaoEdicao PRIMARY KEY(PostEditado, Tag),
    CONSTRAINT fk_ClassificacaoEdicao_post FOREIGN KEY(postEditado) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_ClassificacaoEdicao_tag FOREIGN KEY(Tag) REFERENCES tag(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_ClassificacaoEdicao_positive CHECK(prioridade >= 0)
);

CREATE TABLE PostsAlbumArtista (
    Titulo VARCHAR(32),
    artista VARCHAR(40),
    post SERIAL,
    CONSTRAINT pk_PostsAlbumArtista PRIMARY KEY(titulo, Artista, post),
    CONSTRAINT fk_PostsAlbumArtista_album FOREIGN KEY(titulo, artista) REFERENCES AlbumArtista(titulo, artista) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_PostsAlbumArtista_post FOREIGN KEY(post) REFERENCES Post(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PostsAlbumCliente (
    titulo VARCHAR(32),
    cliente VARCHAR(40),
    post SERIAL,
    CONSTRAINT pk_PostsAlbumCliente PRIMARY KEY(titulo, cliente, post),
    CONSTRAINT fk_PostsAlbumCliente_album FOREIGN KEY(titulo, cliente) REFERENCES AlbumCliente(titulo, cliente) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_PostsAlbumCliente_post FOREIGN KEY(post) REFERENCES Post(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TagClassificaAlbumArtista (
    titulo VARCHAR(32),
    artista VARCHAR(40),
    tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT pk_TagClassificaAlbumArtista PRIMARY KEY(titulo, artista, tag),
    CONSTRAINT fk_TagClassificaAlbumArtista_album FOREIGN KEY(titulo, artista) REFERENCES AlbumArtista(titulo, artista) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_TagClassificaAlbumArtista_tag FOREIGN KEY(tag) REFERENCES Tag(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_TagClassificaAlbumArtista_positive CHECK(prioridade >= 0)
);

CREATE TABLE TagClassificaAlbumCliente (
    titulo VARCHAR(32),
    cliente VARCHAR(40),
    tag VARCHAR(32),
    Prioridade INTEGER,
    CONSTRAINT pk_TagClassificaAlbumCliente PRIMARY KEY(titulo, cliente, tag),
    CONSTRAINT fk_TagClassificaAlbumCliente_album FOREIGN KEY(titulo, cliente) REFERENCES AlbumCliente(titulo, cliente) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_TagClassificaAlbumCliente_tag FOREIGN KEY(tag) REFERENCES Tag(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT check_TagClassificaAlbumCliente_positive CHECK(prioridade >= 0)
);

CREATE TABLE ClassificacaoRequisicao (
    dataRequisicao TIMESTAMP,
    cliente VARCHAR(40),
    Tag VARCHAR(32),
    prioridade INTEGER,
    CONSTRAINT pk_ClassificacaoRequisicao PRIMARY KEY(dataRequisicao, Cliente, Tag),
    CONSTRAINT fk_ClassificacaoRequisicao_requisicao FOREIGN KEY(dataRequisicao, cliente) REFERENCES Requisicao(dataCriacao, cliente) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_ClassificacaoRequisicao_tag FOREIGN KEY(Tag) REFERENCES Tag(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_ClassificacaoRequisicao_positive CHECK(prioridade >= 0)

);

CREATE TABLE AssinaturaArtistaCliente (
    artista VARCHAR(40),
    cliente VARCHAR(32),
    DataAssinatura TIMESTAMP NOT NULL,
    DataLimiteAssinatura TIMESTAMP NOT NULL,
    CONSTRAINT pk_AssinaturaArtistaCliente PRIMARY KEY(artista, cliente),
    CONSTRAINT fk_AssinaturaArtistaCliente_artitsta FOREIGN KEY(artista) REFERENCES Artista(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_AssinaturaArtistaCliente_cliente FOREIGN KEY(cliente) REFERENCES Cliente(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Aceitacao (
    id SERIAL,
    artista VARCHAR(40) NOT NULL,
    dataRequisicao TIMESTAMP NOT NULL,
    cliente VARCHAR(32) NOT NULL,
    tipoDeAceitacao VARCHAR(32), -- ['SOMENTE VALOR', 'SOMENTE ESCOPO', 'VALOR E ESCOPO', 'NAO ACEITO']
    valor NUMERIC(2, 2) NOT NULL,
    escopo VARCHAR(32) NOT NULL,
    -- Status:
    -- '1' -> Arquivado
    -- '2' -> Em Aberto
    -- '3' -> Cheio e Aguardando Autorização
    -- '4' -> Aceitando e Aguardando Autorização
    -- '5' -> Em Progresso
    -- '6' -> Concluído
    -- '7' -> Disponível
    -- '8' -> Entregue
    status CHAR(1) NOT NULL,
    CONSTRAINT pk_Aceitacao PRIMARY KEY (id),
    CONSTRAINT ck_Aceitacao_tipoDeAceitacao CHECK(tipoDeAceitacao in ('SOMENTE VALOR', 'SOMENTE ESCOPO', 'VALOR E ESCOPO', 'NAO ACEITO')),
    CONSTRAINT sk_aceitacao UNIQUE(artista, dataRequisicao, cliente),
    CONSTRAINT fk_Aceitacao_artista FOREIGN KEY(artista) REFERENCES Artista(NomeUsuario) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_Aceitacao_requisicao FOREIGN KEY(dataRequisicao, cliente) REFERENCES Requisicao(dataCriacao, cliente) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_Aceitacao_status CHECK(status in ('1', '2', '3', '4', '5', '6', '7', '8')),
    CONSTRAINT ck_Aceitacao_Valor CHECK(valor > 0)
);

CREATE TABLE Renegocia (
	id SERIAL,
    aceitacao SERIAL,
	renegociacaoPrevia INTEGER,
    remetente VARCHAR(32) NOT NULL,
    destinatario VARCHAR(32) NOT NULL,
    ajusteEscopo VARCHAR(32),
    ajusteValor INTEGER,
	CONSTRAINT pk_Renegocia PRIMARY KEY (id, aceitacao),
    CONSTRAINT fk_Renegocia_aceitacao FOREIGN KEY(aceitacao) REFERENCES Aceitacao(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_Renegocia_positive CHECK((ajusteValor = NULL) OR (ajusteValor >= 0))
);

CREATE TABLE Mensagens ( 
    aceitacao SERIAL,
    dataEnvio TIMESTAMP,
    remetente VARCHAR(32),
    Destinatario VARCHAR(32) NOT NULL,
    conteudo VARCHAR(32),
    anexo VARCHAR(32),           -- ?
    CONSTRAINT pk_mensagens PRIMARY KEY (aceitacao, dataEnvio, remetente),
	CONSTRAINT sk_mensagens UNIQUE(aceitacao, dataEnvio, remetente),
    CONSTRAINT fk_Mensagens_aceitacao FOREIGN KEY(aceitacao) REFERENCES aceitacao(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Responde (
    aceitacaoMsgResponde INTEGER,
	dataEnvioResponde TIMESTAMP,
	remetenteResponde VARCHAR(32),
	aceitacaoMsgRespondida INTEGER NOT NULL,
	dataEnvioRespondida TIMESTAMP NOT NULL,
	remetenteRespondida VARCHAR(32) NOT NULL,
	CONSTRAINT pk_Responde PRIMARY KEY (aceitacaoMsgResponde, dataEnvioResponde, remetenteResponde),
	CONSTRAINT fk_Responde_Aceitacao FOREIGN KEY (aceitacaoMsgResponde, dataEnvioResponde, remetenteResponde) REFERENCES Mensagens(aceitacao, dataEnvio, remetente) ON UPDATE CASCADE ON DELETE CASCADE, 
    CONSTRAINT fk_Respondida_Aceitacao FOREIGN KEY (aceitacaoMsgRespondida, dataEnvioRespondida, remetenteRespondida) REFERENCES Mensagens(aceitacao, dataEnvio, remetente) ON UPDATE CASCADE ON DELETE NO ACTION, 
	CONSTRAINT ck_Resposta_Mensagem CHECK (aceitacaoMsgResponde = aceitacaoMsgRespondida)
);