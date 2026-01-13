-- tree2_july_delay.sql
-- Purpose: Investigate why July has the highest average departure delay
-- Dataset: BTS On-Time Performance (2019, ORD outbound, delayed flights only)

-- Average departure delay by time of day for July
SELECT
    CASE
        WHEN Scheduled_departure_time BETWEEN '00:00:00.0000000' AND '05:59:59.0000000'
            THEN 'Early Morning (12am–05:59am)'
        WHEN Scheduled_departure_time BETWEEN '06:00:00.0000000' AND '11:59:59.0000000'
            THEN 'Morning (6am–11:59am)'
        WHEN Scheduled_departure_time BETWEEN '12:00:00.0000000' AND '17:59:59.0000000'
            THEN 'Afternoon (12pm–05:59pm)'
        ELSE 'Night (6pm–11:59pm)'
    END AS time_of_day,
    AVG(Departure_delay_Minutes) AS avg_delay
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
WHERE MONTH(Date_MM_DD_YYYY) = 7
GROUP BY
    CASE
        WHEN Scheduled_departure_time BETWEEN '00:00:00.0000000' AND '05:59:59.0000000'
            THEN 'Early Morning (12am–05:59am)'
        WHEN Scheduled_departure_time BETWEEN '06:00:00.0000000' AND '11:59:59.0000000'
            THEN 'Morning (6am–11:59am)'
        WHEN Scheduled_departure_time BETWEEN '12:00:00.0000000' AND '17:59:59.0000000'
            THEN 'Afternoon (12pm–05:59pm)'
        ELSE 'Night (6pm–11:59pm)'
    END;


-- Average departure delay by time of day for June
-- Used as a comparison month due to its high number of delayed flights
SELECT
    CASE
        WHEN Scheduled_departure_time BETWEEN '00:00:00.0000000' AND '05:59:59.0000000'
            THEN 'Early Morning (12am–05:59am)'
        WHEN Scheduled_departure_time BETWEEN '06:00:00.0000000' AND '11:59:59.0000000'
            THEN 'Morning (6am–11:59am)'
        WHEN Scheduled_departure_time BETWEEN '12:00:00.0000000' AND '17:59:59.0000000'
            THEN 'Afternoon (12pm–05:59pm)'
        ELSE 'Night (6pm–11:59pm)'
    END AS time_of_day,
    AVG(Departure_delay_Minutes) AS avg_delay
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
WHERE MONTH(Date_MM_DD_YYYY) = 6
GROUP BY
    CASE
        WHEN Scheduled_departure_time BETWEEN '00:00:00.0000000' AND '05:59:59.0000000'
            THEN 'Early Morning (12am–05:59am)'
        WHEN Scheduled_departure_time BETWEEN '06:00:00.0000000' AND '11:59:59.0000000'
            THEN 'Morning (6am–11:59am)'
        WHEN Scheduled_departure_time BETWEEN '12:00:00.0000000' AND '17:59:59.0000000'
            THEN 'Afternoon (12pm–05:59pm)'
        ELSE 'Night (6pm–11:59pm)'
    END;


-- Average delay minutes by delay reason for June and July
-- Used to compare whether delay composition differs between the two months
SELECT
    MONTH(Date_MM_DD_YYYY) AS month_of_flight,
    AVG(Delay_Weather_Minutes) AS weather_delay,
    AVG(Delay_Carrier_Minutes) AS carrier_delay,
    AVG(Delay_Late_Aircraft_Arrival_Minutes) AS late_aircraft_delay,
    AVG(Delay_National_Aviation_System_Minutes) AS nas_delay
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
WHERE MONTH(Date_MM_DD_YYYY) IN (6, 7)
GROUP BY MONTH(Date_MM_DD_YYYY);


-- Total number of delayed flights by month
-- Used to compare delayed-flight volume against average delay severity
SELECT
    MONTH(Date_MM_DD_YYYY) AS month_of_flight,
    COUNT(*) AS no_of_delayed_flights
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
GROUP BY MONTH(Date_MM_DD_YYYY)
ORDER BY month_of_flight;


-- Total number of flights by month
-- Used to assess whether overall flight volume contributes to higher average delays
SELECT
    MONTH(Date_MM_DD_YYYY) AS month_of_flight,
    COUNT(*) AS no_of_total_flights
FROM [AirlineDelaysDB].[dbo].[Airline Data CSV]
GROUP BY MONTH(Date_MM_DD_YYYY)
ORDER BY month_of_flight;

