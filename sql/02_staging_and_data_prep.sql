--staging data
----------------------------------------------------
--create covid staging table
CREATE TABLE covid_data (LIKE covid_data_2026); 

INSERT INTO covid_data SELECT * FROM covid_data_2026; --insert data from covid raw to covid staging table

ALTER TABLE covid_data
ADD COLUMN population BIGINT;

--create 2026 population staging table
CREATE TABLE population (LIKE population_2026); 

INSERT INTO population SELECT * FROM population_2026; --insert data from 2026 population raw to covid staging table

--population per year data
CREATE TABLE yearly_population (
    "Year" INTEGER,
    "Population" BIGINT,
    "Yearly % Change" NUMERIC(6,4),
    "Net Change" BIGINT,
    "Density (P/Km²)" INTEGER
);

ALTER TABLE yearly_population
RENAME COLUMN "Yearly % Change" TO yearly_pct_change;

ALTER TABLE yearly_population
RENAME COLUMN "Net Change" TO net_change;

ALTER TABLE yearly_population
RENAME COLUMN "Density (P/Km²)" TO density_per_km2;

ALTER TABLE yearly_population
RENAME COLUMN "Year" TO years;

ALTER TABLE yearly_population
RENAME COLUMN "Population" TO population;
----------------------------------------------------