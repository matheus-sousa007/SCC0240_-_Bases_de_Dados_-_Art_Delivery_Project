VIEW ArtistaRespostadoPorCliente
AS SELECT artista, cliente
	FROM Reposta
		JOIN Post
		ON Reposta.post = Post.id
    GROUP BY artista, cliente;

VIEW ArtistaAssinadoPorcliente
AS SELECT artista, cliente
    FROM AssinaturaArtistaCliente
    ORDER BY artista, cliente

SELECT AvgRepostagensPorNaoAssinantes.month AS month, AvgRepostagensPorNaoAssinantes.year AS year, mediaRepostagensAssinantes, mediaRepostagensNaoAssinantes
	FROM (SELECT month, year, AVG(nro_repostagens) AS mediaRepostagensAssinantes
			FROM (SELECT Post.artista AS artista, EXTRACT(MONTH FROM dataRespostagem) AS month, EXTRACT(YEAR FROM dataRespostagem) AS year, Resposta.cliente AS cliente, COUNT(*) AS nro_repostagens
				FROM (Reposta
					JOIN post
					ON Reposta.post = Post.id)
					JOIN ArtistaAssinadoPorCliente
					ON (ArtistaAssinadoPorCliente.artista = Post.artista AND ArtistaAssinadoPorCliente.cliente = Reposta.cliente)
				GROUP BY Post.artista, month, year, Resposta.cliente)
			GROUP BY month, year) AvgRepostagensPorAssinantes
	JOIN (SELECT month, year, AVG(nro_repostagens) AS mediaRepostagensNaoAssinantes
			FROM (SELECT Post.artista AS artista, EXTRACT(MONTH FROM dataRespostagem) AS month, EXTRACT(YEAR FROM dataRespostagem) AS year, Resposta.cliente AS cliente, COUNT(*) AS nro_repostagens
				FROM (Reposta
					JOIN post
					ON Reposta.post = Post.id)
					JOIN (SELECT * FROM ArtistaRepostadoPorCliente NOT IN (ArtistaAssinadoPorCliente)) ArtistaRepostadoPorNaoAssinate
					ON (ArtistaRepostadoPorNaoAssinate.artista = Post.artista AND ArtistaRepostadoPorNaoAssinate.cliente = Reposta.cliente)
				GROUP BY Post.artista, month, year, Resposta.cliente)
			GROUP BY month, year) AvgRepostagensNaoPorAssinantes
	ON AvgRepostagensPorAssinantes.month = AvgRepostagensPorNaoAssinantes.month