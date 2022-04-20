SELECT C.custid
FROM Customers C, Orders O, Details D, Products P
WHERE O.ocust = C.custid
AND P.pcode = D.pcode
AND O.ocust NOT IN (SELECT O2.ocust
		FROM Customers C2, Orders O2, Details D2, Products P2
		WHERE O2.ocust = C2.custid
		AND O2.ordid = D2.ordid
		AND P2.pcode = D2.pcode
		AND P2.ptype = 'BOOK'
		AND O2.odate >= '2016-01-01' 
		AND O2.odate <= '2016-12-31'
		GROUP BY O2.ocust)

UNION

SELECT C.custid
FROM Customers C
WHERE C.custid <> ALL (SELECT O3.ocust
			FROM Orders O3)
GROUP BY C.custid
;
