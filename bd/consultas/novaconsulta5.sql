SELECT Nome, ParesTagsAlbumArtista, ParesTagsAlbumCliente
FROM (
	SELECT DISTINCT T.nome AS Nome, COUNT(DISTINCT (TCAA.titulo, TCAA.artista))/2 AS ParesTagsAlbumArtista, COUNT(DISTINCT (TCAC.titulo, TCAC.cliente))/2 AS ParesTagsAlbumCliente
	FROM TagClassificaAlbumArtista AS TCAA
	CROSS JOIN TagClassificaAlbumCliente AS TCAC
	JOIN Tag AS T
	ON TCAA.tag = T.nome OR TCAC.tag = T.nome
	GROUP BY (T.nome, TCAA.artista, TCAC.cliente)
) AS F
WHERE ParesTagsAlbumArtista > 1 OR ParesTagsAlbumCliente > 1;