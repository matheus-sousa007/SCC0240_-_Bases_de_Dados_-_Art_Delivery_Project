INSERT INTO tag ( nome, tipo, nropostsrestritos, nropostspublicos, nroalbuns ) VALUES ( 'Grafite', 'pintura', 1462, 1462, 1461 ); 
INSERT INTO tag ( nome, tipo, nropostsrestritos, nropostspublicos, nroalbuns ) VALUES ( 'Escultura', 'pintura', 1803, 142, 1837 ); 
INSERT INTO tag ( nome, tipo, nropostsrestritos, nropostspublicos, nroalbuns ) VALUES ( 'Tinta oleo', 'artes plasticas', 994, 134, 1837 ); 
INSERT INTO tag ( nome, tipo, nropostsrestritos, nropostspublicos, nroalbuns ) VALUES ( 'Aquarela', 'artes plasticas', 1972, 1536, 1359 ); 

INSERT INTO classificacaousuario ( nomeusuario, tipousuario, senha, nome, logradouro, nroendereco, cidade, telefonefixo, telefonemovel, email, datanasc, dataingresso, fotoperfil ) VALUES ( 'Natan Sanches', 'COMUM', 'pass84582517', 'Jeferson neto Migue Tavares ', 'Rua Tome Figueira ', 1766, 'Avenida Sao rosais', '7386318186', '5275606482', 'miguesilva64@hotmail.com', '2008-11-29', '2008-09-18 12:37:49.056', NULL ); 
INSERT INTO classificacaousuario ( nomeusuario, tipousuario, senha, nome, logradouro, nroendereco, cidade, telefonefixo, telefonemovel, email, datanasc, dataingresso, fotoperfil ) VALUES ( 'Picasso', 'COMUM', 'pass84582517', 'Jeferson neto Migue Tavares ', 'Rua Tome Figueira', 1766, 'Avenida Sao rosais 
', '7386318186', '5275606482', 'miguesilva64@hotmail.com', '2008-11-29', '2008-09-18 12:37:49.056', NULL ); 
INSERT INTO classificacaousuario ( nomeusuario, tipousuario, senha, nome, logradouro, nroendereco, cidade, telefonefixo, telefonemovel, email, datanasc, dataingresso, fotoperfil ) VALUES ( 'DaVince', 'COMUM', 'pass84582517', 'Jeferson neto Migue Tavares ', 'Rua Tome Figueira ', 1766, 'Avenida Sao rosais 
', '7386318186', '5275606482', 'miguesilva64@hotmail.com', '2008-11-29', '2008-09-18 12:37:49.056', NULL ); 
INSERT INTO classificacaousuario ( nomeusuario, tipousuario, senha, nome, logradouro, nroendereco, cidade, telefonefixo, telefonemovel, email, datanasc, dataingresso, fotoperfil ) VALUES ( 'Alvez Lopes', 'COMUM', 'pass84582517', 'Jeferson neto Migue Tavares ', 'Rua Tome Figueira', 1766, 'Avenida Sao rosais 
', '7386318186', '5275606482', 'miguesilva64@hotmail.com', '2008-11-29', '2008-09-18 12:37:49.056', NULL ); 
INSERT INTO classificacaousuario ( nomeusuario, tipousuario, senha, nome, logradouro, nroendereco, cidade, telefonefixo, telefonemovel, email, datanasc, dataingresso, fotoperfil ) VALUES ( 'Detoni', 'ADMINISTRADOR', 'pass63721526', 'Jorge costa Andre silva ', 'Avenida Tome Paulo ', 4889, 'Avenida Tome Paulo 
', '7655666869', '6082751827', 'gabrielneto76@gmail.com', '2008-04-04', '2008-03-19 06:50:22.976', NULL ); 
INSERT INTO classificacaousuario ( nomeusuario, tipousuario, senha, nome, logradouro, nroendereco, cidade, telefonefixo, telefonemovel, email, datanasc, dataingresso, fotoperfil ) VALUES ( 'Paulo', 'ADMINISTRADOR', 'pass63721526', 'Jorge costa Andre silva ', 'Avenida Tome Paulo ', 4889, 'Avenida Tome Paulo 
', '7655666869', '6082751827', 'gabrielneto76@gmail.com', '2008-04-04', '2008-03-19 06:50:22.976', NULL ); 

INSERT INTO administrador ( nomeusuario ) VALUES ( 'Detoni' ); 
INSERT INTO administrador ( nomeusuario ) VALUES ( 'Paulo' ); 
INSERT INTO classificacaocomum ( nomeusuario, tipocomum, numseguindo, numseguidores, nroalbums ) VALUES ( 'Natan Sanches', 'CLIENTE', 1462, 1462, 1461 ); 
INSERT INTO classificacaocomum ( nomeusuario, tipocomum, numseguindo, numseguidores, nroalbums ) VALUES ( 'Alvez Lopes', 'CLIENTE', 1803, 142, 1837 ); 

INSERT INTO classificacaocomum ( nomeusuario, tipocomum, numseguindo, numseguidores, nroalbums ) VALUES ( 'DaVince', 'ARTISTA', 1462, 1462, 1461 ); 
INSERT INTO classificacaocomum ( nomeusuario, tipocomum, numseguindo, numseguidores, nroalbums ) VALUES ( 'Picasso', 'ARTISTA', 1803, 142, 1837 ); 

INSERT INTO post VALUES ( 0, '2008-09-24 11:02:02.368', 'DaVince', '2008-07-24 19:11:55.264', 'Arte daquele mas bonita ', 'Arte assado preto e branco', 'Arte assim assado colorida ', 'PRIVADO', 1461, 1460, 1461, 1461, 1460, 1460, 1460 ); 
INSERT INTO post VALUES ( 1, '2008-02-06 18:33:22.688', 'DaVince', NULL, 'Arte tem que ser colorida', 'Arte assim mas preto e branco ', 'Arte jeito assado colorida ', 'PUBLICO', 1194, 1533, 516, 855, 550, 889, 1872 ); 
INSERT INTO post VALUES ( 2, '2008-05-30 01:08:58.368', 'Picasso', '2008-01-25 13:34:54.08', 'Arte assado preto e branco', 'Arte jeito assado bonita ', 'Arte assim mas colorida ', 'PUBLICO', 400, 1540, 118, 1259, 962, 103, 681 ); 
INSERT INTO post VALUES ( 3, '2008-05-29 01:57:02.976', 'Picasso', '2008-10-08 02:29:25.504', 'Arte daquele assado colorida ', 'Arte so assado preto e branco ', 'Arte assim mas colorida ', 'PRIVADO', 1617, 1182, 488, 53, 1876, 1440, 746 ); 
INSERT INTO post VALUES ( 4, '2008-03-16 23:34:00.32', 'DaVince', '2008-03-24 03:54:26.048', 'Arte tem que ser colorida', 'Arte jeito mas colorida ', 'Arte daquele assado preto e branco ', 'PUBLICO', 1118, 1859, 1638, 378, 80, 821, 599 ); 
INSERT INTO post VALUES ( 5, '2008-01-14 06:17:28.192', 'DaVince', '2008-08-29 15:14:49.856', 'Arte so assado colorida ', 'Arte daquele mas bonita ', 'Arte assim assado colorida ', 'PRIVADO', 1433, 779, 741, 87, 816, 162, 124 ); 
INSERT INTO edicao VALUES ( 0, '2008-02-06 18:33:22.688', 4, '2008-07-24 19:11:55.264', 'Banquete pontos preto e branco', 'Banquete pontos colorida', 'Arte assim assado colorida ', 'PRIVADO' ); 
INSERT INTO edicao VALUES ( 1, '2008-05-29 01:57:02.976', 1, NULL, 'Banquete pontos', 'A fonte preto e branco', 'Arte jeito assado colorida ', 'PUBLICO' ); 

INSERT INTO cliente VALUES ( 'Natan Sanches', 1462, 1462, 1462, 1461, 1461, 1462 ); 
INSERT INTO cliente VALUES ( 'Alvez Lopes', 820, 1803, 142, 1837, 177, 1159 ); 

INSERT INTO classificacaopost VALUES ( 4, 'Tinta oleo', 29 ); 
INSERT INTO classificacaopost VALUES ( 4, 'Grafite', NULL ); 
INSERT INTO classificacaoedicao VALUES ( 4, 'Tinta oleo', 29 ); 
INSERT INTO classificacaoedicao VALUES ( 4, 'Grafite', NULL ); 

INSERT INTO bloqueia VALUES ( 'Natan Sanches', 'Alvez Lopes', '2008-09-24 13:23:41.568' ); 
INSERT INTO bloqueia VALUES ( 'Alvez Lopes', 'Natan Sanches', '2008-04-17 08:01:08.992' );

INSERT INTO banimento VALUES ( 'Detoni', 'Natan Sanches', '2008-09-24 13:23:41.568', 'brigou Com geral. ', '2008-11-28 04:05:35.36' ); 
INSERT INTO banimento VALUES ( 'Detoni', 'Alvez Lopes', '2008-04-17 08:01:08.992', 'Xingou Com geral. ', '2008-10-23 17:23:43.744' ); 
INSERT INTO artista VALUES ( 'Picasso', 7308.78, '308084-82', 731, 731, 731, 731 ); 
INSERT INTO artista VALUES ( 'DaVince', 4100.81, '517329-63', 71, 919, 88, 580 ); 
INSERT INTO albumcliente VALUES ( 'monalisa preto e branco', 'Alvez Lopes', 'PRIVADO', '2008-09-24 12:36:27.136', 1568971868 ); 
INSERT INTO albumcliente VALUES ( 'monalisa preto e branco', 'Natan Sanches', 'PRIVADO', '2008-07-24 19:11:55.264', 1972923321 ); 
INSERT INTO albumartista VALUES ( 'monalisa preto e branco', 'Picasso', 'PRIVADO', '2008-09-24 12:36:27.136', 58 ); 
INSERT INTO albumartista VALUES ( 'monalisa preto e branco', 'DaVince', 'PRIVADO', '2008-07-24 19:11:55.264', 73 ); 
INSERT INTO tagclassificaalbumcliente VALUES ( 'monalisa preto e branco', 'Alvez Lopes', 'Tinta oleo', 112 ); 
INSERT INTO tagclassificaalbumcliente VALUES ( 'monalisa preto e branco', 'Natan Sanches', 'Escultura', 13 ); 
INSERT INTO tagclassificaalbumartista VALUES ( 'monalisa preto e branco', 'DaVince', 'Tinta oleo', 112 ); 
INSERT INTO tagclassificaalbumartista VALUES ( 'monalisa preto e branco', 'Picasso', 'Escultura', 13 ); 
INSERT INTO segue VALUES ( 'DaVince', 'Picasso', '2008-09-24 13:23:41.568' ); 
INSERT INTO segue VALUES ( 'Picasso', 'DaVince', '2008-04-17 08:01:08.992' );

INSERT INTO requisicao VALUES ( '2008-10-31 07:22:38.464', 'Natan Sanches', 'Arte so assado colorida ', 'Arte jeito assado colorida ', 2192, 6653, 'NORMAL', 5.7, 8.9, '3', '2008-06-12 01:27:04.832', 1461, 1460, 1460, 1460 ); 


INSERT INTO requisicao VALUES ( '2008-10-31 07:22:38.464', 'Alvez Lopes', 'Arte so tem queser colorida ', 'Arte daquele assado colorida ', 2756, 3441, 'NORMAL', NULL, NULL, '7', '2008-05-31 02:01:29.216', 855, 550, 889, 1872 ); 

INSERT INTO repostagem VALUES ( 'Natan Sanches', 4, '2008-09-24 13:23:41.568' ); 
INSERT INTO repostagem VALUES ( 'Alvez Lopes', 0, '2008-04-17 08:01:08.992' ); 

INSERT INTO reacao VALUES ( 'Natan Sanches', 4, 'Amei' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 0, 'Like' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 2, 'Amei' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 2, 'Like' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 0, 'Amei' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 1, 'Like' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 3, 'Dislike' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 5, 'Like' ); 
INSERT INTO reacao VALUES ( 'Natan Sanches', 4, 'Choro' ); 

INSERT INTO postsalbumcliente VALUES ( 'monalisa preto e branco', 'Alvez Lopes', 4 ); 
INSERT INTO postsalbumcliente VALUES ( 'monalisa preto e branco', 'Natan Sanches', 1 ); 

INSERT INTO postsalbumartista VALUES ( 'monalisa preto e branco', 'DaVince', 4 ); 
INSERT INTO postsalbumartista VALUES ( 'monalisa preto e branco', 'DaVince', 1 ); 



INSERT INTO classificacaorequisicao VALUES ( '2008-10-31 07:22:38.464', 'Alvez Lopes', 'Tinta oleo', 56 ); 
INSERT INTO classificacaorequisicao VALUES ( '2008-10-31 07:22:38.464', 'Natan Sanches', 'Escultura', 7 ); 


INSERT INTO assinaturaartistacliente VALUES ( 'DaVince', 'Natan Sanches', '2008-09-24 13:23:41.568', '2008-09-24 12:36:27.136' ); 
INSERT INTO assinaturaartistacliente VALUES ( 'DaVince', 'Alvez Lopes', '2008-04-17 08:01:08.992', '2008-07-24 19:11:55.264' ); 

INSERT INTO aceitacao VALUES ( 0, 'Picasso', '2008-10-31 07:22:38.464', 'Alvez Lopes', 'SOMENTE ESCOPO', 0.73, 'Arte assim assado colorida ', '5' ); 
INSERT INTO aceitacao VALUES ( 1, 'DaVince', '2008-10-31 07:22:38.464', 'Natan Sanches', 'NAO ACEITO', 0.09, 'Arte jeito assado colorida ', '1' ); 

INSERT INTO renegocia VALUES ( 1569741370, 1, 587, 'Tavares', 'Tavares', 'Arte assado preto e branco', 739 ); 
INSERT INTO renegocia VALUES ( 516548019, 0, NULL, 'neto', 'Tavares', 'Arte assim mas preto e branco ', 1556 ); 

INSERT INTO mensagens VALUES ( 1, '2008-02-06 18:33:22.688', 'Alvez Lopes', 'Cindy knows Mike. ', 'I knows Tony. ', 'John called Florian. ' ); 
INSERT INTO mensagens VALUES ( 1, '2008-02-06 18:33:22.688', 'Natan Sanches', 'Cindy knows Mike. ', 'John called Rolph. ', 'JArte jeito assado colorida ' ); 


INSERT INTO responde VALUES ( 1, '2008-02-06 18:33:22.688', 'Alvez Lopes', 1, '2008-02-06 18:33:22.688', 'Alvez Lopes' ); 
INSERT INTO responde VALUES ( 1, '2008-02-06 18:33:22.688', 'Natan Sanches', 1, '2008-02-06 18:33:22.688', 'Natan Sanches' );
