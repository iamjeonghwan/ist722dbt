-- Staging: FudgeMart Employee Timesheets (6,275 rows)
SELECT
    timesheet_id,
    TRY_TO_DATE(timesheet_payrolldate) AS timesheet_payrolldate,
    REPLACE(TO_DATE(timesheet_payrolldate)::VARCHAR, '-', '')::INT AS payroll_datekey,
    timesheet_hourlyrate,
    timesheet_employee_id,
    timesheet_hours
FROM {{ source('fudgemart_v3', 'fm_employee_timesheets') }}
