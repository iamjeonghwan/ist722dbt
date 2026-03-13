-- dim_plan: FF only (7 rows)
-- plan_name TRIM applied in staging
SELECT
    ROW_NUMBER() OVER (ORDER BY plan_id) AS PlanKey,
    plan_id AS BKPlanID,
    plan_name AS PlanName,
    plan_price AS PlanPrice,
    CASE WHEN plan_current = 1 THEN TRUE ELSE FALSE END AS PlanIsCurrent
FROM {{ ref('stg_ff_plans') }}
