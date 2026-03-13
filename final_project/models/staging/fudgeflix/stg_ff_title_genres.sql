-- Staging: FudgeFlix Title Genres (27,841 rows)
-- Used to get primary genre for dim_product
SELECT
    tg_genre_name,
    tg_title_id
FROM {{ source('fudgeflix_v3', 'ff_title_genres') }}
