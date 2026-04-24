
## Achievement so far
I have successfully completed the Data Engineering and Pre-processing phase of the project. Here is the breakdown of the work:

- Database Architecture (The "Shredding" Process): I organized it into a Star Schema (dim_customers, dim_services, fact_subscriptions). This is a standard industry practice that makes the database more efficient and easier for others to navigate.

- Data Integrity & Cleaning: I implemented primary and foreign keys to ensure data consistency. I also handled common "dirty data" issues, such as converting text representations of booleans (e.g., 'Yes'/'No') into actual BOOLEAN types and fixing blank spaces in numeric columns (total_charges).

- Analytical Layer Creation: I built a "Staging Table" (stg_churn_cleaned). This is the "Golden Record"—a single, clean version of the truth used specifically for analysis, which excludes low-quality data (like records with missing charges).

- Initial Exploratory Data Analysis (EDA): In Python, I've already identified heavy-hitting drivers of churn, such as Month-to-Month contracts (42.7% churn) vs. Two-year contracts (2.8% churn).


## Why switching from SQL to Python -- SQL for Infrastructure; Python for Insight.

Initially, I performed the data transformation and schema setup directly within the Supabase SQL Editor. While this allowed me to execute PostgreSQL commands immediately on the cloud instance, I found that switching between the web-based SQL editor and my Python analysis environment was highly inefficient. This bottleneck led me to consolidate my workflow into Python, where I could use a single environment to both query the remote database and perform exploratory data analysis.

## What were the SQL queries for
I began with a raw dataset sourced from Kaggle. Upon initial inspection, the data was completely unstructured in terms of types—every field, including currency and tenure, was stored as text. I imported this directly into a dedicated "raw" table (churn_data_raw) to preserve the original integrity of the source before any modifications occurred.

1. Schema Isolation & Data Governance (01_create_raw_table.sql)
I began by creating a specific telco_customer schema. In a professional environment, you never just "dump" data into the public schema. By isolating the project here, I am practicing fundamental Data Governance. This ensures that my project’s raw and transformed data stay separate from other database users, which is a vital habit for maintaining security, organization, and scalability.

2. Data Type Optimization through Casting (02_transform_and_insert.sql)
Because the Kaggle data arrived as raw text, you will notice logic like ("SeniorCitizen" = '1')::BOOLEAN throughout my transformation scripts. This isn't just a simple change in format; it is Data Type Optimization. Storing flags as BOOLEAN rather than TEXT reduces the storage footprint of the database. Furthermore, it prepares the data for Python; Booleans allow for much faster logical filtering and statistical calculations in pandas than parsing strings ever would.

3. Star Schema Normalization (03_shred_to_star_schema.sql)
I moved away from a single, flat table by "shredding" the data into a professional Star Schema. I created dim_customers for demographics, dim_services for technical features, and fact_subscriptions for transactional data. This architecture reduces redundancy and organizes the data into logical dimensions, making it significantly more efficient for multi-layered analysis.

4. Relational Integrity & Constraint Mapping (04_customer_relationship_keys_setup.sql)
Once the tables were separated, I established relational integrity by assigning customer_id as the Primary Key for each table and enforcing Foreign Key constraints. By linking the service and subscription tables back to the main customer list, I ensured referential integrity, which prevents "orphan" records and ensures the database remains a reliable source of truth.

5. The Staging Table Strategy (05_missing_value_check_clean.sql)
After "shredding" the data into a normalized Star Schema for storage efficiency, I used a complex JOIN to flatten the data back into a single stg_churn_cleaned table. I call this my "Analytical Layer." This strategy is clever because it protects the source of truth. By performing my final cleaning—such as dropping the few rows with null charges—into a staging table, my core dimension and fact tables remain intact. If I need to change my analysis logic later, I don’t have to re-import the data; I simply re-run the staging script.
