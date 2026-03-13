-- Staging: FudgeFlix Plans (7 rows)
SELECT
    plan_id,
    TRIM(plan_name) AS plan_name,  -- trailing space fix
    plan_price,
    plan_current
FROM {{ source('fudgeflix_v3', 'ff_plans') }}
