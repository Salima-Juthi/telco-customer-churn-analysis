USE customer_churn;

-- Contract & Internet Service wise churn 
-- ===============================================

SELECT 
	Contract,
    InternetService,
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
	GROUP BY Contract,InternetService
    ORDER BY COntract;
    
-- High-Risk Customer Profile
-- ===================================================

SELECT
	Contract,
    InternetService,
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
WHERE Contract = 'Month-to-month'
AND InternetService = 'Fiber optic'
AND Tenure Between 0 and 12
GROUP BY Contract,InternetService
	
    
    
    
    
    
    