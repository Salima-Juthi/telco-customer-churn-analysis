# Telco Customer Churn Analysis — SQL Notes

> **Purpose:** Document data validation, SQL analysis, observed churn patterns, and potential retention opportunities. Figures are descriptive and should not be interpreted as causal effects.

## 01. Data Validation

### Objective

Validate data completeness, uniqueness, data types, numeric ranges, and categorical values before analysis.

### Checks Performed

1. Total row count

2. Distinct customer records

3. Duplicate `customerID` values

4. Missing / blank values

5. Data type validation

6. Numeric range validation

7. Categorical value validation

### Key Results

- Total records: 7,043

- Duplicate customer IDs: 0

- Missing / blank values: 0

- Numeric fields: Valid

- Categorical fields: Valid

### Conclusion

The 7,043-record Power BI source passed the initial validation checks and is ready for dashboard analysis. The MySQL import used for SQL analysis contains 7,032 rows; treat the SQL results as a separate extract until the 11-row difference is reconciled.

## 02. Executive Churn KPIs

**Business Objective:**
Establish the overall customer and churn baseline.

**Business Questions:**
1. How many customers are in the dataset?

2. How many customers churned?

3. How many customers remain active?

4. What is the overall churn rate?

5. What is the average customer tenure?

6. What is the average monthly charge?

7. What are the average monthly and total charges?

**Results:**

| KPI | Value |
|---|---:|
| Total customers (Power BI source) | 7,043 |
| Churned customers | 1,869 |
| Active customers | 5,174 |
| Overall churn rate | 26.54% |
| Average tenure | 32.37 months |
| Average monthly charge | $64.76 |
| Average total charges | 2,283 |


### 02-B. Churned vs Active Comparison

**Business Questions:**
1. How does average tenure differ between churned and active customers?

2. How do average monthly charges differ?

3. How do average total charges differ?

**SQL Query:**

```sql
SELECT
    Churn,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(tenure), 2) AS Avg_Tenure_Months,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charges,
    ROUND(AVG(TotalCharges), 2) AS Avg_Total_Charges
FROM orders
GROUP BY Churn
ORDER BY Churn;
```

### Results

| Metric | Active customers (`No`) | Churned customers (`Yes`) |
|---|---:|---:|
| Customer count | 5,163 | 1,869 |
| Average tenure | 37.65 months | 17.98 months |
| Average monthly charges | $61.31 | $74.44 |
| Average total charges | $2,555.34 | $1,531.80 |

**Key Findings:**
**Tenure:** Churned customers had an average tenure of 17.98 months, compared with 37.65 months for active customers.

**Monthly charges:** Churned customers had higher average monthly charges ($74.44) than active customers ($61.31).

**Total charges:** Churned customers had lower average total charges ($1,531.80) than active customers ($2,555.34).

**Business Interpretation:**
Churned customers had substantially shorter average tenure and higher average monthly charges than active customers. Their lower average total charges are consistent with their shorter customer tenure.

These results indicate associations between churn status, customer tenure, and billing metrics. They do not establish that higher monthly charges directly cause customers to churn.

**Data Note:**
This analysis uses 7,032 records from the MySQL `orders` table: 5,163 active customers and 1,869 churned customers. The Power BI source contains 7,043 records. Use the source-specific totals and rates consistently when comparing the SQL analysis with the dashboard.

## 03. Customer Profile & Demographics

**Business Objective:**
Understand whether customer demographic characteristics are associated with different observed churn rates.

**Business Questions:**
1. Does churn rate differ by gender?

2. Does churn differ between senior and non-senior customers?

3. Does having a partner relate to different churn?

4. Does having dependents relate to different churn?

**Analysis:**
SQL analyses compared observed churn rates by gender, senior-citizen status, partner status, and dependent status.

#### 3.1 Gender

**Key Finding:**
Churn rates were similar across genders. Female customers had an observed

churn rate of 26.96%, compared with 26.20% for male customers, a difference

of only 0.76 percentage points.

#### 3.2 Senior-citizen status

**Key Finding:**
Senior customers had a substantially higher observed churn rate than

non-senior customers. The churn rate was 41.68% among senior customers

compared with 23.65% among non-senior customers, a difference of

18.03 percentage points.

**Interpretation:**
Senior status shows a notable association with observed churn in this

dataset. This is a descriptive finding and does not establish that

senior status causes churn.

#### 3.3 Partner

**Key Finding:**
Customers without a partner had a higher observed churn rate than customers

with a partner. The churn rate was 32.98% among customers without a partner,

compared with 19.72% among customers with a partner, a difference of

13.26 percentage points.

**Interpretation:**
Partner status shows a notable association with observed churn in this

dataset. Customers without a partner experienced a higher observed churn

rate.

**Note:**
This is a descriptive association and does not establish that partner status

causes or prevents churn.

#### 3.4 Dependents

**Key Finding:**
Customers without dependents had a higher observed churn rate than

customers with dependents. The churn rate was 31.28% among customers

without dependents, compared with 15.53% among customers with

dependents, a difference of 15.75 percentage points.

**Interpretation:**
Dependents status shows a notable association with observed churn in

this dataset. Customers without dependents experienced a higher

observed churn rate.

**Note:**
This is a descriptive association and does not establish that having

dependents causes or prevents churn.

**Business question:** Which demographic/household segment shows the highest observed churn rate?

**Key finding:** Senior customers showed the highest observed churn rate among the

demographic and household segments analyzed, with a churn rate of 41.68%.

## 04. Contract & Tenure Analysis

**Business Objective:**
Understand how customer relationship length and contract structure relate to observed churn.

#### 4.1 Churn by contract type

Question: How does the observed churn rate differ across contract types?

**Key Finding:**
Observed churn varied substantially across contract types. Month-to-month

customers had the highest observed churn rate at 42.71%, followed by

one-year customers at 11.28%, while two-year customers had the lowest

observed churn rate at 2.85%.

The difference between month-to-month and two-year customers was

39.86 percentage points.

**Interpretation:**
Contract type shows a strong association with observed churn in this

dataset. Month-to-month customers experienced considerably higher

observed churn than customers on longer-term contracts.

**Note:**
This is a descriptive association and does not establish that contract

type causes or prevents churn.

#### 4.2 Churn by tenure band

Question: How does observed churn rate vary across different customer tenure ranges?

**Key Finding:**
Observed churn rate decreased consistently as customer tenure increased.

Customers with 0–12 months of tenure had the highest observed churn rate

at 47.68%, while customers with 49–72 months of tenure had the lowest

observed churn rate at 9.51%.

The difference between the shortest and longest tenure groups was

38.17 percentage points.

**Interpretation:**
Customer tenure shows a strong association with observed churn in this

dataset. Newer customers experienced considerably higher observed churn

than longer-tenured customers.

**Note:**
This is a descriptive association and does not establish that tenure

causes or prevents churn.

#### 4.3 Interaction between contract and tenure

For month-to-month customers, observed churn decreases as tenure increases 51.35% to 37.72% then 32.92%, 26.02%. This shows a clear descriptive pattern within the month-to-month segment.

For two-year customers, the observed churn rates remain very low across all tenure bands, although the later bands are slightly higher.

For one-year customers, rates are relatively low and do not show the same steadily decreasing pattern.

Month-to-month customers show substantially higher observed churn rates across all tenure bands, with the highest observed churn among customers with 0–12 months of tenure (51.35%). Within the month-to-month segment, observed churn decreases as tenure increases.

## 05. Service Analysis

**Business Objective:**
Understand how different telecom services are associated with observed customer churn and identify service segments with noticeably different churn rates.

### 05-A. Churn by Internet Service

**Business Question:**
How does observed churn vary across different Internet service types?

**Analysis:**
Customers were grouped by internet service. Total customers, churned customers, and observed churn rate were calculated for each category.

**Results:**

| Internet service | Total customers | Churned customers | Observed churn rate |
|---|---:|---:|---:|
| DSL | 2,416 | 459 | 19.00% |
| Fiber optic | 3,096 | 1,297 | 41.89% |
| No internet service | 1,520 | 113 | 7.43% |

**Finding:**
Fiber optic customers had the highest observed churn rate at 41.89%,

while customers without internet service had the lowest at 7.43%.

This indicates a notable association between internet service type and

observed churn in this dataset.

### 05-B. Churn by Online Security

**Business Question:**
How does observed churn vary between customers with and without Online Security?

**Analysis:**
Customers were grouped by Online Security status. Total customers, churned customers, and observed churn rate were compared across categories.

**Results:**

| Online Security | Total customers | Churned customers | Observed churn rate |
|---|---:|---:|---:|
| No | 3,497 | 1,461 | 41.78% |
| Yes | 2,015 | 295 | 14.64% |
| No internet service | 1,520 | 113 | 7.43% |

**Finding:**
Customers without Online Security had a substantially higher observed churn

rate (41.78%) than customers with Online Security (14.64%). Customers with

no internet service had the lowest observed churn rate at 7.43%. This

indicates a notable association between Online Security status and observed

churn in this dataset.

### 05-C. Churn by Tech Support

**Business Question:**
How does observed churn vary between customers with and without Tech Support?

**Analysis:**
Customers were grouped by Tech Support status. Total customers, churned customers, and observed churn rate were compared across categories.

**Results:**

| Tech Support | Total customers | Churned customers | Observed churn rate |
|---|---:|---:|---:|
| No | 3,472 | 1,446 | 41.65% |
| Yes | 2,040 | 310 | 15.20% |
| No internet service | 1,520 | 113 | 7.43% |

**Finding:**
Customers without Tech Support had a substantially higher observed churn

rate (41.65%) than customers with Tech Support (15.20%). Customers with

no internet service had the lowest observed churn rate at 7.43%. This

indicates a notable association between Tech Support status and observed

churn in this dataset.

### 05-D. Churn by Online Backup

**Business Question:**
How does observed churn vary between customers with and without Online Backup?

**Analysis:**
Customers were grouped by Online Backup status. Total customers, churned customers, and observed churn rate were compared across categories.

**Results:**

| Online Backup | Total customers | Churned customers | Observed churn rate |
|---|---:|---:|---:|
| Yes | 2,425 | 523 | 21.57% |
| No | 3,087 | 1,233 | 39.94% |
| No internet service | 1,520 | 113 | 7.43% |

**Finding:**
Customers without Online Backup had a higher observed churn rate (39.94%)

than customers with Online Backup (21.57%). Customers with no internet

service had the lowest observed churn rate at 7.43%. This indicates a

notable association between Online Backup status and observed churn in

this dataset.

### 05-E. Churn by Number of Support/Security Services

**Business Question:**
Do customers with more support/security services show different observed churn rates?

**Analysis:**
Created a service count for each customer based on whether they had Online Security,

Tech Support, and Online Backup. Customers were grouped by the number of these

services they had, and total customers, churned customers, and observed churn rate

were compared across service-count groups.

**Results:**

| Number of selected services | Total customers | Churned customers | Observed churn rate |
|---:|---:|---:|---:|
| 0 | 3,233 | 1,038 | 32.11% |
| 1 | 1,805 | 581 | 32.19% |
| 2 | 1,307 | 203 | 15.53% |
| 3 | 687 | 47 | 6.84% |

**Finding:**
Customers with 2 or 3 support/security services had substantially lower observed

churn rates than customers with 0 or 1 service. The observed churn rate was

32.11% for customers with no services and 6.84% for customers with all three

services. This indicates a notable association between the number of these

services and observed churn in this dataset. The analysis does not establish

that additional services cause lower churn.

**Section 05 Summary:**

Customers with Fiber optic internet service had a substantially higher

observed churn rate (41.89%) compared with customers with no internet

service (7.43%), a difference of 34.46 percentage points.

Customers without Online Security, Tech Support, and Online Backup also

showed relatively high observed churn rates of 41.78%, 41.65%, and 39.94%,

respectively, compared with customers who had these services.

Finally, customers with 2–3 of the selected support/security services had

lower observed churn rates (15.53% and 6.84%) compared with customers with

0–1 services (32.11% and 32.19%).

Overall, the analysis shows notable associations between service

characteristics and observed churn in this dataset; these relationships

should not be interpreted as causal effects.

## 06. Billing & Payment Analysis

### 06-A. Churn by Payment Method

**Business Question:**
How does observed customer churn vary across different payment methods?

**Analysis:**
Customers were grouped by payment method, and total customers, churned customers, and observed churn rate were calculated for each payment method.

**Result:**
Electronic check had the highest observed churn rate at 45.29%, while credit card (automatic) had the lowest at 15.25%. The difference between these two payment methods was 30.04 percentage points.

**Finding:**
Customers using electronic check were associated with a substantially higher observed churn rate compared with customers using other payment methods. Among the four payment methods, credit card (automatic) had the lowest observed churn rate.

### 06-B. Churn by Paperless Billing

**Business Question:**
How does observed customer churn vary between customers with paperless billing and those without it?

**Analysis:**
Customers were grouped by paperless billing status, and total customers, churned customers, and observed churn rate were calculated for each group.

**Result:**
Customers with paperless billing had an observed churn rate of 33.59%, compared with 16.38% among customers without paperless billing. The difference was 17.21 percentage points.

**Finding:**
Paperless billing was associated with a substantially higher observed churn rate in this dataset compared with non-paperless billing customers.

### 06-C. Churn by Monthly Charges

**Business Question:**
How does observed customer churn vary across different monthly charge levels?

**Analysis:**
Monthly charges were divided into five charge bands, and total customers, churned customers, and observed churn rate were calculated for each band.

**Result:**
The $18–39 band had the lowest observed churn rate at 11.43%, while the $80–99 band had the highest at 36.50%. The difference between these bands was 25.07 percentage points. The $100+ band had a lower observed churn rate of 30.21%.

**Finding:**
Higher monthly-charge bands were generally associated with higher observed churn compared with the lowest-charge band. However, the relationship was not strictly increasing, as the $100+ segment had a lower churn rate than the $80–99 segment.

**Section Summary:**

Observed churn varied noticeably across payment methods, paperless billing status, and monthly charge bands. Electronic check customers had the highest observed churn rate at 45.29%, while automatic credit card customers had the lowest at 15.25%. Customers with paperless billing had a higher observed churn rate (33.59%) compared with customers without it (16.38%). Monthly charges also showed an association with churn, with the $80–99 band having the highest observed churn rate at 36.50%, compared with 11.43% for the $18–39 band. These are observed associations within the dataset and should not be interpreted as causal effects.

## 07. Customer Value Analysis

### 07-A. Churn by Total Charges

**Business Question:**
How does observed customer churn vary across different total-charge levels?

**Analysis:**
Customers were divided into five total-charge bands, and total customers, churned customers, and observed churn rate were calculated for each band.

**Result:**
The $0–999 band had the highest observed churn rate at 36.99%, while the $7,000+ band had the lowest at 10.30%. Observed churn decreased across the total-charge bands, with a 26.69 percentage-point difference between the lowest and highest bands.

**Finding:**
Higher total-charge segments were associated with lower observed churn. This pattern is also consistent with the earlier tenure analysis, because total charges generally accumulate as customer tenure increases. Therefore, the relationship should be interpreted as an observed association rather than a causal effect.

### 07-B. Monthly Charges and Tenure vs Churn

**Business Question:**
How does observed customer churn vary across different monthly charge levels within different tenure groups?

**Analysis:**
Customers were segmented by both tenure band and monthly charge band. Total customers, churned customers, and observed churn rate were calculated for each combination.

**Result:**
Within every tenure group, higher monthly-charge bands had higher observed churn rates. For example, among customers with 0–12 months of tenure, churn increased from 32.27% in the Low-charge group to 76.47% in the High-charge group. At the same time, churn generally decreased as tenure increased within each charge band.

**Finding:**
Monthly charges and tenure showed notable associations with observed churn when analyzed together. Higher monthly charges were associated with higher observed churn within each tenure group, while longer-tenure customers generally had lower observed churn across all charge groups. The High-charge 0–12 month segment had a particularly high observed churn rate (76.47%), but its small sample size of 51 customers should be considered when interpreting the result.

**Section Summary:**

Observed churn varied noticeably across different customer value segments. Customers with lower total charges had higher observed churn, with the $0–999 segment showing 36.99% churn compared with 10.30% among customers with $7,000+ in total charges. This pattern is consistent with the earlier tenure analysis because customers with longer tenure generally accumulate higher total charges. When monthly charges and tenure were analyzed together, higher monthly-charge customers generally had higher observed churn within each tenure group, while longer-tenure customers generally had lower observed churn. These relationships represent observed associations in the dataset and should not be interpreted as causal effects.

## 08. Churn Segment Analysis

### 08-A. Churn by Contract and Internet Service Combination

**Business Question:**
How does observed customer churn vary across different combinations of contract type and internet service?

**Analysis:**
Customers were segmented by contract type and internet service. Total customers, churned customers, and observed churn rate were calculated for each combination.

**Result:**
Month-to-month customers with Fiber optic service had the highest observed churn rate at 54.61%, followed by month-to-month DSL customers at 32.22%. Two-year customers had substantially lower observed churn across all internet-service categories, with the lowest rate of 0.79% among customers with no internet service.

**Finding:**
Contract type and internet service showed notable combined associations with observed churn. Month-to-month customers had higher observed churn across all internet-service categories, while Fiber optic customers had higher observed churn within each contract type. The Month-to-month + Fiber optic segment had the highest observed churn rate at 54.61%.

### 08-B. High-Risk Customer Profile

**Business Question:**
What is the observed churn rate among customers with 0–12 months of tenure (newer customer) with a month-to-month contract and Fiber optic service?

**Analysis:**
Filtered customers with a month-to-month contract, Fiber optic internet service, and tenure between 0–12 months. Calculated total customers, churned customers, and observed churn rate.

**Result:**
Total customers: 916

Churned customers: 643

Observed churn rate: 70.20%

Overall churn rate: 26.58%

Difference: 43.62 percentage points higher

**Finding:**
Customers with 0–12 months of tenure, month-to-month contracts, and Fiber optic service had an observed churn rate of 70.20%, substantially higher than the overall churn rate of 26.58%. This segment represents a notable high-churn customer profile in the dataset. The result shows an association, not causation.

## 09. Retention Opportunities

**Note:** Retention Opportunities are business interpretations based on findings from previous analyses; no new SQL analysis is required where existing results sufficiently answer the business question.

### 09-A. Contract Structure and Retention

**Business Question:**
How does observed customer churn vary across contract types, and what retention opportunity can be identified from these differences?

**Analysis:**
Compared customers across Month-to-month, One year, and Two year contract types and calculated total customers, churned customers, and observed churn rate.

**Result:**
Month-to-month: 3,875 customers | 1,655 churned | 42.71%

One year: 1,472 customers | 166 churned | 11.28%

Two year: 1,685 customers | 48 churned | 2.85%

Month-to-month vs Two year difference: 39.86 percentage points.

**Finding:**
Month-to-month customers had substantially higher observed churn than customers with one-year or two-year contracts. This segment may represent an important retention opportunity for further investigation. The observed relationship does not establish causation.

**Retention Opportunity:**
Investigate whether suitable month-to-month customers could benefit from targeted retention offers, improved engagement, or optional longer-term plans.

### 09-B. Support and Security Services Retention

**Business Question**

How does observed customer churn vary with the number of selected support and security services used by customers, and what retention opportunity can be identified?

**Analysis:**

Customers were grouped by the number of selected services they had: Online Security, Tech Support, and Online Backup. Total customers, churned customers, and observed churn rate were calculated for each service-count group.

**Result:**

| Number of services | Total customers | Churned | Observed churn rate |
|---:|---:|---:|---:|
| 0 | 3,233 | 1,038 | 32.11% |
| 1 | 1,805 | 581 | 32.19% |
| 2 | 1,307 | 203 | 15.53% |
| 3 | 687 | 47 | 6.84% |

**Finding:**

Customers with two or three selected support/security services had substantially lower observed churn rates than customers with zero or one service. The observed pattern suggests that customers with limited service adoption may represent a segment worth investigating for targeted engagement or service-education opportunities. The relationship does not establish that additional services cause lower churn.

**Retention Opportunity:**

Potential opportunity: Investigate whether customers with limited adoption of support and security services would benefit from better service education, personalized recommendations, or relevant service bundles.

### 09-C. Payment Method and Retention

**Business Question:**

How does observed customer churn vary across payment methods, and what retention opportunity can be identified from these differences?

**Analysis:**

We grouped customers by payment method and calculated total customers, churned customers, and observed churn rate.

**Result:**

| Payment method | Total customers | Churned | Observed churn rate |
|---|---:|---:|---:|
| Electronic check | 2,365 | 1,071 | 45.29% |
| Mailed check | 1,604 | 308 | 19.20% |
| Bank transfer (automatic) | 1,542 | 258 | 16.73% |
| Credit card (automatic) | 1,521 | 232 | 15.25% |

**Finding:**

Customers using electronic check had a substantially higher observed churn rate (45.29%) than customers using automatic payment methods, particularly credit card (automatic) at 15.25%. This indicates a notable association between payment method and observed churn, although the relationship does not establish causation.

**Retention Opportunity:**

Potential opportunity: Investigate whether electronic-check customers experience different billing, payment, onboarding, or customer-service experiences and whether alternative payment options could improve customer retention.

**Section Summary:**

Several customer characteristics showed notable associations with observed churn that may represent retention opportunities for further investigation. Month-to-month customers had substantially higher observed churn than customers on longer-term contracts. Customers with two or three selected support/security services had considerably lower observed churn than customers with zero or one service. Electronic-check customers also showed substantially higher observed churn than customers using automatic payment methods. These findings identify areas for potential retention investigation but do not establish causal relationships.

## 10. Business Insights

### 10-A. Overall Churn and Customer Profile

**Insight:**

The dataset contains 7,032 customers, with 1,869 churned customers, resulting in an overall observed churn rate of 26.58%. Churned customers had substantially shorter average tenure (17.98 months) than active customers (37.65 months) and higher average monthly charges ($74.44 vs $61.31).

**Business meaning:**

Customer retention appears particularly relevant among newer customers and customers with higher monthly charges.

### 10-B. Contract and Tenure Are Strongly Associated with Churn

**Insight:**

Observed churn varied substantially across contract and tenure segments. Month-to-month customers had a 42.71% observed churn rate compared with 11.28% for one-year and 2.85% for two-year contracts. Customers with 0–12 months of tenure had 47.68% churn compared with 9.51% among customers with 49–72 months of tenure.

**Business meaning:**

Early-tenure and month-to-month customers represent important segments for retention investigation.

### 10-C. High-Risk Combined Segment

**Insight:**

Customers with month-to-month contracts and Fiber optic service had an observed churn rate of 54.61%. Among customers with the same contract and service combination who had only 0–12 months of tenure, observed churn reached 70.20%, compared with the overall rate of 26.58%.

**Business meaning:**

The combination of contract type, service type, and short tenure identifies a particularly high-churn segment that could be prioritized for further investigation.

### 10-D. Service Adoption and Churn

**Insight:**

Customers with two or three selected support/security services showed substantially lower observed churn (15.53% and 6.84%) than customers with zero or one service (32.11% and 32.19%).

**Business meaning:**

Service adoption is associated with different churn patterns and could be investigated as a potential customer-engagement opportunity.

### 10-E. Payment Method Association

**Insight:**

Electronic-check customers had an observed churn rate of 45.29%, substantially higher than customers using automatic payment methods, including credit card automatic at 15.25%.

**Business meaning:**

The electronic-check segment may warrant further investigation into billing experience, payment friction, onboarding, or customer-service differences.

### 10-F. Customer Value and Churn

**Insight:**

Customers with total charges below $1,000 had an observed churn rate of 36.99%, compared with 10.30% among customers with total charges of $7,000 or more. The pattern is consistent with the strong relationship between accumulated charges and tenure, so total charges should not be interpreted as independently causing lower churn.

**Business meaning:**

Lower-value/shorter-tenure customers may warrant closer retention monitoring, particularly when combined with other high-churn characteristics.

**Section Summary:**

Overall, observed customer churn was strongly associated with customer tenure, contract type, service configuration, payment method, and customer value characteristics. Newer customers and month-to-month customers showed substantially higher observed churn, while the combination of month-to-month contract, Fiber optic service, and 0–12 months of tenure represented a particularly high-churn segment at 70.20%. Service adoption and payment method also showed notable differences in observed churn. These findings can help identify customer segments for further retention investigation, but the observational dataset does not establish causal relationships.
