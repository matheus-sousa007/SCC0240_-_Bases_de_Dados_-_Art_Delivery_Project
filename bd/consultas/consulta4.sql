SELECT COUNT(*), MAX(maxRenegociacoes), AVG(maxRenegociacoes), MIN(maxRenegociacoes) MAX(avgRenegociacoes), AVG(avgRenegociacoes), MIN(avgRenegociacoes), MAX(minRenegociacoes), AVG(minRenegociacoes), MIN(minRenegociacoes)
	FROM (SELECT artista, MAX(renegociacoes) AS maxRenegociacoes, AVG(renegociacoes) AS avgRenegociacoes, MIN(renegociacoes) AS minRenegociacoes
		FROM (SELECT artista, Aceitacao.ID AS aceitacaoID, COUNT(*) AS renegociacoes
				FROM Renegocia
					JOIN Aceitacao
					ON Aceitacao.ID = aceitacao
					GROUP BY artista, Aceitacao.ID)
			UNION
			(SELECT artista, ID AS aceitacaoID, 0 AS renegociacoes
				FROM Aceitacoes
				WHERE Aceitacoes.ID NOT IN (SELECT DISTINCT aceitacao FROM Renegocia))
		GROUP BY artista)