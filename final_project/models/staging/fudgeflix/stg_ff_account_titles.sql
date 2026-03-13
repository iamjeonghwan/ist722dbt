-- Staging: FudgeFlix Account Titles (2,368 rows) ★ 통합 핵심
SELECT
    at_id,
    at_account_id,
    at_title_id,
    TRY_TO_DATE(at_queue_date) AS at_queue_date,
    REPLACE(TO_DATE(at_queue_date)::VARCHAR, '-', '')::INT AS queue_datekey,
    TRY_TO_DATE(at_shipped_date) AS at_shipped_date,
    CASE WHEN at_shipped_date IS NOT NULL
         THEN REPLACE(TO_DATE(at_shipped_date)::VARCHAR, '-', '')::INT
    END AS shipped_datekey,
    TRY_TO_DATE(at_returned_date) AS at_returned_date,
    CASE WHEN at_returned_date IS NOT NULL
         THEN REPLACE(TO_DATE(at_returned_date)::VARCHAR, '-', '')::INT
    END AS returned_datekey,
    at_rating,
    CASE WHEN at_shipped_date IS NOT NULL AND at_returned_date IS NOT NULL
         THEN DATEDIFF('day', TRY_TO_DATE(at_shipped_date), TRY_TO_DATE(at_returned_date))
    END AS days_to_return
FROM {{ source('fudgeflix_v3', 'ff_account_titles') }}
