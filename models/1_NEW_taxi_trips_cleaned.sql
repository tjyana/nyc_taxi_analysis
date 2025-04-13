

-- start of CTE
WITH

-- tag each duplicate as row_num=2
tag_duplicates AS (
  SELECT
    *,
    ROW_NUMBER() OVER(
      PARTITION BY
        vendor_id,
        pickup_datetime,
        dropoff_datetime,
        passenger_count,
        trip_distance,
        pickup_location_id,
        dropoff_location_id,
        fare_amount
      ORDER BY pickup_datetime
    ) AS row_num
    FROM {{ source('nyc_taxi_analysis', 'taxi_trips_jan2022') }}
  -- FROM `nyc-taxi-trips-455202.nyc_taxi_analysis.taxi_trips_jan2022`
),

--only select first occurence (eg. row_num=1) of duplicates
remove_duplicates AS (
  SELECT *
  FROM tag_duplicates
  WHERE row_num = 1
)
-- end of CTE


-- create surrogate_key column with unique id
SELECT
  ROW_NUMBER() OVER(
    ORDER BY pickup_datetime
  ) AS id_key,
  *
FROM remove_duplicates
