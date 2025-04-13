-- models/daily_aggregates.sql

WITH trips AS (
  SELECT
    DATE(pickup_datetime) AS trip_date,
    TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND) AS trip_duration
  FROM {{ ref('1_NEW_taxi_trips_cleaned') }}
)
SELECT
  trip_date,
  COUNT(*) AS total_trips,
  AVG(trip_duration) AS avg_trip_duration
FROM trips
GROUP BY trip_date
ORDER BY trip_date
