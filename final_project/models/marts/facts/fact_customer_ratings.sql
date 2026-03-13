-- ★ fact_customer_ratings: MERGED (FM + FF)
-- FM: fm_customer_product_reviews (1,039 rows)
-- FF: ff_account_titles WHERE at_rating IS NOT NULL (1,933 rows)
-- Expected: ~2,972 rows

WITH fm_ratings AS (
    SELECT
        r.customer_id,
        r.product_id::VARCHAR AS product_id,
        r.review_datekey AS datekey,
        -- BK: composite of customer_id + product_id + review_date
        r.customer_id || '-' || r.product_id || '-' || r.review_datekey AS BKRatingID,
        r.review_stars AS RatingScore,
        'FudgeMart' AS Division
    FROM {{ ref('stg_fm_customer_product_reviews') }} r
),

ff_ratings AS (
    SELECT
        t.at_account_id AS customer_id,
        t.at_title_id AS product_id,
        t.queue_datekey AS datekey,
        t.at_id::VARCHAR AS BKRatingID,
        t.at_rating AS RatingScore,
        'FudgeFlix' AS Division
    FROM {{ ref('stg_ff_account_titles') }} t
    WHERE t.at_rating IS NOT NULL  -- exclude 435 NULLs
),

combined AS (
    SELECT * FROM fm_ratings
    UNION ALL
    SELECT * FROM ff_ratings
),

-- Lookup dimension keys
dim_c AS (SELECT CustomerKey, BKCustomerID, Division FROM {{ ref('dim_customer') }}),
dim_p AS (SELECT ProductKey, BKProductID, Division FROM {{ ref('dim_product') }})

SELECT
    c.CustomerKey,
    p.ProductKey,
    combined.datekey AS DateKey,
    combined.BKRatingID,
    combined.RatingScore,
    combined.Division
FROM combined
JOIN dim_c c
    ON combined.customer_id = c.BKCustomerID
    AND combined.Division = c.Division
JOIN dim_p p
    ON combined.product_id = p.BKProductID
    AND combined.Division = p.Division
