use autodesk;
CREATE TABLE IF NOT EXISTS opportunities (
	id VARCHAR(32) PRIMARY KEY,
	submission_state VARCHAR(32),
	outcome_state VARCHAR(32),
	company_id VARCHAR(32),
	office_id VARCHAR(32),
	date_created TIMESTAMP,
	location_city VARCHAR(64),
	location_state VARCHAR(32),
	location_country VARCHAR(32),
	work_type VARCHAR(512),
	is_foreign INT
)
