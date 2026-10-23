USE customer_churn;

SELECT
    Churn,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(tenure), 2) AS Avg_Tenure_Months,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charges,
    ROUND(AVG(TotalCharges), 2) AS Avg_Total_Charges
FROM orders
GROUP BY Churn
ORDER BY Churn;