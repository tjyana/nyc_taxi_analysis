-- Practice Problem 3: Calculating Average Tip per Hour and Ranking the Hours
-- Scenario:
-- Analyze the taxi trips by calculating the average tip amount for each hour of the day, then rank the hours by this average to identify peak tipping periods.

SELECT
  EXTRACT(HOUR from pickup_datetime) as pickup_hour,
  tip_amount,
  SUM(tip_amount) OVER (
    PARTITION BY pickup_hour, DATE(pickup_datetime)
    ORDER BY pickup_hour, DATE(pickup_datetime)

  ) as tip_hourly_total
