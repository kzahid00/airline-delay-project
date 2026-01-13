-- eda.sql
-- Purpose: Exploratory analysis to understand patterns in flight delays
-- Dataset: BTS On-Time Performance (2019, ORD outbound, delayed flights only)

-- Average departure delay by month
SELECT
    MONTH(Date_MM_DD_YYYY) AS month_of_flight,
    AVG(Departure_delay_Minutes) AS avg_delay
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
GROUP BY MONTH(Date_MM_DD_YYYY)
ORDER BY month_of_flight;


-- Average departure delay by airline
SELECT
    Carrier_Code AS airline,
    AVG(Departure_delay_Minutes) AS avg_delay
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
GROUP BY Carrier_Code
ORDER BY avg_delay DESC;


-- Average departure delay by time of day
SELECT
    CASE
        WHEN Scheduled_departure_time BETWEEN '00:00:00.0000000' AND '05:59:59.0000000'
            THEN 'Early Morning'
        WHEN Scheduled_departure_time BETWEEN '06:00:00.0000000' AND '11:59:59.0000000'
            THEN 'Morning'
        WHEN Scheduled_departure_time BETWEEN '12:00:00.0000000' AND '17:59:59.0000000'
            THEN 'Afternoon'
        ELSE 'Night'
    END AS time_of_day,
    AVG(Departure_delay_Minutes) AS avg_delay
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
GROUP BY
    CASE
        WHEN Scheduled_departure_time BETWEEN '00:00:00.0000000' AND '05:59:59.0000000'
            THEN 'Early Morning'
        WHEN Scheduled_departure_time BETWEEN '06:00:00.0000000' AND '11:59:59.0000000'
            THEN 'Morning'
        WHEN Scheduled_departure_time BETWEEN '12:00:00.0000000' AND '17:59:59.0000000'
            THEN 'Afternoon'
        ELSE 'Night'
    END
ORDER BY avg_delay;
