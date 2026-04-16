-- =========================================
-- 08 YEARLY TREND ANALYSIS
-- =========================================

-- Yearly reported COVID cases
SELECT
    EXTRACT(YEAR FROM date_reported) AS years,
    SUM(new_cases) AS total_cases
FROM covid_data cd
GROUP BY years
ORDER BY years;
-- This shows the yearly progression of reported COVID cases and helps identify peak periods.


-- Yearly cases relative to world population
WITH yearly_covid_cases AS (
    SELECT
        EXTRACT(YEAR FROM date_reported) AS years,
        SUM(new_cases) AS total_cases
    FROM covid_data cd
    GROUP BY years
)
SELECT
    yp.years,
    SUM(yp.population) AS total_population,
    SUM(total_cases) AS total_cases,
    ROUND(SUM(total_cases) * 100000.0 / SUM(yp.population), 2) AS cases_per_100k_population
FROM yearly_covid_cases yc
JOIN yearly_population yp
    ON yc.years = yp.years
GROUP BY yp.years, yp.population
ORDER BY yp.years;
-- This compares yearly case counts with world population to show how infection intensity changed over time.


-- Yearly deaths relative to world population
WITH yearly_covid_deaths AS (
    SELECT
        EXTRACT(YEAR FROM date_reported) AS years,
        SUM(new_deaths) AS total_deaths
    FROM covid_data cd
    GROUP BY years
)
SELECT
    yp.years,
    SUM(yp.population) AS total_population,
    SUM(total_deaths) AS total_deaths,
    ROUND(SUM(total_deaths) * 100000.0 / SUM(yp.population), 2) AS deaths_per_100k_population
FROM yearly_covid_deaths yc
JOIN yearly_population yp
    ON yc.years = yp.years
GROUP BY yp.years, yp.population
ORDER BY yp.years;
-- This shows how COVID death intensity changed relative to global population over time.


-- Yearly cases, deaths, and death rate
SELECT
    EXTRACT(YEAR FROM date_reported) AS years,
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    ROUND((SUM(new_deaths) * 100.0) / NULLIF(SUM(new_cases), 0), 2) AS death_rate
FROM covid_data cd
GROUP BY years
ORDER BY years;
-- This compares yearly case counts, death counts, and the share of cases that resulted in death.


-- Yearly deaths per 100k population vs death rate
WITH yearly_covid_cases AS (
    SELECT
        EXTRACT(YEAR FROM date_reported) AS years,
        SUM(new_cases) AS total_cases,
        SUM(new_deaths) AS total_deaths
    FROM covid_data cd
    GROUP BY years
)
SELECT
    yp.years,
    ROUND(SUM(yc.total_deaths) * 100000.0 / SUM(yp.population), 2) AS death_per_100k_population,
    ROUND(SUM(yc.total_deaths) * 100.0 / NULLIF(SUM(yc.total_cases), 0), 2) AS death_rate
FROM yearly_covid_cases yc
JOIN yearly_population yp
    ON yc.years = yp.years
GROUP BY yp.years, yp.population
ORDER BY yp.years;
-- This shows the difference between population-level death impact and death rate among reported cases.