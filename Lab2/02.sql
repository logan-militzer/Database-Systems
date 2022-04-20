SELECT R.ptype, CAST(AVG(R.sum1) AS NUMERIC(50, 2)) AS avg1
FROM (SELECT D.ordid, P.ptype, SUM(D.qty) AS sum1
	FROM Products P, Details D
	WHERE P.pcode = D.pcode
	GROUP BY D.ordid, P.ptype) AS R
GROUP BY R.ptype
ORDER BY avg1 ASC
;
