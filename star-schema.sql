\c ncstaffsql

-- facts table: mentees, mentees_staff_rating, daily_rate, revenue
-- dimensions: first_name, last_name, area, course, manager, next_cohort_date


-- cohort date dimension table
DROP TABLE dim_date CASCADE;

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
DROP TABLE dim_area CASCADE;

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
DROP TABLE dim_name CASCADE;

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


-- course dimension table
DROP TABLE dim_course CASCADE;

CREATE TABLE dim_course
(
    course_id SERIAL PRIMARY KEY,
    course VARCHAR(100)
);

INSERT INTO dim_course (course)
SELECT DISTINCT course
FROM staff;

SELECT * FROM dim_course;


-- fact table
DROP TABLE fact_staff CASCADE;

CREATE TABLE fact_staff 
(
    staff_id INT REFERENCES dim_name(staff_id),
    course_id INT REFERENCES dim_course(course_id),
    area_id INT REFERENCES dim_area(area_id),
    date_id INT REFERENCES dim_date(date_id),
    manager_id INT REFERENCES dim_name(staff_id),
    mentees INT,
    mentees_staff_rating INT,
    daily_rate FLOAT,
    revenue FLOAT
);

INSERT INTO fact_staff (
    staff_id, area_id, course_id, manager_id, date_id, mentees, 
    mentees_staff_rating, daily_rate, revenue
)
SELECT 
    empl.staff_id, 
    dim_area.area_id, 
    dim_course.course_id, 
    manager.staff_id AS manager_id, 
    dim_date.date_id, 
    staff.mentees, 
    staff.mentees_staff_rating,
    staff.daily_rate, 
    staff.revenue
FROM staff
JOIN dim_name empl ON staff.first_name = empl.first_name AND staff.last_name = empl.last_name
JOIN dim_area ON staff.area = dim_area.area
JOIN dim_course ON staff.course = dim_course.course
JOIN dim_name manager ON staff.manager = manager.first_name || ' ' || manager.last_name
JOIN dim_date ON TO_DATE(staff.next_cohort_date, 'DD Month YYYY') = dim_date.next_cohort_date;

SELECT * FROM fact_staff;