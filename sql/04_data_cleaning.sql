--update the covid data with population
UPDATE covid_data
SET population = population.population
FROM population
WHERE covid_data.country_code = population.country_code;

UPDATE covid_data
SET new_deaths = 0
WHERE new_deaths IS NULL;

--checking for duplicates
WITH duplicates AS (
SELECT ctid,
	row_number() OVER(PARTITION BY date_reported, country_code ORDER BY date_reported) AS row_num
FROM
	covid_data cd 
ORDER BY
	row_num DESC)

	SELECT *
FROM duplicates
WHERE row_num > 1;
--no duplicates found