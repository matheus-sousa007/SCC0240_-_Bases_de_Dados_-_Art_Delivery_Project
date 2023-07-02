VIEW TagsAlbunsClientes
AS SELECT AC.titulo AS titulo, AC.cliente AS dono, TCAC.tag AS tag
	FROM TagClassificaAlbumCliente TCAC 
		JOIN AlbumCliente AC
		ON (AC.titulo = TCAC.titulo AND AC.cliente = TCAC.cliente)

VIEW TagsAlbunsArtistas
AS SELECT AA.titulo AS titulo, AA.artista AS dono, TCAA.tag AS tag
	FROM TagClassificaAlbumArtista TCAA
		JOIN AlbumArtista AA
		ON (AA.titulo = TCAA.titulo AND AA.cliente = TCAA.cliente)


SELECT tag1, tag2, COUNT(*)
	FROM ((SELECT TAC1.titulo AS titulo, TAC1.dono AS dono, "cliente" AS tipoDono, TAC1.tag AS tag1, TAC2.tag AS tag2
			FROM TagsAlbunsClientes TAC1
				INNER JOIN TagsAlbunsClientes TAC2
				ON TAC1.tag > TAC2.tag)
		UNION
		(SELECT TAA1.titulo AS titulo, TAA1.dono AS dono, "artista" AS tipoDono, TAA1.tag AS tag1, TAA2.tag AS tag2
			FROM TagsAlbunsArtistas TAA1
				INNER JOIN TagsAlbunsArtistas TAA2
				ON TAA1.tag > TAA2.tag))
	GROUP BY tag1, tag2