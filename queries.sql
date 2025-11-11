\c ncstaffsql

-- Task 1: Which manager has the lowest-rated staff member?
SELECT 
    dim_name.full_name 
FROM dim_name
JOIN fact_staff ON dim_name.staff_id = fact_staff.manager_id
ORDER BY fact_staff.mentees_staff_rating
LIMIT 1;

-- Task 2: Which staff member has worked the most cohorts based on how much they charge 
-- per event and the total revenue to far?
SELECT 
    dim_name.full_name, 
    ROUND(CAST(revenue / daily_rate AS numeric),0) AS cohorts_worked
FROM dim_name
JOIN fact_staff ON dim_name.staff_id = fact_staff.staff_id
ORDER BY cohorts_worked DESC
LIMIT 1;

-- Task 3: Which quarter is the busiest for our staff members?
SELECT 
    EXTRACT(QUARTER FROM dim_date.next_cohort_date) AS quarter, 
    SUM(fact_staff.mentees) AS total_mentees 
FROM fact_staff
JOIN dim_date ON dim_date.date_id = fact_staff.date_id
GROUP BY quarter
ORDER BY total_mentees DESC
LIMIT 1;

-- Task 4: What is the total revenue for that quarter?
SELECT 
    EXTRACT(QUARTER FROM dim_date.next_cohort_date) AS quarter,    
    ROUND(CAST(SUM(revenue)AS numeric),2) AS total_revenue
FROM fact_staff
JOIN dim_date ON dim_date.date_id = fact_staff.date_id
GROUP BY quarter
ORDER BY quarter
LIMIT 1;

