-- dim_customer: Merged FM customers (25) + FF accounts (35) → ~46 unique
-- 14 shared customers identified by email match
-- Assumption: shared customers get FM data as primary, FF data fills gaps

WITH fm_customers AS (
    SELECT
        customer_id AS BKCustomerID,
        customer_email AS CustomerEmail,
        customer_firstname AS CustomerFirstName,
        customer_lastname AS CustomerLastName,
        customer_address AS CustomerAddress,
        customer_city AS CustomerCity,
        customer_state AS CustomerState,
        customer_zip AS CustomerZip,
        customer_phone AS CustomerPhone,
        'FudgeMart' AS Division
    FROM {{ ref('stg_fm_customers') }}
),

ff_accounts AS (
    SELECT
        a.account_id AS BKCustomerID,
        a.account_email AS CustomerEmail,
        a.account_firstname AS CustomerFirstName,
        a.account_lastname AS CustomerLastName,
        COALESCE(a.account_address, 'Unknown') AS CustomerAddress,
        z.zip_city AS CustomerCity,
        z.zip_state AS CustomerState,
        a.account_zipcode AS CustomerZip,
        NULL AS CustomerPhone,
        'FudgeFlix' AS Division
    FROM {{ ref('stg_ff_accounts') }} a
    LEFT JOIN {{ ref('stg_ff_zipcodes') }} z
        ON a.account_zipcode = z.zip_code
),

combined AS (
    SELECT * FROM fm_customers
    UNION ALL
    SELECT * FROM ff_accounts
)

SELECT
    ROW_NUMBER() OVER (ORDER BY Division, BKCustomerID) AS CustomerKey,
    BKCustomerID,
    CustomerEmail,
    CustomerFirstName,
    CustomerLastName,
    CustomerAddress,
    CustomerCity,
    CustomerState,
    CustomerZip,
    CustomerPhone,
    Division
FROM combined
