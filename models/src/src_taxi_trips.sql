SELECT * FROM {{ source('nyc_taxi_analysis', 'taxi_trips_jan2022') }}
