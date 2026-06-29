-- ============================================
-- FILE: 05_analysis.sql
-- Project: HR Analytics - Employee Attrition
-- Author: Qandeel Fatima
-- ============================================

-- ============================================
-- ANALYSIS 1: Attrition Rate by Department
-- ============================================
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
ORDER BY attrition_rate DESC;

-- Result:
-- Sales                     20.63%  <- highest
-- Human Resources           19.05%
-- Research & Development    13.84%  <- lowest

-- ============================================
-- ANALYSIS 2: Average Income by Job Role within Sales
-- Reveals the entry-level pay gap hidden by department average
-- ============================================
SELECT
    department,
    job_role,
    AVG(job_level) AS avg_job_level
FROM hr
WHERE department = 'Sales'
GROUP BY job_role;

-- Result:
-- Manager               job_level 4.24  (senior)
-- Sales Executive        job_level 2.33  (mid)
-- Sales Representative   job_level 1.08  (entry-level)

-- ============================================
-- ANALYSIS 3: Salary Tier Classification (CASE WHEN)
-- ============================================
SELECT
    employee_number,
    monthly_income,
    CASE
        WHEN monthly_income < 3000 THEN 'Low'
        WHEN monthly_income BETWEEN 3000 AND 7000 THEN 'Medium'
        WHEN monthly_income > 7000 THEN 'High'
    END AS salary_tier
FROM hr;

-- ============================================
-- ANALYSIS 4: Subquery - Employees above average income
-- ============================================
SELECT employee_number, monthly_income
FROM hr
WHERE monthly_income > (SELECT AVG(monthly_income) FROM hr);

-- ============================================
-- ANALYSIS 5: UNION - Combine high earners and long tenure employees
-- ============================================
SELECT employee_number
FROM hr
WHERE monthly_income > 7000

UNION

SELECT employee_number
FROM hr
WHERE years_at_company > 15;

-- ============================================
-- FINAL BUSINESS INSIGHT
-- ============================================
-- Sales has the highest attrition rate (20.63%) despite having
-- the highest department-level average income ($6,959). This
-- average is misleading: it is inflated by senior Manager salaries
-- (job_level 4.24) while entry-level Sales Representatives
-- (job_level 1.08) earn only $2,626 - the lowest paid role
-- company-wide. This pay gap, combined with heavy entry-level
-- workload, is the likely driver of Sales' elevated attrition.
--
-- RECOMMENDATION: Increase Sales Representative base pay by
-- 10-15% independent of department averages, to retain
-- entry-level talent and build a stable promotion pipeline.
