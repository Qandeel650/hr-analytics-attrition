-- ============================================
-- FILE: 03_window_functions.sql
-- Project: HR Analytics - Employee Attrition
-- Author: Qandeel Fatima
-- ============================================

-- ============================================
-- RANK() - Rank employees by income (company-wide)
-- ============================================
SELECT
    employee_number,
    monthly_income,
    RANK() OVER (ORDER BY monthly_income DESC) AS rank_no
FROM hr;

-- ============================================
-- RANK() + PARTITION BY - Rank within each department
-- ============================================
SELECT
    employee_number,
    monthly_income,
    department,
    RANK() OVER (PARTITION BY department ORDER BY monthly_income DESC) AS rank_no
FROM hr;

-- ============================================
-- RANK() + PARTITION BY - Rank by total_working_years within job_role
-- ============================================
SELECT
    employee_number,
    total_working_years,
    job_role,
    RANK() OVER (PARTITION BY job_role ORDER BY total_working_years DESC) AS rank_emp
FROM hr;

-- ============================================
-- ROW_NUMBER() + PARTITION BY
-- ============================================
SELECT
    employee_number,
    department,
    monthly_income,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY monthly_income DESC) AS row_rank
FROM hr;

-- ============================================
-- LAG() - Compare each employee's income to previous row
-- ============================================
SELECT
    employee_number,
    monthly_income,
    LAG(monthly_income) OVER (ORDER BY monthly_income DESC) AS prev_income
FROM hr;

-- ============================================
-- LEAD() - Compare each employee's income to next row
-- ============================================
SELECT
    employee_number,
    monthly_income,
    LEAD(monthly_income) OVER (ORDER BY monthly_income DESC) AS next_income
FROM hr;
