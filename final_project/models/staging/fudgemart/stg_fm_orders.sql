-- Staging: FudgeMart Orders (3,516 rows)
SELECT
    order_id,
    customer_id,
    TRY_TO_DATE(order_date) AS order_date,
    REPLACE(TO_DATE(order_date)::VARCHAR, '-', '')::INT AS order_datekey,
    TRY_TO_DATE(shipped_date) AS shipped_date,
    REPLACE(TO_DATE(shipped_date)::VARCHAR, '-', '')::INT AS shipped_datekey,
    ship_via,
    creditcard_id
FROM {{ source('fudgemart_v3', 'fm_orders') }}
