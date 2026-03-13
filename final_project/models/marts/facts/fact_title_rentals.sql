-- fact_title_rentals: FF only (~2,368 rows)
-- Source: ff_account_titles

WITH dim_c AS (SELECT CustomerKey, BKCustomerID FROM {{ ref('dim_customer') }} WHERE Division = 'FudgeFlix'),
dim_p AS (SELECT ProductKey, BKProductID FROM {{ ref('dim_product') }} WHERE Division = 'FudgeFlix'),
dim_pl AS (SELECT PlanKey, BKPlanID FROM {{ ref('dim_plan') }}),
accts AS (SELECT account_id, account_plan_id FROM {{ ref('stg_ff_accounts') }})

SELECT
    c.CustomerKey,
    p.ProductKey,
    t.queue_datekey AS DateKey,
    pl.PlanKey,
    t.at_id AS BKRentalID,
    t.at_rating AS AtRating,
    t.shipped_datekey AS ShippedDateKey,
    t.returned_datekey AS ReturnedDateKey,
    t.days_to_return AS DaysToReturn,
    'FudgeFlix' AS Division
FROM {{ ref('stg_ff_account_titles') }} t
JOIN accts a ON t.at_account_id = a.account_id
JOIN dim_c c ON t.at_account_id = c.BKCustomerID
JOIN dim_p p ON t.at_title_id = p.BKProductID
JOIN dim_pl pl ON a.account_plan_id = pl.BKPlanID
