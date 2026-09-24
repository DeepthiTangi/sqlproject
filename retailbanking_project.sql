use retailbanking;
show tables;
select * from accounts;
select * from branches;
select * from cards;
select * from customers_1;
select * from loan_payments;
select* from loans;
select * from transactions;

select count(*) as total_rows from loans;

-- 1.What is the total number of customers?
select count(*)as total_customers from customers_1;

-- 2.What is the total number of accounts?
select count(*)as total_accounts from accounts;

-- 6 What are the different account types available?
select distinct account_type from accounts;

-- 4 How many customers are currently active?
select count(*)as customers_currently_active from customers_1
where is_active='yes';

-- 5 What are the different transaction types available?
select distinct transaction_type from transactions;

-- 6v What is the total amount of completed transactions?
select round(sum(amount),2)as total_amount from transactions
where status='completed';

-- 7 What are the different loan types available?
select distinct loan_type from loans;

-- 8 What is the total number of loans?
select count(*)as total_loans from loans;

-- 9 What are the different card types available?
select distinct card_type from cards;

-- 10 What is the total outstanding loan balance?
select sum(outstanding_balance)as outstanding_balance from loans;


select * from accounts;
select * from branches;
select * from cards;
select * from customers_1;
select * from loan_payments;
select* from loans;
select * from transactions;



------ 4.1 – Understand Customer Profile and Segmentation

-- 2 Which customer segment has the highest number of customers
select segment,count(*)as highest_no_of_customers from customers_1 
 group by segment order by highest_no_of_customers  desc limit 1;
 
-- 2 What is the average income of customers in each segment?
select segment ,round(avg(annual_income),2) as avg_income from customers_1
group by segment;

-- 3 Which customer segment has the highest average credit score?
select segment ,avg(credit_score)as avg_highest_credit_score from customers_1
group by segment order by avg_highest_credit_score desc limit 1;

-- 4 How are customers distributed across different cities and states?
select state,city,count(*)as total_customers from customers_1
 group by city,state order by state ASC,  total_customers desc;

-- 5 Which customer segment has the highest average annual income?
select segment,avg(annual_income)as avg_income from customers_1
 group by segment order by avg_income desc limit 1 ;

-- 6 What is the average credit score by city and state?
select city,state ,avg(credit_score)as avg_credit_score from customers_1
group by city,state order by avg_credit_score desc;

-- 7 What percentage of customers have completed KYC verification?
select (sum(kyc_status='verified')*100.0/count(*))as kyc_percentage from customers_1; 

-- 8 Which customer segments have the highest proportion of KYC-completed customers?
select segment ,round(sum(kyc_status='verified')*100.0/count(*),2)as kyc_completed from customers_1
group by segment order by kyc_completed desc limit 1; 

-- 9 How many active and inactive customers exist in each segment?
select segment,is_active,count(*)as customers_status from customers_1
group by segment,is_active order by segment,is_active;

-- 7 Which age group contains the most customers?
select
    case
        when timestampdiff(year, date_of_birth, curdate()) between 18 and 25 then '18-25'
        when timestampdiff(year, date_of_birth, curdate()) between 26 and 35 then '26-35'
        when timestampdiff(year, date_of_birth, curdate()) between 36 and 45 then '36-45'
        when timestampdiff(year, date_of_birth, curdate()) between 46 and 55 then '46-55'
        else '56+'
    end as age_group,
    count(*) as customer_count
from customers_1
group by age_group
order by customer_count desc
limit 1;

-- 11 What is the average customer tenure for each segment?
select segment,round(avg(timestampdiff(year, customer_since, CURDATE())), 2) AS avg_tenure_years
FROM customers_1
GROUP BY segment
ORDER BY avg_tenure_years DESC;

-- 12 Which branch manages the highest number of accounts?
select branch_name ,count(*)as highest_number_accounts from branches
group by branch_name order by highest_number_accounts desc limit 1;

-- 13 How many accounts are maintained in each branch?
select branch_name,count(*)as account_branch from branches
group by branch_name order by account_branch desc ;


-- 14 Which branch has the lowest number of employees?
select branch_name,employee_count from branches 
order by employee_count limit 1;

-- 15 What is the average employee count by state?
select state,avg(employee_count)as avg_employee_count from branches
group by state order by avg_employee_count desc;

select * from accounts;
select * from branches;
select * from cards;
select * from customers_1;
select * from loan_payments;
select* from loans;
select * from transactions;


------  4.2 Understand Account Usage and Branch Activity


-- 1 Which account type has the highest number of accounts?
select account_type ,count(*)as highest_account  from accounts
group by account_type order by highest_account desc limit 1;

-- 2 What is the total and average balance for each account type?
select account_type, sum(current_balance)as total_balance ,avg(current_balance)as avg_balance from accounts
group by account_type ;

-- 5 Which account type maintains the highest average account balance?
select account_type,avg(current_balance)as highest_account_balance from accounts
group by account_type order by  highest_account_balance desc limit 1;

-- 4 How many active and closed accounts exist for each account type?
select account_type,status,count(*)as active_closed from accounts
group by account_type,status order by account_type,status ;

-- 5 Which branches manage the largest number of accounts?
select branch_id,count(account_id)as branches_accounts from accounts
group by branch_id order by branches_accounts desc limit 1;

-- 6 What is the total account balance managed by each branch?
select branch_id,sum(current_balance)as total_account_balance from accounts
group by branch_id order by total_account_balance desc;

-- 7 Which branch has the highest average account balance?
select branch_id,avg(current_balance)as avg_account_balance from accounts
group by branch_id order by avg_account_balance  desc limit 1;

-- 8 How do interest rates vary across different account types?
select account_type,avg(interest_rate)as avg_interest_rate from accounts
group by account_type order by avg_interest_rate desc;

-- 9 Which customers hold multiple accounts?
select customer_id,count(account_id)as customers_accounts from accounts
group by customer_id having customers_accounts>1 order by customers_accounts desc ;

-- 10 What is the average number of accounts per customer?
select round(count(account_id) * 1.0 / count(distinct customer_id), 2) as avg_no_of_accounts
from accounts;



select * from accounts;
select * from branches;
select * from cards;
select * from customers_1;
select * from loan_payments;
select* from loans;
select * from transactions;


------  4.3 Analyze Transaction Patterns


-- 1  Which transaction type occurs most frequently?
select transaction_type, count(*)as total_transaction from transactions
group by transaction_type order by total_transaction desc limit 1;

-- 2 What is the total transaction amount for each transaction type?
select transaction_type,sum(amount)as transaction_amount from transactions
group by transaction_type order by transaction_amount desc;


-- 3 Which transaction channel (ATM, Online, Mobile Banking, Branch, etc.) is used the most?
select channel ,count(*)as transaction_channel from transactions
group by channel order by transaction_channel desc limit 1;

-- 4 What is the total transaction value processed through each channel?
select channel,sum(amount)as total_transaction from transactions
group by channel order by total_transaction desc;

-- 5 Which accounts perform the highest number of transactions?
select account_id,count(*)as total_transactions from transactions
group by account_id order by total_transactions desc limit 1;

-- 6 What percentage of transactions are completed, pending, and failed?
SELECT status,COUNT(*) AS total_transactions,ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions), 2) AS percentage
FROM transactions
GROUP BY status
ORDER BY percentage DESC;

-- 7 What is the average transaction amount by transaction type?
select transaction_type ,avg(amount)as transaction_amount from transactions
group by transaction_type order by transaction_amount;

-- 8 What are the top 10 highest-value transactions?
select transaction_id,account_id,transaction_type,amount from transactions
order by amount desc limit 10;

-- 9 Which transaction descriptions appear most frequently?
select description ,count(*)as transaction_descriptions from transactions
group by description order by transaction_descriptions desc limit 1;

-- 10 How does transaction activity vary by month?
select monthname(transaction_date) as month_name,count(*) as total_transactions
from transactions
group by monthname(transaction_date), month(transaction_date)
order by month(transaction_date);



------ 4.4 Evaluate Loan Performance and Repayment Behaviour



-- 1 Which loan type has the highest number of loans?
select loan_type ,count(*)as highest_no_of_loans from loans
group by loan_type order by highest_no_of_loans desc limit 1;
 
-- 2 What is the total and average loan amount by loan type?
select loan_type,sum(principal_amount)as total_amount ,avg(principal_amount)as avg_amount from loans
group by loan_type ;

-- 3 Which loan purposes are most common among customers
select purpose ,count(*)as total_customers from loans
group by purpose order by total_customers desc limit 1;

-- 4 What is the total outstanding balance for each loan type?
select loan_type,sum(outstanding_balance)as total_outstanding_bal from loans
group by loan_type order by total_outstanding_bal desc;

-- 5 How are loans distributed across different loan statuses?
select loan_status,count(*)as total_loans from loans 
group by  loan_status order by total_loans desc;

-- 6 Which customers have delayed loan payments?
select customer_id ,loan_id,loan_status
from loans
where loan_status ='in arrears';

-- 7 What is the total principal amount disbursed for each loan type?
select loan_type,sum(principal_amount)as total_principal from loans
group by loan_type order by total_principal ;

-- 8 How many loans mature in each year?
SELECT YEAR(maturity_date) AS maturity_year,COUNT(*) AS total_loans
FROM loans
GROUP BY YEAR(maturity_date)
ORDER BY maturity_year;

-- 9 Which loan type generates the highest total EMI amount?
select loan_type,sum(emi_amount)as highest_emi_amount from loans
group by loan_type order by highest_emi_amount desc limit 1;

-- 10 Which branch has issued the highest number of loans?
select branch_id,count(*)as total_no_of_amount from loans
group by branch_id order by total_no_of_amount desc limit 1; 


------ 4.5 Understand Card Usage and Product Engagement



-- 1 Which card type has the highest number of cards issued?
select card_type,count(*)as cards_issued from cards
group by card_type order by cards_issued desc limit 1;

-- 2 What is the average credit limit by card type?
select card_type,round(avg(credit_limit),2)as avg_credit_limit from cards
group by card_type order by avg_credit_limit desc;

-- 3 Which card type has the highest average outstanding balance?
select card_type,round(avg(outstanding_balance),2)as highest_avg_balance from cards
group by card_type order by highest_avg_balance desc limit 1;

-- 4 How many cards are active versus inactive?
select  card_type,is_active,count(*)as total_count from cards
group by card_type,is_active order by card_type,is_active ;

-- 5 Which card network (Visa, Mastercard, etc.) is used the most?
select card_type,count(*)as most_used_card from cards
group by card_type order by most_used_card desc limit 1;
 
-- 6 Which customers have accumulated the highest reward points?
SELECT a.customer_id,SUM(c.reward_points) AS total_reward_points FROM cards c
JOIN accounts a
ON c.account_id = a.account_id
GROUP BY a.customer_id
ORDER BY total_reward_points DESC
LIMIT 1;

-- 7 Which account types are most commonly linked to cards?
SELECT a.account_type,
       COUNT(c.card_id) AS total_cards
FROM cards c
JOIN accounts a
ON c.account_id = a.account_id
GROUP BY a.account_type
ORDER BY total_cards DESC
LIMIT 1;
-- 8 How many customers use multiple card products?
SELECT COUNT(*) AS customers_with_multiple_card_products
FROM (
    SELECT a.customer_id
    FROM cards c
    JOIN accounts a
      ON c.account_id = a.account_id
    GROUP BY a.customer_id
    HAVING COUNT(DISTINCT c.card_type) > 1
) t;
-- 9 Which customers use all three banking products (accounts, cards, and loans)?
SELECT DISTINCT a.customer_id
FROM accounts a
JOIN cards c
    ON a.account_id = c.account_id
JOIN loans l
    ON a.customer_id = l.customer_id;
    
-- 8 Is there a relationship between card usage, account balances, and loan ownership?
SELECT
    COUNT(DISTINCT c.account_id) AS customers_with_cards,
    COUNT(DISTINCT l.customer_id) AS customers_with_loans,
    ROUND(AVG(a.current_balance),2) AS avg_account_balance
FROM accounts a
LEFT JOIN cards c
    ON a.account_id = c.account_id
LEFT JOIN loans l
    ON a.customer_id = l.customer_id;
