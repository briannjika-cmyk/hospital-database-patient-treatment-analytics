-- I want to find which age groups account for the highest proportion
-- of emergency admissions.

SELECT
    age,
    COUNT(*) AS emergency_admissions,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS proportion_of_emergency_admissions

FROM admissions
WHERE admission_type = 'Emergency'
    AND dataset_source = 'train'
    AND age IS NOT NULL

GROUP BY age

ORDER BY proportion_of_emergency_admissions DESC;