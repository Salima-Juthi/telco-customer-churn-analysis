USE customer_churn;

-- Churn by InternetService
-- ===============================================

SELECT 
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
	GROUP BY InternetService;

-- Churn by OnlineSecurity
-- ===============================================

SELECT 
	OnlineSecurity,
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
	GROUP BY OnlineSecurity;

-- Churn by TechSupport
-- ===============================================

SELECT 
	TechSupport,
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
	GROUP BY TechSupport;

-- Churn by OnlineBackup
-- ===============================================

SELECT 
	OnlineBackup,
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
	GROUP BY OnlineBackup;

-- Churn by number of support & security services
-- =======================================================

With CustomerWithService AS (
	SELECT
		Churn,
		CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END
        +
        CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END
        +
        CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END
        AS service_count
	FROM orders
)
SELECT 
	service_count,
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
FROM CustomerWithService
GROUP BY service_count
ORDER BY service_count;

















