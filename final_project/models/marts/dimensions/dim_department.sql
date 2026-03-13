-- dim_department: FM only (6 rows)
SELECT
    ROW_NUMBER() OVER (ORDER BY department_id) AS DepartmentKey,
    department_id AS BKDepartmentID,
    department_id AS DepartmentName
FROM {{ ref('stg_fm_departments_lookup') }}
