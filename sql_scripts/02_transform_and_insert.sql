CREATE TABLE IF NOT EXISTS telco_customer.churn_data (
    customer_id TEXT PRIMARY KEY,
    gender TEXT,
    senior_citizen BOOLEAN,
    partner BOOLEAN,
    dependents BOOLEAN,
    tenure INTEGER,
    phone_service BOOLEAN,
    multiple_lines TEXT,
    internet_service TEXT,
    online_security TEXT,
    online_backup TEXT,
    device_protection TEXT,
    tech_support TEXT,
    streaming_tv TEXT,
    streaming_movies TEXT,
    contract TEXT,
    paperless_billing BOOLEAN,
    payment_method TEXT,
    monthly_charges NUMERIC(10,2),
    total_charges NUMERIC(10,2),
    churn BOOLEAN
);

INSERT INTO telco_customer.churn_data (
    customer_id, gender, senior_citizen, partner, dependents, 
    tenure, phone_service, multiple_lines, internet_service, 
    online_security, online_backup, device_protection, tech_support, 
    streaming_tv, streaming_movies, contract, paperless_billing, 
    payment_method, monthly_charges, total_charges, churn
)
SELECT 
    "customerID",                 -- Added quotes to match raw table
    "gender",                     
    ("SeniorCitizen" = '1')::BOOLEAN, 
    ("Partner" = 'Yes')::BOOLEAN,      
    ("Dependents" = 'Yes')::BOOLEAN,   
    "tenure"::INTEGER,             
    ("PhoneService" = 'Yes')::BOOLEAN, 
    "MultipleLines",
    "InternetService",
    "OnlineSecurity",
    "OnlineBackup",
    "DeviceProtection",
    "TechSupport",
    "StreamingTV",
    "StreamingMovies",
    "Contract",
    ("PaperlessBilling" = 'Yes')::BOOLEAN,
    "PaymentMethod",
    "MonthlyCharges"::NUMERIC,
    NULLIF("TotalCharges", ' ')::NUMERIC, -- The fix for blank spaces
    ("Churn" = 'Yes')::BOOLEAN
FROM telco_customer.churn_data_raw; 