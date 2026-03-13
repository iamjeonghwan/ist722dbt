-- fact_employee_timesheets: FM only (~6,275 rows)
-- Source: fm_employee_timesheets
-- Includes derived LaborCost

WITH dim_e AS (SELECT EmployeeKey, BKEmployeeID, EmployeeDepartment FROM {{ ref('dim_employee') }}),
dim_d AS (SELECT DepartmentKey, BKDepartmentID FROM {{ ref('dim_department') }})

SELECT
    e.EmployeeKey,
    ts.payroll_datekey AS DateKey,
    d.DepartmentKey,
    ts.timesheet_id AS BKTimesheetID,
    ts.timesheet_hours AS TimesheetHours,
    ts.timesheet_hourlyrate AS HourlyRate,
    ROUND(ts.timesheet_hours * ts.timesheet_hourlyrate, 2) AS LaborCost,
    'FudgeMart' AS Division
FROM {{ ref('stg_fm_employee_timesheets') }} ts
JOIN dim_e e ON ts.timesheet_employee_id = e.BKEmployeeID
JOIN dim_d d ON e.EmployeeDepartment = d.BKDepartmentID
