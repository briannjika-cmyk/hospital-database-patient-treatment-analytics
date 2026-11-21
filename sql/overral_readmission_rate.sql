
-- I want to calculate the overall repeat-admission rate.
-- I compare patients with multiple admissions against all unique patients.

SELECT
    COUNT(*) AS total_unique_patients,

    SUM(admission_count > 1) AS patients_with_multiple_admissions,

    ROUND(
        SUM(admission_count > 1) * 100.0 / COUNT(*),
        2
    ) AS overall_repeat_admission_rate
FROM (
    SELECT
        patient_id,
        COUNT(*) AS admission_count
    FROM admissions
    WHERE dataset_source = 'train'
    GROUP BY patient_id
) AS patient_admissions;