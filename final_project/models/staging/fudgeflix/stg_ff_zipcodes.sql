-- Staging: FudgeFlix Zipcodes (41,968 rows)
-- Used to derive city/state for ff_accounts
SELECT
    zip_code,
    zip_city,
    zip_state
FROM {{ source('fudgeflix_v3', 'ff_zipcodes') }}
