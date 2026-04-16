-- =========================================
-- 05 EXPLORATORY ANALYSIS
-- =========================================

-- Total reported COVID cases across the full dataset
SELECT
    SUM(new_cases) AS total_covid_cases
FROM covid_data cd;
-- This gives the total reported COVID cases in the dataset across all available years.


-- Total reported COVID cases by country across the full dataset
SELECT
    country,
    SUM(new_cases) AS total_cases
FROM covid_data
GROUP BY country
ORDER BY total_cases DESC;
-- This provides an all-time country-level view of reported cases before narrowing into 2026.


-- Build daily country-level breakdown view for later analysis
DROP VIEW IF EXISTS covid_breakdown;

CREATE VIEW covid_breakdown AS
SELECT
    date_reported,
    country,
    country_code,
    MAX(population) AS population,
    SUM(new_cases) AS new_cases,
    SUM(new_deaths) AS new_deaths
FROM covid_data
WHERE population IS NOT NULL
GROUP BY date_reported, country, country_code
ORDER BY date_reported, country;
-- This view creates a cleaner country-date breakdown for reuse in monthly and country-level analysis.


-- Build country-level breakdown view across the full dataset
DROP VIEW IF EXISTS covid_breakdown_by_country;

CREATE VIEW covid_breakdown_by_country AS
SELECT
    country,
    country_code,
    MAX(population) AS population,
    SUM(new_cases) AS new_cases,
    SUM(new_deaths) AS new_deaths,
    ROUND(SUM(new_cases) * 100000.0 / SUM(population), 2) AS cases_per_100k_population,
    SUM(new_deaths) AS number_of_covid_deaths,
    ROUND(SUM(new_deaths) * 100000.0 / SUM(population), 2) AS deaths_per_100k_population,
    ROUND(100.0 * SUM(new_deaths) / NULLIF(SUM(new_cases), 0), 2) AS death_rate_cases
FROM covid_data
GROUP BY country, country_code;
-- This view summarizes country-level COVID activity across the full dataset.