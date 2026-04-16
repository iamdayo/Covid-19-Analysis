-- =========================================
-- 07 COUNTRY LEVEL ANALYSIS
-- =========================================

DROP VIEW IF EXISTS covid_by_country_2026;

CREATE VIEW covid_by_country_2026 AS
SELECT
    country,
    country_code,
    MAX(population) AS population,
    SUM(new_cases) AS new_cases_2026,
    ROUND(SUM(new_cases) * 100000.0 / SUM(population), 2) AS cases_per_100k_population,
    SUM(new_deaths) AS number_of_2026_covid_deaths,
    ROUND(SUM(new_deaths) * 100000.0 / SUM(population), 2) AS deaths_per_100k_population,
    ROUND(100.0 * SUM(new_deaths) / NULLIF(SUM(new_cases), 0), 2) AS death_rate_cases_2026
FROM covid_data
WHERE EXTRACT(YEAR FROM date_reported) = 2026
GROUP BY country, country_code;
-- This view prepares country-level 2026 analysis in one reusable table.


-- Top 10 countries by reported cases in 2026
SELECT
    country,
    population,
    new_cases_2026,
    cases_per_100k_population
FROM covid_by_country_2026
WHERE new_cases_2026 IS NOT NULL
ORDER BY new_cases_2026 DESC
LIMIT 10;
-- This ranks the countries with the highest reported case counts in 2026.


-- Top 10 countries by cases per 100k population in 2026
SELECT
    country,
    population,
    new_cases_2026,
    cases_per_100k_population
FROM covid_by_country_2026
WHERE cases_per_100k_population IS NOT NULL
ORDER BY cases_per_100k_population DESC
LIMIT 10;
-- This highlights where COVID activity is highest relative to population size.


-- Top 10 countries by reported deaths in 2026
SELECT
    country,
    population,
    number_of_2026_covid_deaths,
    deaths_per_100k_population
FROM covid_by_country_2026
ORDER BY number_of_2026_covid_deaths DESC
LIMIT 10;
-- This ranks countries by raw COVID death counts reported in 2026.


-- Top 10 countries by death rate among reported cases in 2026
SELECT
    country,
    new_cases_2026,
    number_of_2026_covid_deaths,
    death_rate_cases_2026
FROM covid_by_country_2026
WHERE new_cases_2026 >= 100
  AND number_of_2026_covid_deaths <> 0
ORDER BY death_rate_cases_2026 DESC
LIMIT 10;
-- Filtering to countries with at least 100 cases makes the death-rate ranking more meaningful.


-- Top 10 countries by deaths compared with cases in 2026
SELECT
    country,
    new_cases_2026,
    number_of_2026_covid_deaths
FROM covid_by_country_2026
WHERE new_cases_2026 IS NOT NULL
ORDER BY number_of_2026_covid_deaths DESC
LIMIT 10;
-- This gives a simple side-by-side view of countries with the highest reported deaths and their case counts.