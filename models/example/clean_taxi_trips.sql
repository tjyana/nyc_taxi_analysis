-- models/clean_taxi_trips.sql

WITH raw AS (
    -- SELECT *
    -- FROM `nyc-taxi-trips-455202.nyc_taxi_analysis.taxi_trips_jan2022`
    SELECT * FROM {{ source('nyc_taxi_analysis', 'taxi_trips_jan2022') }}

)
SELECT
    pickup_datetime,
    dropoff_datetime,
    -- Replace null passenger counts with 0
    IFNULL(passenger_count, 0) AS passenger_count,
    -- Ensure trip_distance is a float for consistency
    CAST(trip_distance AS FLOAT64) AS trip_distance,
    -- Correct fare amounts: set negative fares to 0
    CASE
      WHEN fare_amount < 0 THEN 0
      ELSE fare_amount
    END AS fare_amount,
    pickup_location_id,
    dropoff_location_id,
FROM raw
WHERE pickup_datetime IS NOT NULL
  AND dropoff_datetime IS NOT NULL
