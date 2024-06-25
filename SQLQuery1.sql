 --How do you calculate the average transaction amount for each sending_address?--
 SELECT sending_address, 
 ROUND(AVG(amount),2) AS Avg_transaction
 FROM dbo.metaverse_transactions
 GROUP BY sending_address

--How do you calculate the standard deviation of transaction amounts for each sending_address?--
SELECT sending_address,
STDEV(amount) AS stddev_amount
FROM dbo.metaverse_transactions
GROUP BY sending_address
--How do you combine the average and standard deviation calculations for each sending_address in a single query?
SELECT sending_address,
STDEV(amount) AS stddev_amount,
ROUND(AVG(amount),2) AS Avg_transaction
FROM dbo.metaverse_transactions
GROUP BY sending_address

--How do you identify transactions where the amount exceeds the average by more than two standard deviations?--
WITH address_stats AS (
    SELECT 
        sending_address,
        AVG(amount) AS avg_amount,
        STDEV(amount) AS stddev_amount
    FROM dbo.metaverse_transactions
    GROUP BY sending_address
)
SELECT 
    t.sending_address,
    t.amount AS transaction_amount,
    a.avg_amount,
    a.stddev_amount,
    (a.avg_amount + 2 * a.stddev_amount) AS threshold
FROM dbo.metaverse_transactions AS t
JOIN address_stats AS a
ON t.sending_address = a.sending_address
WHERE t.amount > (a.avg_amount + 2 * a.stddev_amount);
--How do you modify the query to include all transactions and flag potentially fraudulent ones?
WITH address_stats AS (
    SELECT 
        sending_address,
        AVG(amount) AS avg_amount,
        STDEV(amount) AS stddev_amount
    FROM dbo.metaverse_transactions
    GROUP BY sending_address
)
SELECT 
    t.sending_address,
    t.amount AS transaction_amount,
    a.avg_amount,
    a.stddev_amount,
    (a.avg_amount + 2 * a.stddev_amount) AS threshold,
    CASE 
        WHEN t.amount > (a.avg_amount + 2 * a.stddev_amount) THEN 'Potential Fraud'
        ELSE 'Normal'
    END AS transaction_status
FROM dbo.metaverse_transactions AS t
JOIN address_stats AS a
ON t.sending_address = a.sending_address;


--How do you group the potentially fraudulent transactions by transaction_type

WITH address_sending AS (
	SELECT sending_address,
	AVG(amount) AS Avg_amount,
	STDEV(amount) AS std_amount
	FROM dbo.metaverse_transactions
	GROUP BY sending_address
	)
	SELECT 
	m.transaction_type,
	COUNT(*) AS pontential_fraudlent
	FROM dbo.metaverse_transactions AS m
	JOIN address_sending AS a
	ON m.sending_address = a.sending_address 
	WHERE m.amount > (a.Avg_amount +2 * a.std_amount)
	GROUP BY transaction_type
--How do you count the number of potentially fraudulent transactions for each sending_address?
WITH address_stats AS (
    SELECT 
        sending_address,
        AVG(amount) AS avg_amount,
        STDEV(amount) AS stddev_amount
    FROM dbo.metaverse_transactions
    GROUP BY sending_address
)
SELECT 
    t.sending_address,
    COUNT(*) AS potential_fraud_count
FROM dbo.metaverse_transactions AS t
JOIN address_stats AS a
ON t.sending_address = a.sending_address
WHERE t.amount > (a.avg_amount + 2 * a.stddev_amount)
GROUP BY t.sending_address;


--How do you calculate the percentage of potentially fraudulent transactions for each sending_address?
WITH address_stats AS (
    SELECT 
        sending_address,
        AVG(amount) AS avg_amount,
        STDEV(amount) AS stddev_amount
    FROM dbo.metaverse_transactions
    GROUP BY sending_address
), fraud_counts AS (
    SELECT 
        t.sending_address,
        COUNT(*) AS potential_fraud_count
    FROM dbo.metaverse_transactions AS t
    JOIN address_stats AS a
    ON t.sending_address = a.sending_address
    WHERE t.amount > (a.avg_amount + 2 * a.stddev_amount)
    GROUP BY t.sending_address
), total_counts AS (
    SELECT 
        sending_address,
        COUNT(*) AS total_count
    FROM dbo.metaverse_transactions
    GROUP BY sending_address
)
SELECT 
    f.sending_address,
    f.potential_fraud_count,
    t.total_count,
	 ROUND(CAST(f.potential_fraud_count AS DECIMAL) / t.total_count * 100, 2) AS fraud_percentage
FROM fraud_counts AS f
JOIN total_counts AS t
ON f.sending_address = t.sending_address;


--How do you identify patterns in potentially fraudulent transactions over time?

WITH address_stats AS (
    SELECT 
        sending_address,
        AVG(amount) AS avg_amount,
        STDEV(amount) AS stddev_amount
    FROM dbo.metaverse_transactions
    GROUP BY sending_address
)
SELECT 
    DATENAME(MONTH, t.timestamp) AS month_name,
    COUNT(*) AS potential_fraud_count
FROM dbo.metaverse_transactions AS t
JOIN address_stats AS a
ON t.sending_address = a.sending_address
WHERE t.amount > (a.avg_amount + 2 * a.stddev_amount)
GROUP BY DATENAME(MONTH, t.timestamp)
ORDER BY  potential_fraud_count DESC;


--How do you calculate the total amount of potentially fraudulent transactions for each sending_address?

 WITH address_stats AS (
    SELECT 
        sending_address,
        AVG(amount) AS avg_amount,
        STDEV(amount) AS stddev_amount
    FROM dbo.metaverse_transactions
    GROUP BY sending_address
)
SELECT 
    t.sending_address,
    ROUND(SUM(t.amount),2) AS total_fraud_amount
FROM dbo.metaverse_transactions AS t
JOIN address_stats AS a
ON t.sending_address = a.sending_address
WHERE t.amount > (a.avg_amount + 2 * a.stddev_amount)
GROUP BY t.sending_address
ORDER BY total_fraud_amount DESC;

