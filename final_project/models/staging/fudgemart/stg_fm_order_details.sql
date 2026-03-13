-- Staging: FudgeMart Order Details (10,466 rows)
SELECT
    order_id,
    product_id,
    order_qty
FROM {{ source('fudgemart_v3', 'fm_order_details') }}
