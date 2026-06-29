# HR Analytics - Employee Attrition Analysis

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)

## Project Overview

An end-to-end analysis of employee attrition using the IBM HR Analytics dataset. This project demonstrates the same analysis validated across three different tools — PostgreSQL, Python (pandas), and Tableau — to identify the root cause of high attrition in the Sales department.

---

## Dashboard Preview

![Tableau Dashboard](dashboard/tableau_dashboard.png)

*Interactive Tableau dashboard with KPI cards, department attrition chart, and salary tier breakdown connected via filter action.*

---

## Dataset

| Property | Details |
|---|---|
| Source | IBM HR Analytics Employee Attrition Dataset (Kaggle) |
| Rows | 1,470 employee records |
| Columns | 22 (selected from original 35) |
| Quality | Clean — 0 nulls, 0 duplicates |

---

## Tools Used

| Tool | Purpose |
|---|---|
| PostgreSQL | Data storage, advanced SQL analysis |
| Python (pandas, matplotlib) | Cross-validation of SQL findings, visualization |
| Tableau | Interactive dashboard with filter actions |

---

## SQL Skills Demonstrated

```sql
-- Window Functions with PARTITION BY
SELECT
    employee_number, department, monthly_income,
    RANK() OVER (PARTITION BY department ORDER BY monthly_income DESC) AS rank_no
FROM hr;

-- Multiple chained CTEs combined with JOIN
WITH rate AS (
    SELECT department,
           ROUND(COUNT(*) FILTER (WHERE attrition = 'Yes')::NUMERIC
           / COUNT(department) * 100, 2) AS attrition_rate
    FROM hr GROUP BY department
),
avg_pay AS (
    SELECT department, AVG(monthly_income) AS avg_income
    FROM hr GROUP BY department
)
SELECT r.department, r.attrition_rate, a.avg_income
FROM rate r JOIN avg_pay a ON r.department = a.department;
```

Full SQL files available in [`/sql`](sql/) folder, covering:
- Window functions (RANK, ROW_NUMBER, LAG, LEAD)
- Multiple chained CTEs
- JOINs with a custom lookup table
- Subqueries
- UNION
- CASE WHEN logic

---

## Python Validation

```python
import pandas as pd

df = pd.read_csv('hr_export.csv')

# Validates SQL department attrition findings
print(df.groupby('department').size())
print(df.groupby('department')['monthly_income'].mean())
```

![Python Chart 1](dashboard/python_department_chart.png)
![Python Chart 2](dashboard/python_income_histogram.png)

Full script available in [`/python/hr_analysis.py`](python/hr_analysis.py)

**Every key finding was cross-validated across all three tools with identical results:**

| Metric | SQL | Python | Tableau |
|---|---|---|---|
| Employees by department | HR=63, R&D=961, Sales=446 | HR=63, R&D=961, Sales=446 | Matches |
| Avg income by department | Sales=$6,959 | Sales=$6,959 | Matches |
| Employees who left | 237 | 237 | Matches |

---

## Key Finding: The Hidden Pay Gap

The core insight of this project — discovered through layered SQL analysis:

```
Department-level average income for Sales: $6,959 (highest in company)
Sales attrition rate: 20.63% (highest in company)

These two facts initially seem contradictory.
```

Breaking down by job role within Sales revealed the explanation:

| Job Role | Job Level | Avg Income |
|---|---|---|
| Manager | 4.24 (senior) | High |
| Sales Executive | 2.33 (mid) | $6,924 |
| Sales Representative | 1.08 (entry-level) | $2,626 |

**The department average was masking a critical entry-level pay disparity.** Senior Manager salaries inflated the overall average, while entry-level Sales Representatives — who make up a large share of the department — were the lowest-paid role company-wide, directly driving the high attrition rate.

---

## Business Recommendation

Increase Sales Representative base pay by 10-15%, independent of department-wide averages, to retain entry-level talent and prevent the loss of an entire generation of junior staff before they can be promoted into senior roles.

---

## Repository Structure

```
hr-analytics-attrition/
├── README.md
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_data_profiling.sql
│   ├── 03_window_functions.sql
│   ├── 04_ctes_and_joins.sql
│   └── 05_analysis.sql
├── python/
│   └── hr_analysis.py
└── dashboard/
    ├── tableau_dashboard.png
    ├── python_department_chart.png
    └── python_income_histogram.png
```

---

## Author

**Qandeel Fatima**
Data Analyst | PostgreSQL | Python | Power BI | Tableau

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/qandeel-fatima-69879a272)

---

*This project is part of my data analytics portfolio. Feel free to explore the SQL queries, Python script, and dashboard.*
