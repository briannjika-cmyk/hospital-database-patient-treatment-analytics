-- I want to identify facilities where admissions frequently occur
-- when very few extra rooms are available.

SELECT
    f.hospital_code,
    COUNT(a.case_id) AS total_admissions,

    SUM(
        CASE
            WHEN a.available_extra_rooms <= 1 THEN 1
            ELSE 0
        END
    ) AS admissions_with_limited_rooms,

    ROUND(
        SUM(
            CASE
                WHEN a.available_extra_rooms <= 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(a.case_id),
        2
    ) AS limited_room_admission_rate

FROM admissions a
JOIN facilities f
    ON a.hospital_code = f.hospital_code
WHERE a.dataset_source = 'train'
    AND a.available_extra_rooms IS NOT NULL
GROUP BY f.hospital_code
ORDER BY limited_room_admission_rate DESC;