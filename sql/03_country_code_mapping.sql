--mapping missing vales 
CREATE TABLE population_country_code_map (
    population_country VARCHAR(100),
    covid_code CHAR(2)
);

INSERT INTO population_country_code_map (population_country, covid_code)
VALUES
('United States', 'US'),
('Russia', 'RU'),
('DR Congo', 'CD'),
('Vietnam', 'VN'),
('Iran', 'IR'),
('Turkey', 'TR'),
('Tanzania', 'TZ'),
('United Kingdom', 'GB'),
('South Korea', 'KR'),
('Côte d''Ivoire', 'CI'),
('Venezuela', 'VE'),
('North Korea', 'KP'),
('Syria', 'SY'),
('Taiwan', 'TW'),
('Netherlands', 'NL'),
('Bolivia', 'BO'),
('Czech Republic (Czechia)', 'CZ'),
('Laos', 'LA'),
('Hong Kong', 'HK'),
('State of Palestine', 'PS'),
('Moldova', 'MD'),
('Réunion', 'RE'),
('Macao', 'MO'),
('Western Sahara', 'EH'),
('Brunei', 'BN'),
('Sao Tome & Principe', 'ST'),
('Curaçao', 'CW'),
('Micronesia', 'FM'),
('St. Vincent & Grenadines', 'VC'),
('U.S. Virgin Islands', 'VI'),
('Faeroe Islands', 'FO'),
('Turks and Caicos', 'TC'),
('Saint Kitts & Nevis', 'KN'),
('Sint Maarten', 'SX'),
('Caribbean Netherlands', 'BQ'),
('Saint Martin', 'MF'),
('Wallis & Futuna', 'WF'),
('Saint Pierre & Miquelon', 'PM'),
('Falkland Islands', 'FK');

UPDATE population
SET country_code = population_country_code_map.covid_code
FROM population_country_code_map
WHERE  population.country = population_country_code_map.population_country AND 
	   population.country_code IS NULL;

DROP TABLE population_country_code_map; 