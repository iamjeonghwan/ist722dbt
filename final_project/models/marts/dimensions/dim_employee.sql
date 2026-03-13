-- dim_employee: FM only (33 rows)
-- SSN excluded, jobtitle TRIM applied
SELECT
    ROW_NUMBER() OVER (ORDER BY employee_id) AS EmployeeKey,
    employee_id AS BKEmployeeID,
    employee_firstname AS EmployeeFirstName,
    employee_lastname AS EmployeeLastName,
    employee_jobtitle AS EmployeeJobTitle,
    employee_department AS EmployeeDepartment,
    employee_hiredate AS EmployeeHireDate,
    CASE WHEN employee_termdate IS NULL THEN TRUE ELSE FALSE END AS EmployeeIsActive,
    CASE WHEN employee_fulltime = 1 THEN TRUE ELSE FALSE END AS EmployeeFullTime,
    'FudgeMart' AS Division
FROM {{ ref('stg_fm_employees') }}
