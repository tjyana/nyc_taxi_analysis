SELECT
  DATE(pickup_datetime) AS ride_date,
  fare_amount,
  SUM(fare_amount) OVER (
    PARTITION BY DATE(pickup_datetime)
    ORDER BY pickup_datetime
  ) as fare_running_total

FROM {{ ref('stg_taxi_trips') }}
