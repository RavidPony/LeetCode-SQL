SELECT transaction_id
FROM (
    SELECT day, transaction_id, amount,
           RANK() OVER (PARTITION BY DATE(day) ORDER BY amount DESC) AS ranks
    FROM Transactions
) tmp
WHERE ranks = 1
ORDER BY transaction_id;

-- The RANK() function is used to assign a rank to each transaction amount within the same day (PARTITION BY DATE(day)) ordered by the amount in descending order (ORDER BY amount DESC).
-- The outer query filters the results to only include rows where ranks = 1, which represents the transactions with the maximum amount for each day.
