----creating tables 
CREATE TABLE covid_data_2026 (
    date_reported DATE,
    country_code VARCHAR(10),
    country VARCHAR(100),
    who_region VARCHAR(50),
    new_cases INTEGER,
    cumulative_cases BIGINT,
    new_deaths INTEGER,
    cumulative_deaths BIGINT
);

CREATE TABLE population_2026 (
    country VARCHAR(100) PRIMARY KEY,
    population BIGINT NOT NULL CHECK (population >= 0)
);
