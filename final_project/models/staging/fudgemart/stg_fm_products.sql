-- Staging: FudgeMart Products (53 rows)
SELECT
    product_id,
    product_department,
    product_name,
    product_retail_price,
    product_wholesale_price,
    product_is_active,
    TRY_TO_TIMESTAMP(product_add_date) AS product_add_date,
    product_vendor_id,
    product_description
FROM {{ source('fudgemart_v3', 'fm_products') }}
