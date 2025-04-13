-- models/peak_hours.sql

WITH hourly_trips AS (
  SELECT
    EXTRACT(HOUR FROM pickup_datetime) as pickup_hour,
    COUNT(*) AS total_trips,

  FROM {{ ref('1_NEW_taxi_trips_cleaned')}}
  GROUP BY pickup_hour
    )

SELECT *
FROM hourly_trips
ORDER BY pickup_hour
