\c ncstaffsql

-- Task 1: Which manager has the lowest-rated staff member?
SELECT dim_name.full_name FROM dim_name
JOIN fact_staff ON dim_name.staff_id = fact_staff.manager_id
ORDER BY fact_staff.mentees_staff_rating
LIMIT 1;