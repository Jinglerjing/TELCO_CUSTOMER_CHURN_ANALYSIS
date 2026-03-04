-- Define Primary Keys (The unique ID for each table)
ALTER TABLE telco_customer.dim_customers ADD PRIMARY KEY (customer_id);
ALTER TABLE telco_customer.dim_services ADD PRIMARY KEY (customer_id);
ALTER TABLE telco_customer.fact_subscriptions ADD PRIMARY KEY (customer_id);

-- Define Foreign Keys (The "Links" between tables)
-- This ensures you can't have a service record for a customer that doesn't exist.
ALTER TABLE telco_customer.dim_services 
ADD CONSTRAINT fk_services_customer 
FOREIGN KEY (customer_id) REFERENCES telco_customer.dim_customers (customer_id);

ALTER TABLE telco_customer.fact_subscriptions 
ADD CONSTRAINT fk_fact_customer 
FOREIGN KEY (customer_id) REFERENCES telco_customer.dim_customers (customer_id);