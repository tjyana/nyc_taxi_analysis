-- models/peak_hours.sql

WITH hourly_trips AS (
  SELECT
    EXTRACT(HOUR FROM pickup_datetime) as pickup_hour,
    COUNT(*) AS total_trips,

  FROM {{ ref('stg_taxi_trips') }}
  GROUP BY pickup_hour
    )

SELECT *
FROM hourly_trips
ORDER BY pickup_hour
