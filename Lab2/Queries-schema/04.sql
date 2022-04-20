SELECT T1.ptype, T1.ocust AS T1C
FROM (SELECT P.ptype, O.ocust, SUM(D.qty) AS R1qty
	FROM Orders O, Details D JOIN Products P ON D.pcode = P.pcode
	WHERE D.ordid = O.ordid
	GROUP BY O.ocust, P.ptype
) AS T1
	
WHERE R1qty >= ALL (SELECT SUM(D2.qty) AS R1qty
			FROM Products P2, Orders O2 JOIN Details D2 ON O2.ordid = D2.ordid
			WHERE D2.pcode = P2.pcode
			AND T1.ptype = P2.ptype
			GROUP BY O2.ocust, P2.ptype)
ORDER BY T1C ASC
;
