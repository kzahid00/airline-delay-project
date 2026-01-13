-- tree1_delta_delay.sql
-- Purpose: Explore why Delta Airlines has a higher average departure delay than peer airlines
-- Dataset: BTS On-Time Performance (2019, ORD outbound, delayed flights only)

-- Average departure delay for Delta Airlines by time of day
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
WHERE Carrier_Code = 'DL'
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


-- Average delay minutes by delay reason for each airline
-- Used to assess whether Delta experiences a unique delay composition
SELECT
    Carrier_Code,
    AVG(Delay_Weather_Minutes) AS weather_delay,
    AVG(Delay_Carrier_Minutes) AS carrier_delay,
    AVG(Delay_Late_Aircraft_Arrival_Minutes) AS late_aircraft_delay,
    AVG(Delay_National_Aviation_System_Minutes) AS nas_delay
FROM [AirlineDelaysDB].[dbo].[delayed_flights_only]
GROUP BY Carrier_Code;


-- Average departure delay by airline and time of day
-- Used to compare delay severity patterns across carriers throughout the day
SELECT
    Carrier_Code,
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
    Carrier_Code,
    CASE
        WHEN Scheduled_departure_time BETWEEN '00:00:00.0000000' AND '05:59:59.0000000'
            THEN 'Early Morning'
        WHEN Scheduled_departure_time BETWEEN '06:00:00.0000000' AND '11:59:59.0000000'
            THEN 'Morning'
        WHEN Scheduled_departure_time BETWEEN '12:00:00.0000000' AND '17:59:59.0000000'
            THEN 'Afternoon'
        ELSE 'Night'
    END;
