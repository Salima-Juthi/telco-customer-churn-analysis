USE customer_churn;

-- Gender wise
-- =========================================

SELECT 
	gender,
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
	GROUP BY gender
    
-- SeniorCitizen wise
-- =========================================
	
SELECT 
	SeniorCitizen,
    
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
GROUP BY SeniorCitizen

-- Partner wise
-- =========================================

SELECT 
	Partner,
    
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
GROUP BY Partner

-- Dependents wise
-- =========================================

SELECT 
	Dependents,
    
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
GROUP BY Dependents;













