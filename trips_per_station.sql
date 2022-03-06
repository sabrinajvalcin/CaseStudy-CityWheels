-- create city bikes database with trips and stations tables

CREATE DATABASE `CityBikes`;
USE CityBikes;
SELECT  * FROM stations;
SELECT COUNT(trip_id) FROM trips;
SELECT user_type, from_station_name,latitude, longitude, num_rides 
FROM trips_per_station ts LEFT JOIN stations ON ts.from_station_name = stations.name
WHERE latitude IS NOT NULL
ORDER BY num_rides ASC;

-- this query finds the total number of trips, use result when calculating percent of rides from a given station
SELECT SUM(num_rides)
FROM trips_per_station ts LEFT JOIN stations ON ts.from_station_name = stations.name
WHERE latitude IS NOT NULL AND user_type = "member";

-- this query return a table with the "share" of rides from each station for casual users
SELECT user_type, from_station_name, latitude, longitude, (num_rides/7242179)*100 AS share
FROM trips_per_station ts LEFT JOIN stations ON ts.from_station_name = stations.name
WHERE latitude IS NOT NULL AND user_type = "casual"
ORDER BY share DESC;

-- -- this query return a table with the "share" of rides from each station for members
SELECT user_type, from_station_name,latitude, longitude, (num_rides/17059663)*100 AS share
FROM trips_per_station ts LEFT JOIN stations ON ts.from_station_name = stations.name
WHERE latitude IS NOT NULL AND user_type = "member"
ORDER BY share DESC;

