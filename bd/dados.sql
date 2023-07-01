INSERT INTO ClassificacaoUsuario VALUES ('Rupestre','COMUM','123456','Pedro da Silva Souza','Av. Trabalhador Sao Carlense',87,'Jardim Diniz', '1145433243', '11932423452','riachobelo@gmail.com', TO_TIMESTAMP('1998-02-10', 'YYYY-MM-DD'), CURRENT_TIMESTAMP, NULL),
									    ('johndoe','COMUM','password123','John Doe','Rua das Flores',123,'São Paulo','1199887766', '11943284235','john.doe@example.com', TO_TIMESTAMP('1990-05-15', 'YYYY-MM-DD'),current_timestamp,NULL),
										('rockstar87','ADMINISTRADOR','admin123','Maria Oliveira','Avenida Principal',456,'Rio de Janeiro','2199887766', '21954354367','maria.oliveira@example.com', TO_TIMESTAMP('1987-03-25', 'YYYY-MM-DD'),current_timestamp,'NULL'),
										('janesmith','ADMINISTRADOR','pass123','Jane Smith','Avenida das Palmeiras',789,'Belo Horizonte','3199776655', '2194536784','jane.smith@example.com', TO_TIMESTAMP('1985-09-10', 'YYYY-MM-DD'),current_timestamp,NULL),

INSERT INTO ClassificacaoComum VALUES ('Rupestre','CLIENTE',100,200,0), ('johndoe','ARTISTA',500,1000,5);

INSERT INTO Administrador (nomeUsuario) VALUES ('rockstar87'), ('janesmith');

INSERT INTO Cliente VALUES('rupestre123',2,1,0,3,0,8,1);

INSERT INTO Artista VALUES ('johndoe', 30.25, 'XXXX YYYYY', 25, 50, 3, 4);

INSERT INTO Post (DataCriacao, artista, DataUltimaEdicao, Titulo, Descricao, Arte, Visibilidade, NroRepostagens, NroAlbums, NroLikes, NroDislikes, NroAmei, NroChoro, NroEdicoes) VALUES ('2023-04-10 09:45:00','johndoe','2023-06-30 10:30:00','A arte da vida é viver a arte.','Viver a arte é a arte da vida.','imagem1.jpg','Público',5,2,10,2,8,3,1),
																																													     ('2023-04-10 09:45:00','johndoe','2023-06-30 10:30:00','Explorando a criatividade','Descubra o poder da criatividade em sua vida.','imagem2.jpg','Privado',5,2,10,2,8,3,1);

INSERT INTO Bloqueia VALUES ('Rupestre', 'rockstar87', '2023-05-06 04:21:06'), ('johndoe', 'rockstar87', '2023-05-06 04:27:06');

INSERT INTO Segue VALUES ('Rupestre', 'johndoe', '2023-05-06 17:34:06'), ('janesmith', 'johndoe','2023-05-06 20:49:21');

INSERT INTO Banimento VALUES ('rockstar87', 'Rupestre', '2023-07-09 23:59:59', 'Nem eu sei o que ele fez coitado','2023-09-12 23:59:59');

INSERT INTO Repostagem VALUES ('Rupestre', 1, '2023-06-07 17:34:06');

INSERT INTO Reacao (cliente, post, reacao) VALUES ('Rupestre',1,'Like'), ('Rupestre',1,'Amei');

INSERT INTO Edicao (DataCriacaoEdicao, post, DataEdicaoAnterior, Titulo, Descricao, Arte, Visibilidade) VALUES ('2023-06-30 09:00:00',1,'2023-06-29 14:30:00','Nova Edição','Descrição da nova edição','imagem2.jpg','assinante'), 

INSERT INTO AlbumArtista VALUES ('NovoAlbum', 'johndoe', 'ASSINANTE', '2023-07-29 11:30:00', 2);

INSERT INTO AlbumCliente VALUES ('MeuAlbum', 'Rupestre', 'PUBLICO', '2023-08-23 17:45:00', 1);

INSERT INTO Requisicao VALUES ('2023-07-25 18:15:00', 'Rupestre', 'Nova Requisicao', 'Não sei o que colocar aqui', 30.00, 60.00, 'EXCLUSIVO', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2);

INSERT INTO Tag VALUES ('NovaTag', 'NovoTipo', 1, 3, 4);

INSERT INTO ClassificacaoPost VALUES (1, 'NovaTag', 2);

INSERT INTO ClassificacaoEdicao VALUES (1, 'NovaTag', 1);

INSERT INTO PostsAlbumArtista VALUES ('NovoAlbum', 'johndoe', 1);

INSERT INTO PostsAlbumCliente VALUES ('MeuAlbum', 'Rupestre', 1);

INSERT INTO TagClassificaAlbumArtista VALUES ('NovoAlbum', 'johndoe', 'NovaTag', 2);

INSERT INTO TagClassificaAlbumCliente VALUES ('MeuAlbum', 'Rupestre', 'NovaTag', 1);

INSERT INTO ClassificacaoRequisicao VALUES ('2023-08-16 11:45:12', 'Rupestre', 'NovaTag', 1);

INSERT INTO AssinaturaArtistaCliente VALUES ('johndoe', 'Rupestre', '2023-08-23 11:30:00', '2023-09-15 17:35:49');

INSERT INTO Aceitacao(artista, dataRequisicao, cliente, tipoAceitacao, valor, escopo, status) VALUES ('johndoe', '2023-07-25 18:15:00', 'Rupestre', 'EXCLUSIVO', 30.00, 1);

INSERT INTO Renegocia(aceitacao, renegociacaoPrevia, remetente, destinatario, ajusteEscopo, ajusteValor) VALUES (1, NULL, 'Rupestre', 'johndoe', 'Este está bom!', 75.99);

INSERT INTO Mensagens VALUES (1, '2023-08-13 14:50:35', 'Rupestre', 'johndoe', 'Não sei o que tem!', 'Não sei o que colocar aqui!'), (1, '2023-08-14 14:50:35', 'johndoe', 'Rupestre', 'Não sei o que tem!', 'Não sei o que colocar aqui!');

INSERT INTO Responde VALUES (1, '2023-08-14 14:50:35', 'johndoe', 1, '2023-08-13 14:50:35', 'Rupestre');