SELECT C.country, COUNT(O.ocust) AS C1
FROM customers C LEFT JOIN Orders O ON O.ocust = C.custid
WHERE O.odate >= '2016-01-01' 
AND O.odate <= '2016-12-31' OR O.ordid IS NULL
GROUP BY country
ORDER BY C1 ASC
;
