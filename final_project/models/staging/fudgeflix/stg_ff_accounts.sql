-- Staging: FudgeFlix Accounts (35 rows)
SELECT
    account_id,
    account_email,
    account_firstname,
    account_lastname,
    account_address,
    account_zipcode,
    account_plan_id,
    TRY_TO_DATE(account_opened_on) AS account_opened_on
FROM {{ source('fudgeflix_v3', 'ff_accounts') }}
