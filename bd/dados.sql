INSERT INTO ClassificacaoUsuario VALUES 
('rupestre','COMUM','123456','Pedro da Silva Souza','Av. Trabalhador Sao Carlense',87,'Jardim Diniz', '1145433243', '11932423452','riachobelo@gmail.com', TO_TIMESTAMP('1998-02-10', 'YYYY-MM-DD'), CURRENT_TIMESTAMP, NULL),
('johndoe','COMUM','password123','John Doe','Rua das Flores',123,'São Paulo','1199887766', '11943284235','john.doe@example.com', TO_TIMESTAMP('1990-05-15', 'YYYY-MM-DD'),current_timestamp,NULL),
('rockstar87','COMUM','admin123','Maria Oliveira','Avenida Principal',456,'Rio de Janeiro','2199887766', '21954354367','maria.oliveira@example.com', TO_TIMESTAMP('1987-03-25', 'YYYY-MM-DD'),current_timestamp,'NULL'),
('janesmith','COMUM','pass123','Jane Smith','Avenida das Palmeiras',789,'Belo Horizonte','3199776655', '2194536784','jane.smith@example.com', TO_TIMESTAMP('1985-09-10', 'YYYY-MM-DD'),current_timestamp,NULL),
('eduardomorais','COMUM','pass123','Eduardo Morais','Avenida das Palmeiras',789,'Belo Horizonte','3199776655', '2194536784','jane.smith@example.com', TO_TIMESTAMP('1985-09-10', 'YYYY-MM-DD'),current_timestamp,NULL),
('shaolinporco','COMUM','pass123','Shaolin Matador de Porco','Avenida das Palmeiras',789,'Belo Horizonte','3199776655', '2194536784','jane.smith@example.com', TO_TIMESTAMP('1985-09-10', 'YYYY-MM-DD'),current_timestamp,NULL),
('guswadas','ADMINISTRADOR','pass123','Gustavo Wadas','Avenida das Palmeiras',789,'Belo Horizonte','3199776655', '2194536784','jane.smith@example.com', TO_TIMESTAMP('1985-09-10', 'YYYY-MM-DD'),current_timestamp,NULL),
('strenja56','ADMINISTRADOR','pass123','Osni Brito','Avenida das Palmeiras',789,'Belo Horizonte','3199776655', '2194536784','jane.smith@example.com', TO_TIMESTAMP('1985-09-10', 'YYYY-MM-DD'),current_timestamp,NULL),
('matheussousa007','ADMINISTRADOR','pass123','Matheus Sousa','Avenida das Palmeiras',789,'Belo Horizonte','3199776655', '2194536784','jane.smith@example.com', TO_TIMESTAMP('1985-09-10', 'YYYY-MM-DD'),current_timestamp,NULL);

INSERT INTO ClassificacaoComum VALUES 
('rupestre','CLIENTE',100,200,0),
('johndoe','CLIENTE',500,1000,5),
('rockstar87', 'CLIENTE', 124, 3532, 6),
('janesmith', 'ARTISTA', 506, 307, 2),
('eduardomorais', 'ARTISTA', 506, 307, 2),
('shaolinporco', 'ARTISTA', 506, 307, 2)

INSERT INTO Administrador (nomeUsuario) VALUES 
('guswadas'),
('strenja56'),
('matheussousa007');

INSERT INTO Cliente VALUES
('rupestre',2,1,0,3,0,8,1),
('johndoe', 4,5,6,7,8,9,10),
('rockstar87', 11,12,13,14,15,16, 17);


INSERT INTO Artista VALUES 
('janesmith', 30.25, 'XXXX YYYYY', 25, 50, 3, 4),
('eduardomorais', 50.50, 'AAAA BBBBB', 2, 2, 3),
('shaolinporco', 300.15, 'CCCC DDDDD', 40, 40, 50);

INSERT INTO Post (DataCriacao, artista, DataUltimaEdicao, Titulo, Descricao, Arte, Visibilidade, NroRepostagens, NroAlbums, NroLikes, NroDislikes, NroAmei, NroChoro, NroEdicoes) VALUES 
('2023-04-10 09:45:00','janesmith','2023-06-30 10:30:00','A arte da vida é viver a arte.','Viver a arte é a arte da vida.','imagem1.jpg','Público',5,2,10,2,8,3,1),
('2023-04-11 09:45:00','janesmith','2023-07-01 10:30:00','Explorando a criatividade','Descubra o poder da criatividade em sua vida.','imagem2.jpg','Privado',5,2,10,2,8,3,1),
('2023-04-12 09:45:00','janesmith','2023-07-02 10:30:00','Titulo1','Desc1','imagem2.jpg','PRIVADO',5,6,7,8,9,10,11),
('2023-04-13 09:45:00','janesmith','2023-07-03 10:30:00','Titulo2','Desc2','imagem3.jpg','PRIVADO',5,6,7,8,9,10,11),
('2023-04-22 09:45:00','janesmith','2023-07-04 10:30:00','Titulo3','Desc3','imagem4.jpg','PUBLICO',5,6,7,8,9,10,11),
('2023-04-23 09:45:00','janesmith','2023-07-05 10:30:00','Titulo4','Desc4','imagem5.jpg','PUBLICO',5,6,7,8,9,10,11),
('2023-04-24 09:45:00','janesmith','2023-07-06 10:30:00','Titulo5','Desc5','imagem6.jpg','ASSINANTE',5,6,7,8,9,10,11),
('2023-04-14 09:45:00','eduardomorais','2023-07-07 10:30:00','Titulo6','Desc6','imagem7.jpg','Privado',5,6,7,8,9,10,11),
('2023-04-15 09:45:00','eduardomorais','2023-07-08 10:30:00','Titulo7','Desc7','imagem8.jpg','ASSINANTE',5,6,7,8,9,10,11),
('2023-04-16 09:45:00','eduardomorais','2023-07-09 10:30:00','Titulo8','Desc8','imagem9.jpg','ASSINANTE',5,6,7,8,9,10,11),
('2023-04-17 09:45:00','eduardomorais','2023-07-10 10:30:00','Titulo9','Desc9','imagem10.jpg','Privado',5,6,7,8,9,10,11),
('2023-04-18 09:45:00','shaolinporco','2023-07-11 10:30:00','Titulo10','Desc10','imagem11.jpg','PUBLICO',5,6,7,8,9,10,11),
('2023-04-19 09:45:00','shaolinporco','2023-07-12 10:30:00','Titulo11','Desc11','imagem12.jpg','PUBLICO',5,6,7,8,9,10,11),
('2023-04-20 09:45:00','shaolinporco','2023-07-13 10:30:00','Titulo12','Desc12','imagem13.jpg','ASSINANTE',5,6,7,8,9,10,11),
('2023-04-21 09:45:00','shaolinporco','2023-07-14 10:30:00','Titulo13','Desc13','imagem14.jpg','Privado',5,6,7,8,9,10,11);

INSERT INTO Bloqueia VALUES 
('rupestre', 'rockstar87', '2023-05-06 04:21:06'), 
('johndoe', 'rockstar87', '2023-05-06 04:27:06'),
('shaolinporco', 'rupestre', '2023-05-08 04:27:06');

INSERT INTO Segue VALUES 
('rupestre', 'johndoe', '2023-05-06 17:34:06'),
('janesmith', 'johndoe','2023-05-06 20:49:21'),
('shaolinporco', 'johndoe','2023-05-06 20:49:21'),
('johndoe', 'shaolinporco','2023-05-06 20:49:21'),
('johndoe', 'janesmith','2023-05-06 20:49:21');

INSERT INTO Banimento VALUES 
('matheussousa007', 'rupestre', '2023-07-09 23:59:59', 'Nem eu sei o que ele fez coitado','2023-09-12 23:59:59'),
('strenja56', 'eduardomorais', '2023-07-09 23:59:59', 'Nem eu sei o que ele fez coitado','2023-09-12 23:59:59'),
('strenja56', 'matheussousa007', '2023-07-09 23:59:59', 'Nem eu sei o que ele fez coitado','2023-09-12 23:59:59');

INSERT INTO Repostagem VALUES ('Rupestre', 1, '2023-06-07 17:34:06');

INSERT INTO Reacao (cliente, post, reacao) VALUES ('Rupestre',1,'Like'), ('Rupestre',1,'Amei');

INSERT INTO Edicao (DataCriacaoEdicao, post, DataEdicaoAnterior, Titulo, Descricao, Arte, Visibilidade) VALUES ('2023-06-30 09:00:00',1,'2023-06-29 14:30:00','Nova Edição','Descrição da nova edição','imagem2.jpg','assinante'), 

INSERT INTO AlbumArtista VALUES ('NovoAlbum', 'johndoe', 'ASSINANTE', '2023-07-29 11:30:00', 2);

INSERT INTO AlbumCliente VALUES ('MeuAlbum', 'Rupestre', 'PUBLICO', '2023-08-23 17:45:00', 1);

INSERT INTO Requisicao VALUES 
('2023-07-25 18:15:00', 'rupestre', 'Requisicao 1', 'Não sei o que colocar aqui', 30.00, 60.00, 'EXCLUSIVO', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-25 19:15:00', 'rupestre', 'Requisicao 2', 'Não sei o que colocar aqui', 30.00, 60.00, 'EXCLUSIVO', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-25 20:15:00', 'rupestre', 'Requisicao 3', 'Não sei o que colocar aqui', 30.00, 60.00, 'NORMAL', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-25 21:15:00', 'rupestre', 'Requisicao 4', 'Não sei o que colocar aqui', 30.00, 60.00, 'NORMAL', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-25 22:15:00', 'johndoe', 'Requisicao 1', 'Não sei o que colocar aqui', 30.00, 60.00, 'EXCLUSIVO', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-25 23:15:00', 'johndoe', 'Requisicao 2', 'Não sei o que colocar aqui', 30.00, 60.00, 'NORMAL', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-26 00:15:00', 'johndoe', 'Requisicao 3', 'Não sei o que colocar aqui', 30.00, 60.00, 'NORMAL', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-26 01:15:00', 'rockstar87', 'Requisicao 1', 'Não sei o que colocar aqui', 30.00, 60.00, 'EXCLUSIVO', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-26 02:15:00', 'rockstar87', 'Requisicao 2', 'Não sei o que colocar aqui', 30.00, 60.00, 'EXCLUSIVO', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2),
('2023-07-26 03:15:00', 'rockstar87', 'Requisicao 3', 'Não sei o que colocar aqui', 30.00, 60.00, 'NORMAL', 9.7, 3.8, 1, '2023-10-03 19:00:00', 1, 3, 4, 2);

INSERT INTO Tag VALUES 
('Tag 1', 'Tipo1', 1, 1, 4),
('Tag 2', 'Tipo1', 2, 1, 3),
('Tag 3', 'Tipo1', 1, 1, 2),
('Tag 4', 'Tipo2', 3, 2, 4),
('Tag 5', 'Tipo2', 1, 2, 1),
('Tag 6', 'Tipo2', 2, 1, 2),
('Tag 7', 'Tipo3', 4, 1, 3),
('Tag 8', 'Tipo3', 2, 1, 2),
('Tag 9', 'Tipo4', 3, 2, 4),
('Tag 10','Tipo4', 1, 2, 3);


INSERT INTO ClassificacaoPost VALUES 
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2),
(1, 'NovaTag', 2);

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