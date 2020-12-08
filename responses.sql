-- How many transactions were entitled to a subsidy ?

SELECT 
   COUNT(DISTINCT transaction_id)
FROM 
   subventions;

-- How many transactions were entitled to a subsidy per company ?

SELECT 
   transactions.company, 
   COUNT(subventions.subvention_id)
FROM 
   transactions
LEFT JOIN 
   subventions ON subventions.transaction_id=transactions.transaction_id
GROUP BY 
   transactions.company
ORDER BY 
   COUNT(subvention_id) DESC;

-- What is the total turnover per client for each offer type ?
   
WITH discount_by_transaction AS (
SELECT 
     transaction_id, 
     SUM(amount) as total_discount
FROM 
     subventions
GROUP BY 
     transaction_id)
      
SELECT 
     transactions.user_id, 
     transactions.offer_type, 
     SUM(amount + total_discount) as total_turnover
FROM 
     transactions
LEFT JOIN 
     discount_by_transaction ON discount_by_transaction.transaction_id=transactions.transaction_id
GROUP BY 
      transactions.user_id, 
      transactions.offer_type;

-- What are the first two products that each client bought ?

WITH top_products_by_client AS ( 
SELECT
     user_id, 
     product_name,
     ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY COUNT(transaction_id) desc) AS rank,
     COUNT(transaction_id)
FROM
     transactions
GROUP BY
    user_id,
    product_name
ORDER BY
     user_id, 
     rank)
SELECT 
   *
FROM
   top_products_by_client
WHERE
    rank<=2;
