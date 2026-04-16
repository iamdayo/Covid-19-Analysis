-- =========================================
-- 06 KPI AND 2026 SNAPSHOT
-- =========================================

-- 2026 KPI snapshot: cases, deaths, and population-adjusted rates
WITH covid_2026 AS (
    SELECT
        country,
        country_code,
        MAX(population) AS population,
        SUM(new_cases) AS total_cases_2026,
        SUM(new_deaths) AS total_deaths_2026
    FROM covid_data
    WHERE EXTRACT(YEAR FROM date_reported) = 2026
      AND population IS NOT NULL
    GROUP BY country, country_code
)
SELECT
    SUM(population) AS total_population,
    SUM(total_cases_2026) AS number_of_2026_cases,
    ROUND(SUM(total_cases_2026) * 100000.0 / SUM(population), 2) AS cases_per_100k_population,
    SUM(total_deaths_2026) AS number_of_2026_covid_deaths,
    ROUND(SUM(total_deaths_2026) * 100000.0 / SUM(population), 2) AS deaths_per_100k_population,
    ROUND(100.0 * SUM(total_deaths_2026) / NULLIF(SUM(total_cases_2026), 0), 2) AS death_rate_cases_2026
FROM covid_2026;
-- This KPI snapshot shows that COVID-19 is still present in 2026, although at a very low level relative to population.


-- Monthly breakdown of cases and deaths in 2026
WITH covid_2026 AS (
    SELECT
        EXTRACT(MONTH FROM date_reported) AS mon_num,
        TO_CHAR(date_reported, 'Mon') AS month_name,
        country,
        country_code,
        MAX(population) AS population,
        SUM(new_cases) AS new_cases,
        SUM(new_deaths) AS new_deaths
    FROM covid_breakdown
    WHERE EXTRACT(YEAR FROM date_reported) = 2026
    GROUP BY mon_num, month_name, country, country_code
)
SELECT
    mon_num,
    month_name,
    SUM(population) AS total_population,
    SUM(new_cases) AS number_of_2026_cases,
    ROUND(SUM(new_cases) * 100000.0 / SUM(population), 2) AS cases_per_100k_population,
    SUM(new_deaths) AS number_of_2026_covid_deaths,
    ROUND(SUM(new_deaths) * 100000.0 / SUM(population), 2) AS deaths_per_100k_population,
    ROUND(100.0 * SUM(new_deaths) / NULLIF(SUM(new_cases), 0), 2) AS death_rate_cases_2026
FROM covid_2026
GROUP BY mon_num, month_name
ORDER BY mon_num;
-- This shows how reported cases and deaths were distributed across the available 2026 months.