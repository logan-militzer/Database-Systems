SELECT ov_col.ptype AS type, COUNT(ov_col.ptype) AS ord
FROM (SELECT mult_t.ordid, P.ptype
	FROM (SELECT com_t.ordid
		FROM (SELECT O.ordid, P.ptype
			FROM Orders O, Details D, Products P
			WHERE O.ordid = D.ordid
			AND D.pcode = P.pcode
			GROUP BY O.ordid, P.ptype) AS com_t
		GROUP BY com_t.ordid
		HAVING COUNT(com_t.ordid) = 1) AS mult_t, Details D, Products P
						WHERE mult_t.ordid = D.ordid
						AND D.pcode = P.pcode
						GROUP BY mult_t.ordid, P.ptype) AS ov_col
GROUP BY ov_col.ptype
ORDER BY ord ASC
;
