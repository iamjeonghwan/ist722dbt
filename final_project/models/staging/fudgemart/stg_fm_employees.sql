-- Staging: FudgeMart Employees (33 rows)
-- SSN excluded for security
SELECT
    employee_id,
    employee_lastname,
    employee_firstname,
    TRIM(employee_jobtitle) AS employee_jobtitle,  -- trailing space fix
    employee_department,
    TRY_TO_DATE(employee_birthdate) AS employee_birthdate,
    TRY_TO_DATE(employee_hiredate) AS employee_hiredate,
    TRY_TO_DATE(employee_termdate) AS employee_termdate,
    employee_hourlywage,
    employee_fulltime,
    employee_supervisor_id
FROM {{ source('fudgemart_v3', 'fm_employees') }}
