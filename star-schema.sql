\c ncstaffsql

-- facts table: mentees, mentees_staff_rating, daily_rate, revenue
-- dimensions: first_name, last_name, area, course, manager, next_cohort_date

DROP TABLE IF EXISTS dim_date;

-- cohort date dimension table
CREATE TABLE dim_date
(
    date_id SERIAL PRIMARY KEY,
    next_cohort_date DATE
);

INSERT INTO dim_date (next_cohort_date)
SELECT DISTINCT TO_DATE(next_cohort_date, 'DD Month YYYY')
FROM staff; 

SELECT * FROM dim_date;