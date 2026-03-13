-- Staging: FudgeFlix Account Billing (1,294 rows)
SELECT
    ab_id,
    TRY_TO_DATE(ab_date) AS ab_date,
    REPLACE(TO_DATE(ab_date)::VARCHAR, '-', '')::INT AS billing_datekey,
    ab_account_id,
    ab_plan_id,
    ab_billed_amount
FROM {{ source('fudgeflix_v3', 'ff_account_billing') }}
