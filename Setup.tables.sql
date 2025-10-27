CREATE DATABASE; 
CREATE TABLE congress 
	(
	congress INT,
	start_date DATE, 
	chamber	VARCHAR(10),
	state_abbrev VARCHAR(10),
	party_code INT,
	bioname	VARCHAR(100),
	bioguide_id VARCHAR (20),
	birthday DATE,
	cmltv_cong INT,
	cmltv_chamber INT,
	age_days INT,
	age_years FLOAT,
	generation VARCHAR (50)
	);
