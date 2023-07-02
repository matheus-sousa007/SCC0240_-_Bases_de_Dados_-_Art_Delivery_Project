SELECT F.idPost, F.idEdicao, COUNT(*) AS Qtd_Repostagens
FROM 
(
	SELECT P.id AS idPost, E.id AS idEdicao, P.dataCriacao, E.dataCriacaoEdicao as dataEdicao, E.dataEdicaoAnterior AS edicaoAnterior
	FROM Post P
	JOIN Edicao E
	ON P.id = E.post
	WHERE E.dataCriacaoEdicao IS NOT NULL AND P.dataCriacao < E.dataCriacaoEdicao AND (E.dataEdicaoAnterior IS NULL OR (E.dataEdicaoAnterior IS NOT NULL AND E.dataEdicaoAnterior < E.dataCriacaoEdicao))
) AS F
JOIN
(
	SELECT post, dataRepostagem FROM Repostagem
) AS R
ON R.post = F.idPost AND R.post = F.idEdicao AND R.dataRepostagem > F.dataEdicao AND R.dataRepostagem > F.dataCriacao AND (F.edicaoAnterior IS NULL OR (F.edicaoAnterior IS NOT NULL AND F.edicaoAnterior < R.dataRepostagem))
GROUP BY (F.idPost, F.idEdicao)
;