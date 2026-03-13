-- Staging: FudgeMart Customer Product Reviews (1,039 rows) ★ 통합 핵심
SELECT
    customer_id,
    product_id,
    TRY_TO_DATE(review_date) AS review_date,
    REPLACE(TO_DATE(review_date)::VARCHAR, '-', '')::INT AS review_datekey,
    review_stars
FROM {{ source('fudgemart_v3', 'fm_customer_product_reviews') }}
