-- I want to compare the average length of stay across departments.
-- I join admissions with departments to retrieve department names.

SELECT
    d.department_name,
    COUNT(a.case_id) AS total_admissions,
    ROUND(AVG(a.stay), 2) AS average_length_of_stay
FROM admissions a
JOIN departments d
    ON a.department_id = d.department_id
WHERE a.dataset_source = 'train'
    AND a.stay IS NOT NULL
GROUP BY
    d.department_id,
    d.department_name
ORDER BY
    average_length_of_stay DESC;