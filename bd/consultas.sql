-- Consulta 1: artistas que possuem Aceitações que foram mais aceitas do que rejeitadas por Clientes

CREATE VIEW AceitacoesAceitasVsRejeitadas AS 
SELECT A.artista AS artista, R.cliente AS cliente, A.aceitacoesAceitas, R.aceitacoesRejeitadas
FROM 
(
	SELECT artista, cliente, COUNT(*) AS aceitacoesAceitas
	FROM Aceitacao
	WHERE status IN ('4', '5', '6', '7', '8')
	GROUP BY artista, cliente
) A
JOIN
(
	SELECT artista, cliente, COUNT(*) AS aceitacoesRejeitadas
	FROM Aceitacao
	WHERE status = '1'
	GROUP BY artista, cliente
) R
	ON A.artista = R.artista AND A.cliente = R.cliente
;

SELECT MA.artista AS artista, MA.clienteMaisAceitas, MR.clienteMaisRejeitadas
FROM 
(
	SELECT artista, COUNT(*) AS clienteMaisAceitas
	FROM AceitacoesAceitasVsRejeitadas
	WHERE aceitacoesAceitas > aceitacoesRejeitadas
	GROUP BY artista
) MA
JOIN
(
	SELECT artista, COUNT(*) AS clienteMaisRejeitadas
	FROM AceitacoesAceitasVsRejeitadas
	WHERE aceitacoesAceitas < aceitacoesRejeitadas
	GROUP BY artista
) MR
	ON MA.artista = MR.artista
	WHERE clienteMaisAceitas > clienteMaisRejeitadas
;

-- Consulta 2: número de repostagens para cada Edição feita sobre um Post.
/*
SELECT A.IDAluno, A.Nome
FROM Alunos A
WHERE NOT EXISTS (
    SELECT D.IDDisciplina
    FROM Disciplinas D
    WHERE NOT EXISTS (
        SELECT *
        FROM Matriculas M
        WHERE M.IDAluno = A.IDAluno
        AND M.IDDisciplina = D.IDDisciplina
    )
);

*/

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

-- Consulta 3: média das repostagens mensais feitas por assinantes e não assinantes de cada artista.

SELECT DISTINCT P.artista, CASE WHEN R.cliente = AAC.cliente THEN 'ASSINANTE'
							ELSE 'NAO ASSINANTE' END AS AssinaturaCliente,
	CASE EXTRACT(MONTH FROM R.dataRepostagem)
    	WHEN 1 THEN 'Janeiro'
    	WHEN 2 THEN 'Fevereiro'
    	WHEN 3 THEN 'Março'
    	WHEN 4 THEN 'Abril'
    	WHEN 5 THEN 'Maio'
    	WHEN 6 THEN 'Junho'
    	WHEN 7 THEN 'Julho'
    	WHEN 8 THEN 'Agosto'
    	WHEN 9 THEN 'Setembro'
    	WHEN 10 THEN 'Outubro'
    	WHEN 11 THEN 'Novembro'
    	WHEN 12 THEN 'Dezembro'
	END AS dataRepostagem,
COUNT(*) AS NroRepostagens
FROM Repostagem AS R
JOIN Post AS P
ON R.post = P.id
CROSS JOIN AssinaturaArtistaCliente AS AAC
GROUP BY (P.artista, AssinaturaCliente, dataRepostagem);


-- Consulta 4: números máximo, médio, mínimo e total das Renegociações de Aceitações feitas por Artistas.

SELECT B.Artista AS Artista, B.Renegociacoes AS Renegociacoes, AVG(B.Renegociacoes) AS MediaRenegociacoes, MIN(B.Renegociacoes) AS MinRenegociacoes, MAX(B.Renegociacoes) AS MaxRenegociacoes, SUM(B.Renegociacoes) AS TotalRenegociacoes
FROM (
	SELECT DISTINCT A.artista AS Artista, COUNT(*) AS Renegociacoes
	FROM Renegocia AS R
	JOIN Aceitacao AS A
	ON R.Aceitacao = A.id
	GROUP BY (Artista, A.id)
) AS B
GROUP BY (Artista, Renegociacoes);

-- Consulta 5: número de álbums tanto de artistas como de clientes que possuem mais de 2 tags por tag.

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