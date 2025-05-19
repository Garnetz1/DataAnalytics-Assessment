# DataAnalytics-Assessment
This is a submission for the Cowrywise Data Analytics role
1. High Value Customers with Multiple Products
   PROCESS
   For this question, the approach was to select relevant columns from the three tables, using the JOINS.
   For the name, I concatenated the first_name and last_name from users_customuser table.
   Using a CASE/WHEN statement, I counted the number of times a customer's account is flagged 1 on columns is_regular_savings & is_a_fund from plans_plan table.
   I created total_transaction by summing confirmed_amounts from savings_savingsaccount
   Group by all categorical values in the select statement. Used a HAVING clause to ensure that only customers who have both account flag types are included.
   CHALLENGES
   Identifying which columns would work best as identifiers for each customer. I resolved this by comparing outputs where a JOIN has been created with each id column.
   
2. Transaction Frequency Analysis
   PROCESS
   The statement starts out naming the final columns expected then I created a subquery that categorizes clients by monthly transaction frequency.
   transaction frequency is calculated in the next subquery that formats transaction_date into Year-Month format.
   It counts all transactions where transaction_reference is not empty. I ordered by frequency_category.

3. Account Inactivity Alert
   PROCESS
   I created the select statement that picks plan_id and owner_id from savings_savingsaccount table and then description from plan_plan table.
   Then using MAX, I calculated the day on which the last transaction was carried out.
   Then calculated inactivity_days by subtracting last_transaction_date from current date.
   Using the HAVING clause to ensure that the dates being considered are within 365 days of last transaction.
   CHALLENGES
   Identifying the column to be used for 'type'. This was resolved by using the description column in plan_plan table

4. Customer Lifetime Value (CLV) Estimation
   PROCESS
   For this question, the approach was to select relevant columns from the three tables, using the JOINS.
   For the name, I concatenated the first_name and last_name from users_customuser table.
   I calculated tenure_months by subtracting date_joined from users_customuser from current date.
   The CLV by multiplying confirmed_amount for each client by 0.1% then dividing by tenure_month.
   In the WHERE clause, I ensured confirmed_amount is not null or 0 to ensure proper aggregations, then ordered by estimated_clv.
   
