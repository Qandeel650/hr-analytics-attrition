-- ============================================
-- FILE: 02_data_profiling.sql
-- Project: HR Analytics - Employee Attrition
-- Author: Qandeel Fatima
-- ============================================

-- Check total rows
SELECT COUNT(*) AS total_rows FROM hr;

-- Check nulls across all key columns
SELECT
    COUNT(*) AS total_rows,
    COUNT(age_group) AS has_age_group,
    COUNT(attrition) AS has_attrition,
    COUNT(department) AS has_department,
    COUNT(job_role) AS has_job_role,
    COUNT(monthly_income) AS has_income,
    COUNT(gender) AS has_gender,
    COUNT(performance_rating) AS has_performance,
    COUNT(years_at_company) AS has_years
FROM hr;
-- Result: 0 nulls in all columns (clean dataset)

-- Check duplicates on employee_number
SELECT employee_number, COUNT(*)
FROM hr
GROUP BY employee_number
HAVING COUNT(*) > 1;
-- Result: 0 duplicates

-- ============================================
-- PROFILING SUMMARY:
-- Total rows    : 1,470
-- Nulls         : 0
-- Duplicates    : 0
-- Dataset is clean, no cleaning steps required
-- ============================================
