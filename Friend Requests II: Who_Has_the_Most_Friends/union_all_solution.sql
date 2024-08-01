SELECT 
    id, COUNT(*) AS num
FROM
    (SELECT 
        r1.requester_id AS id, r1.accept_date
    FROM
        requestaccepted r1 
    UNION ALL 
    SELECT 
        r2.accepter_id AS id, r2.accept_date
    FROM
        requestaccepted r2) t
GROUP BY 1
ORDER BY num DESC
LIMIT 1;
