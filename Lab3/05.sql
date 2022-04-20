SELECT date_ck.ocust AS id
FROM (SELECT DisDT.ocust, DisDT.odate - LAG(DisDT.odate) OVER (PARTITION BY DisDT.ocust
								ORDER BY DisDT.odate ASC) AS gap
	FROM (SELECT DISTINCT O.odate, O.ocust
		FROM Orders O) AS DisDT
	WHERE DisDT.ocust = ANY (SELECT O2.ocust
				FROM Orders O2
				GROUP BY O2.ocust
				HAVING COUNT(DISTINCT O2.odate) >= 5)
	) AS date_ck
GROUP BY id
HAVING AVG(gap) < 30
ORDER BY id ASC
;
