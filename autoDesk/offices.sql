create database autodesk;
use autodesk;
CREATE TABLE IF NOT EXISTS offices (
	id VARCHAR(32) PRIMARY KEY,
	company_id VARCHAR(32),
	location_city VARCHAR(64),
	location_state VARCHAR(32),
	date_created TIMESTAMP
)


