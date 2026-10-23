CREATE DATABASE customer_churn;
USE customer_churn;

SELECT *
FROM orders
limit 10

SELECT
COUNT(*)
FROM orders

SELECT
COUNT(DISTINCT customerID)
FROM orders

-- Duplicate value checking
-- ===================================

SELECT
    customerID,
    COUNT(*) AS customer_count
FROM orders
GROUP BY customerID
HAVING COUNT(*) > 1

-- Missing value checking--
-- ===================================

SELECT
    COUNT(*) AS total_rows,

    SUM(customerID IS NULL OR customerID = '') AS customerID_missing,
    SUM(gender IS NULL OR gender = '') AS gender_missing,
    SUM(SeniorCitizen IS NULL) AS SeniorCitizen_missing,
    SUM(Partner IS NULL OR Partner = '') AS Partner_missing,
    SUM(Dependents IS NULL OR Dependents = '') AS Dependents_missing,
    SUM(tenure IS NULL) AS tenure_missing,
    SUM(PhoneService IS NULL OR PhoneService = '') AS PhoneService_missing,
    SUM(MultipleLines IS NULL OR MultipleLines = '') AS MultipleLines_missing,
    SUM(InternetService IS NULL OR InternetService = '') AS InternetService_missing,
    SUM(OnlineSecurity IS NULL OR OnlineSecurity = '') AS OnlineSecurity_missing,
    SUM(OnlineBackup IS NULL OR OnlineBackup = '') AS OnlineBackup_missing,
    SUM(DeviceProtection IS NULL OR DeviceProtection = '') AS DeviceProtection_missing,
    SUM(TechSupport IS NULL OR TechSupport = '') AS TechSupport_missing,
    SUM(StreamingTV IS NULL OR StreamingTV = '') AS StreamingTV_missing,
    SUM(StreamingMovies IS NULL OR StreamingMovies = '') AS StreamingMovies_missing,
    SUM(Contract IS NULL OR Contract = '') AS Contract_missing,
    SUM(PaperlessBilling IS NULL OR PaperlessBilling = '') AS PaperlessBilling_missing,
    SUM(PaymentMethod IS NULL OR PaymentMethod = '') AS PaymentMethod_missing,
    SUM(MonthlyCharges IS NULL) AS MonthlyCharges_missing,
    SUM(TotalCharges IS NULL OR TotalCharges = '') AS TotalCharges_missing,
    SUM(Churn IS NULL OR Churn = '') AS Churn_missing

FROM orders;

DESCRIBE orders

-- Range / Logically impossible value check
-- =========================================================

SELECT
    MIN(tenure) AS min_tenure,
    MAX(tenure) AS max_tenure,
    MIN(MonthlyCharges) AS min_monthly_charges,
    MAX(MonthlyCharges) AS max_monthly_charges,
    MIN(TotalCharges) AS min_total_charges,
    MAX(TotalCharges) AS max_total_charges
FROM orders

-- Categorical discrepency check 
-- =========================================================

SELECT 'gender' AS column_name, gender AS value
FROM orders
GROUP BY gender

UNION ALL

SELECT 'SeniorCitizen', SeniorCitizen
FROM orders
GROUP BY SeniorCitizen

UNION ALL

SELECT 'Partner', Partner
FROM orders
GROUP BY Partner

UNION ALL

SELECT 'Dependents', Dependents
FROM orders
GROUP BY Dependents

UNION ALL

SELECT 'PhoneService', PhoneService
FROM orders
GROUP BY PhoneService

UNION ALL

SELECT 'InternetService', InternetService
FROM orders
GROUP BY InternetService

UNION ALL

SELECT 'Contract', Contract
FROM orders
GROUP BY Contract

UNION ALL

SELECT 'PaperlessBilling', PaperlessBilling
FROM orders
GROUP BY PaperlessBilling

UNION ALL

SELECT 'PaymentMethod', PaymentMethod
FROM orders
GROUP BY PaymentMethod

UNION ALL

SELECT 'Churn', Churn
FROM orders
GROUP BY Churn;









