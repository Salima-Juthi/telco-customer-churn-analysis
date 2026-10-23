USE customer_churn;

-- Churn rate query by each PaymentMethod
-- ====================================================

SELECT 
	PaymentMethod,
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
GROUP BY PaymentMethod;
    
-- Churn rate query by each Paperless Billing
-- ====================================================

SELECT 
	PaperlessBilling,
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
GROUP BY PaperlessBilling;  
    
    -- Churn by Monthly Charges
-- ====================================================

SELECT 
	CASE
		WHEN MonthlyCharges BETWEEN 18 AND 39 THEN '$18-39'
		WHEN MonthlyCharges BETWEEN 40 AND 59 THEN '$40-59'
		WHEN MonthlyCharges BETWEEN 60 AND 79 THEN '$60-79'
		WHEN MonthlyCharges BETWEEN 80 AND 99 THEN '$80-99'
		ELSE '$100+'
	END AS charge_band,
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
GROUP BY charge_band
ORDER BY charge_band; 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    