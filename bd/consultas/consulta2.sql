SELECT post, nroEdicao, COUNT(*)
	FROM (SELECT post, row_number() OVER (PARTITION BY post ORDER BY yearPrev, monthPrev) nroEdicao, EXTRACT(YEAR FROM dataEdicaoAnterior) AS yearPrev, EXTRACT(MONTH FROM dataEdicaoAnterior) AS monthPrev, EXTRACT(YEAR FROM dataCriacao) AS yearCriacao, EXTRACT(MONTH FROM dataCriacao) AS monthCriacao
			FROM (SELECT post, dataEdicaoAnterior, dataCriacao
					FROM Edicao
					WHERE dataEdicaoAnterior IS NOT NULL)
				UNION
				(SELECT Post.id AS post, Post.dataCriacao AS dataEdicaoAnterior, Edicao.dataCriacao AS dataCriacao
					FROM Edicao
						JOIN Post
						ON Post.id = Edicao.post
					WHERE dataEdicaoAnterior IS NULL))
				JOIN (SELECT EXTRACT(YEAR FROM dataRepostagem) AS yearRepost, EXTRACT(MONTH FROM dataRepostagem) AS monthRepost
					FROM Reposta)
				ON ((yearPrev < yearRepost) OR (yearPrev = yearRepost AND monthPrev <= yearRepost)) AND ((yearCriacao > yearRepost) OR (yearCriacao = yearRepost AND monthCriacao > yearRepost))
	GROUP BY post, nroEdicao