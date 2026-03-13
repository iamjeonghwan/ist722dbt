-- Staging: FudgeMart Customers (25 rows)
SELECT
    customer_id,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_address,
    customer_city,
    customer_state,
    customer_zip,
    customer_phone,
    customer_fax
FROM {{ source('fudgemart_v3', 'fm_customers') }}
