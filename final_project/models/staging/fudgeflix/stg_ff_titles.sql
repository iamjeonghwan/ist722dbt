-- Staging: FudgeFlix Titles (7,185 rows)
SELECT
    title_id,
    title_name,
    title_type,
    title_synopsis,
    title_avg_rating,
    title_release_year,
    title_runtime,
    title_rating,
    title_bluray_available,
    title_dvd_available,
    title_instant_available,
    TRY_TO_TIMESTAMP(title_date_modified) AS title_date_modified
FROM {{ source('fudgeflix_v3', 'ff_titles') }}
