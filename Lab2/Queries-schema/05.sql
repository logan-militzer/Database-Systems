SELECT Result.ocust AS RO, COUNT(Result.ocust), COALESCE(CAST(AVG(Result.sum1) AS NUMERIC(50, 2)), 0.00) AS avg1
FROM (SELECT T1.ordid, T1.sum1, T1.ocust
	FROM (SELECT O.ordid, SUM(D.qty*P.price) AS sum1, O.ocust
		FROM Orders O, Details D, Products P
		WHERE O.ordid = D.ordid
		AND P.pcode = D.pcode
		GROUP BY O.ordid, O.ocust
		) AS T1
	UNION (
	SELECT O2.ordid, 0.00, O2.ocust
	FROM Orders O2
	WHERE O2.ordid <> ALL (SELECT D2.ordid
				FROM Details D2)
		)
	) AS Result
GROUP BY RO
UNION (
SELECT C3.custid, 0, NULL
FROM Customers C3
WHERE C3.custid <> ALL (SELECT O4.ocust
			FROM Orders O4)
)
ORDER BY avg1 ASC
;
