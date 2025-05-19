SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    AVG(avg_txns_per_month) AS avg_transactions_per_month
FROM (
	#this subquery takes account of individual clients and groups them based on avergae transactions per month
    SELECT 
        owner_id,
        AVG(monthly_txn_count) AS avg_txns_per_month,
        #this creates a field that differenciates clients by transaction frequency
        CASE 
            WHEN AVG(monthly_txn_count) >= 10 THEN 'High Frequency'
            WHEN AVG(monthly_txn_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM (
		#this subquery produces the result within the transaction date context
        SELECT 
            owner_id,
            DATE_FORMAT(transaction_date, '%Y-%m') AS YM, #formats the date into Year-Month
            COUNT(*) AS monthly_txn_count
        FROM 
            savings_savingsaccount
        WHERE 
            transaction_reference IS NOT NULL
        GROUP BY 
            owner_id, DATE_FORMAT(transaction_date, '%Y-%m')
    ) AS monthly_txns
    GROUP BY 
        owner_id
) AS categorized
GROUP BY 
    frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
