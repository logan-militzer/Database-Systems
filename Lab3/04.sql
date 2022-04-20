SELECT date_cn.custid AS cid, MAX(gap) AS A1
FROM (SELECT C.custid, O.odate - LAG(O.odate) OVER (PARTITION BY O.ocust
							ORDER BY O.odate ASC) AS gap
	FROM Customers C, Orders O
	WHERE C.custid = O.ocust
	AND O.ocust = ANY (SELECT O2.ocust
				FROM Orders O2
				GROUP BY O2.ocust
				HAVING COUNT(O2.odate) >= 2)
	) AS date_cn
GROUP BY cid
ORDER BY A1 ASC
;
