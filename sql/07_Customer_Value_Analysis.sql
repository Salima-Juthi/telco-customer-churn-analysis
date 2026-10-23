USE customer_churn;

-- Churn by Total charges
-- ========================================================

SELECT 
	CASE
    WHEN TotalCharges BETWEEN 0 AND 999 THEN '$0-999'
    WHEN TotalCharges BETWEEN 1000 AND 2999 THEN '$1000-2999'
    WHEN TotalCharges BETWEEN 3000 AND 4999 THEN '$3000-4999'
    WHEN TotalCharges BETWEEN 5000 AND 6999 THEN '$5000-6999'
    ELSE '$7000+'
END AS total_charge_band,
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
GROUP BY total_charge_band
ORDER BY total_charge_band; 

-- Customer Value vs Churn rate check
-- ==================================================

WITH CustomerValueMetrics AS (
	SELECT 
		Churn,
		CASE
			WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
			WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
			WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
			WHEN tenure BETWEEN 49 AND 72 THEN '49-72 months'
		END AS tenure_band,
        
        CASE
			WHEN MonthlyCharges <60 THEN 'Low'
			WHEN MonthlyCharges <100 THEN 'Medium'
			ELSE 'High'
		END AS charge_band
	FROM orders
)
SELECT
	tenure_band,
    charge_band,
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
FROM CustomerValueMetrics
GROUP BY tenure_band,charge_band
ORDER BY tenure_band;










