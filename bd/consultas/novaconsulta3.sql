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