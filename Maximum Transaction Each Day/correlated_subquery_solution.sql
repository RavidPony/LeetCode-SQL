

SELECT transaction_id
FROM Transactions AS t1
WHERE amount = (
    SELECT MAX(amount)
    FROM Transactions AS t2
    WHERE DATE(t1.day) = DATE(t2.day)
)
ORDER BY transaction_id;

-- The WHERE clause compares the amount in t1 with the maximum amount on the same day from t2.
-- The subquery (SELECT MAX(amount) FROM Transactions AS t2 WHERE DATE(t1.day) = DATE(t2.day)) finds the maximum transaction amount for each day.
-- The outer query returns the transaction_id where the amount matches the maximum amount for that day
