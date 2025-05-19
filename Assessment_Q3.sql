SELECT 
    s.plan_id AS plan_id,
    s.owner_id AS owner_id,
    p.description as type,
    MAX(s.transaction_date) AS last_transaction_date,
    #Calculating the number of days of inactivity by subtracting last transaction date by current date
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM 
    savings_savingsaccount s
JOIN 
    users_customuser u ON s.owner_id = u.id
JOIN 
    plans_plan p ON s.id = p.id
GROUP BY 
    s.plan_id, s.owner_id, p.description
HAVING 
	#this ensures that the dates being considered are within 365 days of last transaction
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) > 365;
