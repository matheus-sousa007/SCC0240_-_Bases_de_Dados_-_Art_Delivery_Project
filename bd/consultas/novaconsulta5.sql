SELECT DISTINCT COUNT(DISTINCT (TCAA.titulo, TCAA.artista))/2 AS ParesTagsAlbumArtista, COUNT(DISTINCT (TCAC.titulo, TCAC.cliente))/2 AS ParesTagsAlbumCliente
FROM TagClassificaAlbumArtista AS TCAA
CROSS JOIN TagClassificaAlbumCliente AS TCAC
JOIN Tag AS T
ON TCAA.tag = T.nome OR TCAC.tag = T.nome
GROUP BY (TCAA.artista, TCAC.cliente);