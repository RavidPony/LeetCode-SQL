SELECT transaction_id
FROM Transactions t1
JOIN (
    SELECT day, MAX(amount) AS max_amount
    FROM Transactions
    GROUP BY day
) t2
ON t1.day = t2.day AND t1.amount = t2.max_amount
ORDER BY transaction_id;

-- The subquery (t2) calculates the maximum amount (MAX(amount)) for each day (GROUP BY day).
-- This subquery is then joined with the original Transactions table (t1) on the day and the amount to get the transactions with the maximum amount for each day.
