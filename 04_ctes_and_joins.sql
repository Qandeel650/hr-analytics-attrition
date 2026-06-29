-- ============================================
-- FILE: 04_ctes_and_joins.sql
-- Project: HR Analytics - Employee Attrition
-- Author: Qandeel Fatima
-- ============================================

-- ============================================
-- CTE Example - Departments with above-average income
-- ============================================
WITH avg_income AS (
    SELECT department, AVG(monthly_income) AS avg_income
    FROM hr
    GROUP BY department
    HAVING AVG(monthly_income) > 5000
)
SELECT * FROM avg_income;

-- ============================================
-- JOIN Example - hr table joined with dept_budget
-- (small lookup table created for JOIN practice)
-- ============================================
CREATE TABLE dept_budget (
    department VARCHAR(50),
    annual_budget NUMERIC
);

INSERT INTO dept_budget (department, annual_budget)
VALUES
    ('Sales', 500000),
    ('Human Resources', 150000),
    ('Research & Development', 800000);

SELECT
    h.department,
    SUM(h.monthly_income * 12) AS annual_salary_cost,
    d.annual_budget
FROM hr h
JOIN dept_budget d ON h.department = d.department
GROUP BY h.department, d.annual_budget;

-- ============================================
-- MULTIPLE CTEs CHAINED + JOIN
-- Combines attrition rate and average income by department
-- ============================================
WITH rate AS (
    SELECT
        department,
        COUNT(*) FILTER (WHERE attrition = 'Yes') AS left_count,
        COUNT(department) AS total_count,
        ROUND(
            COUNT(*) FILTER (WHERE attrition = 'Yes')::NUMERIC
            / COUNT(department) * 100, 2
        ) AS attrition_rate
    FROM hr
    GROUP BY department
),
avg_pay AS (
    SELECT
        AVG(monthly_income) AS avg_income,
        department
    FROM hr
    GROUP BY department
)
SELECT
    r.department,
    r.attrition_rate,
    a.avg_income
FROM rate r
JOIN avg_pay a ON r.department = a.department;

-- Result:
-- Human Resources           19.05%   $6,654.51
-- Research & Development    13.84%   $6,281.25
-- Sales                     20.63%   $6,959.17

-- KEY INSIGHT: Sales has the HIGHEST average department income
-- but ALSO the highest attrition rate. This reveals that
-- department-level averages mask role-level pay disparities
-- (see 05_analysis.sql for the breakdown by job_role)
