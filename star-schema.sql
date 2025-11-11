\c ncstaffsql

-- facts table: mentees, mentees_staff_rating, daily_rate, revenue
-- dimensions: first_name, last_name, area, course, manager, next_cohort_date


-- cohort date dimension table
DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date
(
    date_id SERIAL PRIMARY KEY,
    next_cohort_date DATE
);

INSERT INTO dim_date (next_cohort_date)
SELECT DISTINCT TO_DATE(next_cohort_date, 'DD Month YYYY')
FROM staff; 

SELECT * FROM dim_date;


-- area dimension table
DROP TABLE IF EXISTS dim_area;

CREATE TABLE dim_area
(
    area_id SERIAL PRIMARY KEY,
    area VARCHAR(50)
);

INSERT INTO dim_area (area)
SELECT DISTINCT area
FROM staff;

SELECT * FROM dim_area;


-- name dimension table
DROP TABLE IF EXISTS dim_name;

CREATE TABLE dim_name
(
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

INSERT INTO dim_name (first_name, last_name)
SELECT DISTINCT first_name, last_name
FROM staff;

SELECT * FROM dim_name;