-- How many transactions were entitled to a subsidy ?

SELECT 
   COUNT(DISTINCT transaction_id)
FROM 
   subventions

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
   COUNT(subvention_id) DESC

-- What is the total turnover per client for each offer type ?
 

SELECT 
   company, 
   offer_type,
   SUM(amount::int) as total_turnover
FROM 
   transactions
GROUP BY 
   company, 
   offer_type
ORDER BY 
   company, 
   offer_type


-- What are the first two products that each client bought ?

WITH top_products_by_client AS ( 
SELECT
     company, 
     product_name,
     ROW_NUMBER() OVER (PARTITION BY company ORDER BY sum(transaction_id) desc) AS rank,
     COUNT(transaction_id)
FROM
     transactions
GROUP BY
    company,
    product_name
ORDER BY
     company, 
     rank)
SELECT 
   *
FROM
   top_products_by_client
WHERE
    rank<=2
