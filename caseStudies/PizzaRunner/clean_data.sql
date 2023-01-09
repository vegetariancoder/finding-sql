DROP TABLE IF EXISTS new_customer_orders;
CREATE TEMP TABLE new_customer_orders AS (
	SELECT order_id,
		customer_id,
		pizza_id,
		CASE
			WHEN exclusions = ''
			OR exclusions LIKE 'null' THEN null
			ELSE exclusions
		END AS exclusions,
		CASE
			WHEN extras = ''
			OR extras LIKE 'null' THEN null
			ELSE extras
		END AS extras,
		order_time
	FROM customer_orders
);

SELECT * FROM new_customer_orders;



DROP TABLE IF EXISTS new_runner_orders;
CREATE TEMP TABLE new_runner_orders AS (
	SELECT order_id,
		runner_id,
		CASE
			WHEN pickup_time LIKE 'null' THEN NULL
			ELSE pickup_time
		END::timestamp AS pickup_time,
		-- Return null value if both arguments are equal
		-- Use regex to match only numeric values and decimal point.
		-- Convert to numeric datatype
		NULLIF(regexp_replace(distance, '[^0-9.]', '', 'g'), '')::NUMERIC AS distance,
		NULLIF(regexp_replace(duration, '[^0-9.]', '', 'g'), '')::NUMERIC AS duration,
		CASE
			WHEN cancellation LIKE 'null'
			OR cancellation LIKE 'NaN'
			OR cancellation LIKE '' THEN NULL
			ELSE cancellation
		END AS cancellation
	FROM runner_orders
);

SELECT * FROM new_runner_orders;