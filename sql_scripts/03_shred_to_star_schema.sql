-- 1. Create the Customer Dimension (Demographic Info)
CREATE TABLE telco_customer.dim_customers AS
SELECT 
    customer_id,
    gender,
    senior_citizen,
    partner,
    dependents
FROM telco_customer.churn_data;

-- 2. Create the Services Dimension (Service Details)
CREATE TABLE telco_customer.dim_services AS
SELECT 
    customer_id,
    phone_service,
    multiple_lines,
    internet_service,
    online_security,
    online_backup,
    device_protection,
    tech_support,
    streaming_tv,
    streaming_movies
FROM telco_customer.churn_data;

-- 3. Create the Subscriptions Fact Table (Account info)
CREATE TABLE telco_customer.fact_subscriptions AS
SELECT 
    customer_id,
    tenure,
    contract,
    paperless_billing,
    payment_method,
    monthly_charges,
    total_charges,
    churn
FROM telco_customer.churn_data;


