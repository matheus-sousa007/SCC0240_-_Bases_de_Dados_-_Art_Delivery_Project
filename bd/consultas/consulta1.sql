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