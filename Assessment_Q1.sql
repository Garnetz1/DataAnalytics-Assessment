SELECT 
    s.owner_id,
    #s.id, these are transactionIDs 
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) AS savings_count, #counts only where entry is 1
    COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) AS investment_count, #counts only where entry is 1
    SUM(s.confirmed_amount) AS total_deposits
FROM 
    savings_savingsaccount s
JOIN 
    users_customuser u ON s.owner_id = u.id
JOIN 
    plans_plan p ON s.id = p.id
WHERE 
    s.amount IS NOT NULL AND s.amount <> 0
GROUP BY 
    s.owner_id, u.first_name, u.last_name
HAVING 
    COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) > 0 AND
    COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) > 0
ORDER BY 
    total_deposits DESC;
