-- =========================================
-- 09 YOY AND COMPARISONS
-- =========================================

-- 2026 Jan-Feb cases compared with 2022 Jan-Feb cases
WITH cases_2026_vs_2022 AS (
    SELECT
        SUM(CASE
            WHEN EXTRACT(YEAR FROM date_reported) = 2026 THEN new_cases ELSE 0
        END) AS cases_2026,
        SUM(CASE
            WHEN EXTRACT(YEAR FROM date_reported) = 2022 THEN new_cases ELSE 0
        END) AS cases_2022
    FROM covid_data
    WHERE
        (EXTRACT(YEAR FROM date_reported) = 2026 AND EXTRACT(MONTH FROM date_reported) <= 2)
        OR
        (EXTRACT(YEAR FROM date_reported) = 2022 AND EXTRACT(MONTH FROM date_reported) <= 2)
)
SELECT
    *,
    ROUND(cases_2026 * 100.00 / NULLIF(cases_2022, 0), 2) AS comparison_2026_vs_peak
FROM cases_2026_vs_2022;
-- This shows how small Jan-Feb 2026 case volume is when compared with the same period in the peak year.


-- 2026 Jan-Feb cases compared with 2025 Jan-Feb cases
WITH cases_2026_vs_2025 AS (
    SELECT
        SUM(CASE
            WHEN EXTRACT(YEAR FROM date_reported) = 2026 THEN new_cases ELSE 0
        END) AS cases_2026,
        SUM(CASE
            WHEN EXTRACT(YEAR FROM date_reported) = 2025 THEN new_cases ELSE 0
        END) AS cases_2025
    FROM covid_data
    WHERE
        (EXTRACT(YEAR FROM date_reported) = 2026 AND EXTRACT(MONTH FROM date_reported) <= 2)
        OR
        (EXTRACT(YEAR FROM date_reported) = 2025 AND EXTRACT(MONTH FROM date_reported) <= 2)
)
SELECT
    *,
    ROUND(cases_2026 * 100.00 / NULLIF(cases_2025, 0), 2) AS cases_ratio_2026_to_2025_pct
FROM cases_2026_vs_2025;
-- This shows 2026 Jan-Feb case volume as a percentage of the same period in 2025.


-- Year-over-year case growth using aligned Jan-Feb periods
WITH yearly_cases AS (
    SELECT
        EXTRACT(YEAR FROM date_reported) AS years,
        SUM(new_cases) AS total_cases
    FROM covid_data
    WHERE EXTRACT(MONTH FROM date_reported) <= 2
    GROUP BY EXTRACT(YEAR FROM date_reported)
)
SELECT
    years,
    total_cases,
    ROUND(
        (total_cases - LAG(total_cases) OVER (ORDER BY years)) * 100.0
        / NULLIF(LAG(total_cases) OVER (ORDER BY years), 0),
        2
    ) AS yoy_case_growth_pct
FROM yearly_cases
ORDER BY years;
-- This measures year-over-year change in cases using only Jan-Feb data for consistency across years.


-- Year-over-year death growth using aligned Jan-Feb periods
WITH yearly_deaths AS (
    SELECT
        EXTRACT(YEAR FROM date_reported) AS years,
        SUM(new_deaths) AS total_deaths
    FROM covid_data cd
    WHERE EXTRACT(MONTH FROM date_reported) <= 2
    GROUP BY years
)
SELECT
    years,
    total_deaths,
    ROUND(
        (total_deaths - LAG(total_deaths) OVER (ORDER BY years)) * 100.0
        / NULLIF(LAG(total_deaths) OVER (ORDER BY years), 0),
        2
    ) AS yoy_death_growth_pct
FROM yearly_deaths
ORDER BY years;
-- This measures year-over-year change in deaths using the same Jan-Feb comparison window.


-- Top countries: 2026 Jan-Feb vs 2025 Jan-Feb
WITH cases_2026_vs_2025 AS (
    SELECT
        country,
        SUM(CASE WHEN EXTRACT(YEAR FROM date_reported) = 2026 THEN new_cases ELSE 0 END) AS cases_2026,
        SUM(CASE WHEN EXTRACT(YEAR FROM date_reported) = 2025 THEN new_cases ELSE 0 END) AS cases_2025
    FROM covid_data
    WHERE EXTRACT(MONTH FROM date_reported) <= 2
    GROUP BY country
)
SELECT
    country,
    cases_2026,
    cases_2025,
    ROUND((cases_2026 - cases_2025) * 100.0 / NULLIF(cases_2025, 0), 2) AS pct_change
FROM cases_2026_vs_2025
WHERE cases_2025 > 0
  AND cases_2026 > 0
ORDER BY pct_change DESC
LIMIT 10;
-- This ranks the countries with the largest positive percentage change in Jan-Feb 2026 cases versus Jan-Feb 2025.