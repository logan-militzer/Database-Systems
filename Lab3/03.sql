SELECT id, total
FROM (SELECT O.ocust AS id, SUM(D.qty * P.price) AS total
	FROM Orders O, Details D, Products P
	WHERE O.ordid = D.ordid
	AND P.pcode = D.pcode
	AND O.odate >= '2016-01-01'
	AND O.odate <= '2016-06-30'
	AND P.ptype = 'MUSIC'
	GROUP BY O.ocust
	HAVING SUM(D.qty * P.price) < 50) AS R1

UNION

SELECT C2.custid, 0.00
FROM Customers C2
WHERE C2.custid <> ALL (SELECT O3.ocust
			FROM Orders O3, Details D3, Products P3
			WHERE O3.ordid = D3.ordid
			AND P3.pcode = D3.pcode
			AND O3.odate >= '2016-01-01'
			AND O3.odate <= '2016-06-30'
			AND P3.ptype = 'MUSIC')
ORDER BY id ASC
;
