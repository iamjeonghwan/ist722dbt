-- dim_product: Merged FM products (53) + FF titles (7,185) → ~7,238
-- FM product_id is INT, FF title_id is VARCHAR → unified as VARCHAR

WITH fm_products AS (
    SELECT
        product_id::VARCHAR AS BKProductID,
        product_name AS ProductName,
        product_department AS ProductCategory,
        'Physical Product' AS ProductType,
        product_retail_price AS ProductRetailPrice,
        NULL AS ProductRating,
        NULL AS ProductReleaseYear,
        CASE WHEN product_is_active = 1 THEN TRUE ELSE FALSE END AS ProductIsActive,
        'FudgeMart' AS Division
    FROM {{ ref('stg_fm_products') }}
),

ff_primary_genre AS (
    -- Get first genre per title (alphabetical) as primary genre
    SELECT
        tg_title_id,
        MIN(tg_genre_name) AS primary_genre
    FROM {{ ref('stg_ff_title_genres') }}
    GROUP BY tg_title_id
),

ff_titles AS (
    SELECT
        t.title_id AS BKProductID,
        t.title_name AS ProductName,
        g.primary_genre AS ProductCategory,
        'Digital Content' AS ProductType,
        NULL AS ProductRetailPrice,
        t.title_rating AS ProductRating,
        t.title_release_year AS ProductReleaseYear,
        NULL AS ProductIsActive,
        'FudgeFlix' AS Division
    FROM {{ ref('stg_ff_titles') }} t
    LEFT JOIN ff_primary_genre g
        ON t.title_id = g.tg_title_id
),

combined AS (
    SELECT * FROM fm_products
    UNION ALL
    SELECT * FROM ff_titles
)

SELECT
    ROW_NUMBER() OVER (ORDER BY Division, BKProductID) AS ProductKey,
    BKProductID,
    ProductName,
    ProductCategory,
    ProductType,
    ProductRetailPrice,
    ProductRating,
    ProductReleaseYear,
    ProductIsActive,
    Division
FROM combined
