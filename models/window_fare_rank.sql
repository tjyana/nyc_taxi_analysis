SELECT
  DATE(pickup_datetime) as ride_date,
  fare_amount,
  ROW_NUMBER() OVER (
    PARTITION BY DATE(pickup_datetime)
    ORDER BY fare_amount DESC
  ) AS fare_rank

  FROM {{ ref('1_NEW_taxi_trips_cleaned') }}

-- This query selects the date of the ride and the fare amount from the clean_taxi_trips table.
-- It then assigns a rank to each fare amount for each date, ordering them in descending order.
