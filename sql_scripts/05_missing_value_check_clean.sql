-- missing value in demographic info table
SELECT 
    COUNT(*) - COUNT(customer_id) AS missing_id,
    COUNT(*) - COUNT(gender) AS missing_gender,
    COUNT(*) - COUNT(senior_citizen) AS missing_senior,
    COUNT(*) - COUNT(partner) AS missing_partner,
    COUNT(*) - COUNT(dependents) AS missing_dependents
FROM telco_customer.dim_customers;


-- missing value in services details table
SELECT 
    COUNT(*) - COUNT(customer_id) AS missing_id,
    COUNT(*) - COUNT(internet_service) AS missing_internet,
    COUNT(*) - COUNT(phone_service) AS missing_phone,
    COUNT(*) - COUNT(streaming_tv) AS missing_tv
FROM telco_customer.dim_services;

-- missing value in subscription table
SELECT 
    COUNT(*) - COUNT(customer_id) AS missing_id,
    COUNT(*) - COUNT(tenure) AS missing_tenure,
    COUNT(*) - COUNT(monthly_charges) AS missing_monthly,
    COUNT(*) - COUNT(total_charges) AS missing_total,
    COUNT(*) - COUNT(churn) AS missing_churn
FROM telco_customer.fact_subscriptions;


-- cleaned staging table for analysis

CREATE TABLE telco_customer.stg_churn_cleaned AS
SELECT *
FROM (
    -- Join the 3 tables back together into a clean flat structure
    SELECT 
        c.*, 
        s.phone_service, s.multiple_lines, s.internet_service, s.online_security,
        s.online_backup, s.device_protection, s.tech_support, s.streaming_tv, s.streaming_movies,
        f.tenure, f.contract, f.paperless_billing, f.payment_method, f.monthly_charges, f.total_charges, f.churn
    FROM telco_customer.dim_customers c
    JOIN telco_customer.dim_services s ON c.customer_id = s.customer_id
    JOIN telco_customer.fact_subscriptions f ON c.customer_id = f.customer_id
) AS joined_data
-- Apply your business rule: Drop rows where charges are missing
-- (Since we know it's only 11 rows / < 1%, we proceed)
WHERE total_charges IS NOT NULL 
  AND monthly_charges IS NOT NULL;

COMMENT ON TABLE telco_customer.stg_churn_cleaned IS 'Cleaned analytic layer. Excludes customers with 0 tenure/null charges.';