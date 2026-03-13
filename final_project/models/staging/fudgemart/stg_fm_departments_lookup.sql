-- Staging: FudgeMart Departments (6 rows)
SELECT
    department_id
FROM {{ source('fudgemart_v3', 'fm_departments_lookup') }}
