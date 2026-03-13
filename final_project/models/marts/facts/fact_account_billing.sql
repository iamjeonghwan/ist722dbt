-- fact_account_billing: FF only (~1,294 rows)
-- Source: ff_account_billing

WITH dim_c AS (SELECT CustomerKey, BKCustomerID FROM {{ ref('dim_customer') }} WHERE Division = 'FudgeFlix'),
dim_pl AS (SELECT PlanKey, BKPlanID FROM {{ ref('dim_plan') }})

SELECT
    c.CustomerKey,
    b.billing_datekey AS DateKey,
    pl.PlanKey,
    b.ab_id AS BKBillingID,
    b.ab_billed_amount AS BilledAmount,
    'FudgeFlix' AS Division
FROM {{ ref('stg_ff_account_billing') }} b
JOIN dim_c c ON b.ab_account_id = c.BKCustomerID
JOIN dim_pl pl ON b.ab_plan_id = pl.BKPlanID
