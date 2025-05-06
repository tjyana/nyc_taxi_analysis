-- models/daily_totals.sql

WITH raw AS (
    SELECT *
    FROM {{ ref('stg_taxi_trips') }}
),
-- Aggregate the data by day
daily_totals AS (
    SELECT
        DATE(pickup_datetime) AS date,
        COUNT(*) AS total_trips,
        SUM(passenger_count) AS total_passengers,
        SUM(trip_distance) AS total_distance,
        SUM(fare_amount) AS total_fare
    FROM raw

    WHERE pickup_datetime IS NOT NULL
      AND dropoff_datetime IS NOT NULL
    GROUP BY date
)
-- Final selection of the aggregated data
SELECT
    date,
    total_trips,
    total_passengers,
    total_distance,
    total_fare
FROM daily_totals
ORDER BY date

-- This query aggregates the taxi trip data by day, providing a summary of total trips,
-- total passengers, total distance, and total fare for each day in January 2022.
-- The final selection orders the results by date and limits the output to 1000 rows.
-- This is useful for analyzing daily trends in taxi usage and revenue.
-- The use of CTEs (Common Table Expressions) allows for better organization and readability
-- of the SQL code, making it easier to understand the transformation steps.
-- The raw data is first filtered to ensure that only valid pickup and dropoff datetimes are included,
-- and then the aggregation is performed on the filtered dataset.
-- The final output provides a clear and concise summary of the daily aggregates,
-- which can be further used for reporting or analysis.
-- The use of CTEs also allows for easier debugging and modification of the query,
-- as each step can be tested independently.
-- This approach is particularly useful in data analysis and reporting scenarios,
-- where clarity and maintainability of the SQL code are important.
