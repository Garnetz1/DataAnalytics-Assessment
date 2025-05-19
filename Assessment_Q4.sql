SELECT 
    s.owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), CURDATE()) AS tenure_months,
    sum(s.confirmed_amount) as total_transactions,
    #below calculates the CLV by multiplying confirmed_amount for each client by 0.1% by tenure
    (SUM(s.confirmed_amount) * 0.001) / 
        NULLIF(TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), CURDATE()), 0) 
        * 12 AS estimated_clv

FROM 
    savings_savingsaccount s
JOIN 
    users_customuser u ON s.owner_id = u.id
JOIN 
    plans_plan p ON s.id = p.id
WHERE 
#this takes care of where confirmed_amount is null or 0, ensuring division for CLV occurs on valid amounts
    s.confirmed_amount IS NOT NULL AND s.confirmed_amount <> 0
GROUP BY 
    s.owner_id, u.first_name, u.last_name
ORDER BY 
	estimated_clv

