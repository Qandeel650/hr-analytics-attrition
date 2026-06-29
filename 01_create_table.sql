-- ============================================
-- FILE: 01_create_table.sql
-- Project: HR Analytics - Employee Attrition
-- Author: Qandeel Fatima
-- ============================================

CREATE TABLE hr (
    age_group             VARCHAR(10),
    age                   INTEGER,
    attrition             VARCHAR(10),
    business_travel       VARCHAR(50),
    department            VARCHAR(50),
    education             INTEGER,
    education_field       VARCHAR(50),
    employee_number       INTEGER,
    gender                VARCHAR(10),
    job_involvement       INTEGER,
    job_level             INTEGER,
    job_role              VARCHAR(50),
    job_satisfaction      INTEGER,
    marital_status        VARCHAR(20),
    monthly_income        NUMERIC(10,2),
    over_time             VARCHAR(5),
    performance_rating    INTEGER,
    total_working_years   INTEGER,
    work_life_balance     INTEGER,
    years_at_company      INTEGER,
    years_in_current_role INTEGER,
    years_since_last_promotion INTEGER
);

-- Verify import
SELECT COUNT(*) FROM hr;
-- Result: 1,470 rows
