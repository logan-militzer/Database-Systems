SELECT I.invid AS I1
FROM Invoices I, Orders O
WHERE O.ordid = I.ordid
AND I.amount >= (SELECT CAST((SUM(p.price * D.qty) *1.2) AS NUMERIC(50,2))
			FROM Products P, Details D
			WHERE P.pcode = D.pcode 
			AND O.ordid = D.ordid
			GROUP BY D.ordid)
ORDER BY I1 ASC
;
