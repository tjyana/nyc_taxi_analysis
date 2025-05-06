-- Practice Problem 3: Calculating Average Tip per Hour and Ranking the Hours
-- Scenario:
-- Analyze the taxi trips by calculating the average tip amount for each hour of the day, then rank the hours by this average to identify peak tipping periods.

-- SELECT
--   EXTRACT(HOUR from pickup_datetime) as pickup_hour,
--   tip_amount,
--   AVG(tip_amount) OVER (
--     PARTITION BY pickup_hour
--     ORDER BY pickup_hour

--   ) as tip_hourly_total


WITH hourly_avg AS (
  SELECT
    EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour,
    AVG(tip_amount) AS avg_tip
  FROM {{ ref('stg_taxi_trips') }}
  GROUP BY EXTRACT(HOUR FROM pickup_datetime)
)

SELECT
  pickup_hour,
  avg_tip,
  RANK() OVER (
    ORDER BY avg_tip DESC
  ) AS tip_rank
FROM hourly_avg
ORDER BY tip_rank;
