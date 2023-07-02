SELECT B.Artista AS Artista, B.Renegociacoes AS Renegociacoes, AVG(B.Renegociacoes) AS MediaRenegociacoes, MIN(B.Renegociacoes) AS MinRenegociacoes, MAX(B.Renegociacoes) AS MaxRenegociacoes, SUM(B.Renegociacoes) AS TotalRenegociacoes
FROM (
	SELECT DISTINCT A.artista AS Artista, COUNT(*) AS Renegociacoes
	FROM Renegocia AS R
	JOIN Aceitacao AS A
	ON R.Aceitacao = A.id
	GROUP BY (Artista, A.id)
) AS B
GROUP BY (Artista, Renegociacoes);