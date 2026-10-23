USE customer_churn;

-- Contract wise churn rate
-- ===========================================================

SELECT 
	Contract,
    COUNT(*) AS total_customers,
    
    SUM(
		CASE WHEN churn = 'Yes' THEN 1
        ELSE 0
	END
    ) AS churned_customers,
    
    ROUND(
		100.0 * SUM(
					CASE WHEN churn = 'Yes' THEN 1
					ELSE 0
				END
                ) / count(*),
                2
			) AS churned_rate
	FROM orders
	GROUP BY Contract;
    
-- Tenure wise churn rate
-- ===========================================================

SELECT 
	CASE
    WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
    WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
    WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
    WHEN tenure BETWEEN 49 AND 72 THEN '49-72 months'
END AS tenure_band,
	
    COUNT(*) AS total_customers,
    
    SUM(
		CASE WHEN churn = 'Yes' THEN 1
        ELSE 0
	END
    ) AS churned_customers,
    
    ROUND(
		100.0 * SUM(
					CASE WHEN churn = 'Yes' THEN 1
					ELSE 0
				END
                ) / count(*),
                2
			) AS churned_rate
	FROM orders
	GROUP BY tenure_band
    ORDER BY tenure_band
    
-- Churn rate influence between contract & tenure check
-- ========================================================

WITH CustomerTenure AS (
		SELECT
			Contract,
            Churn,
			CASE
				WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
				WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
				WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
				WHEN tenure BETWEEN 49 AND 72 THEN '49-72 months'
			END AS tenure_band
		FROM Orders
)
SELECT
	Contract,
    tenure_band,
    COUNT(*) AS total_customers,
    
    SUM(
		CASE WHEN churn = 'Yes' THEN 1
        ELSE 0
	END
    ) AS churned_customers,
    
    ROUND(
		100.0 * SUM(
					CASE WHEN churn = 'Yes' THEN 1
					ELSE 0
				END
                ) / count(*),
                2
			) AS churn_rate
FROM CustomerTenure
GROUP BY Contract, tenure_band
ORDER BY tenure_band
			
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    