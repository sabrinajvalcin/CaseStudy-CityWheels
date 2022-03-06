library(tidyverse)
library(here)
#Cleaning stations data
  #upload data frames
  #select appropriate columns
  #rename columns
st_2013 <- read_csv(here("2013_data", "Divvy_Stations_Trips_2013", "Divvy_Stations_2013.csv")) %>% 
  select(id, name, latitude, longitude, dpcapacity, "online date") %>% 
  rename(online_date = "online date")
st_2014_q1q2 <- read_xlsx(here("2014_data", "Divvy_Stations_Trips_2014_Q1Q2", "Divvy_Stations_2014-Q1Q2.xlsx")) %>% 
  select(id, name, latitude, longitude, dpcapacity, "online date") %>% 
  rename(online_date = "online date") 
st_2014_q3q4 <- read_csv(here("2014_data", "Divvy_Stations_Trips_2014_Q3Q4", "Divvy_Stations_2014-Q3Q4.csv")) %>% 
  select(id, name, latitude, longitude, dpcapacity, dateCreated) %>% 
  rename(online_date = dateCreated)
st_2015 <- read_csv(here("2015_data", "Divvy_Trips_2015-Q1Q2", "Divvy_Stations_2015.csv")) %>% 
  select(id, name, latitude, longitude, dpcapacity) %>% 
  add_column(online_date = NA)
st_2016_q1q2 <- read_csv(here("2016_data", "Divvy_Trips_2016_Q1Q2", "Divvy_Stations_2016_Q1Q2.csv"))
st_2016_q3 <- read_csv(here("2016_data", "Divvy_Trips_2016_Q3Q4", "Divvy_Stations_2016_Q3.csv"))
st_2016_q4 <- read_csv(here("2016_data", "Divvy_Trips_2016_Q3Q4", "Divvy_Stations_2016_Q4.csv"))
st_2017_q1q2 <- read_csv(here("2017_data", "Divvy_Trips_2017_Q1Q2", "Divvy_Stations_2017_Q1Q2.csv")) %>% 
  select(id, name, latitude, longitude, dpcapacity, online_date)
st_2017_q3q4 <- read_csv(here("2017_data", "Divvy_Trips_2017_Q3Q4", "Divvy_Stations_2017_Q3Q4.csv")) %>% 
  select(id, name, latitude, longitude, dpcapacity, online_date)
#combine data frames to create one table of all stations
all_stations <- rbind(st_2013, st_2014_q1q2, st_2014_q3q4, st_2015, st_2016_q1q2,
                      st_2016_q3, st_2016_q4, st_2017_q1q2, st_2017_q3q4)

#remove duplicate rows with same station id
library(dplyr)
all_distinct_stations <- all_stations %>% 
  distinct(id, .keep_all = TRUE)

##Cleaning trips data
  #upload data frames
  #select appropriate columns
  #rename columns
tr_2013 <- read_csv(here("all_trips", "2013_trips", "Divvy_Trips_2013.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthday)

tr_2014_q1q2 <- read_csv(here("all_trips", "2014_trips", "Divvy_Trips_2014_Q1Q2.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) 

tr_2014_q3_07 <- read_csv(here("all_trips", "2014_trips", "Divvy_Trips_2014-Q3-07.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2014_q3_0809 <- read_csv(here("all_trips", "2014_trips", "Divvy_Trips_2014-Q3-0809.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2014_q4 <- read_csv(here("all_trips", "2014_trips", "Divvy_Trips_2014-Q4.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)

tr_2015_q1 <- read_csv(here("all_trips", "2015_trips", "Divvy_Trips_2015-Q1.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2015_q2 <- read_csv(here("all_trips", "2015_trips", "Divvy_Trips_2015-Q2.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2015_07 <- read_csv(here("all_trips", "2015_trips", "Divvy_Trips_2015_07.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2015_08 <- read_csv(here("all_trips", "2015_trips", "Divvy_Trips_2015_08.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2015_09 <- read_csv(here("all_trips", "2015_trips", "Divvy_Trips_2015_09.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2015_q4 <- read_csv(here("all_trips", "2015_trips", "Divvy_Trips_2015_Q4.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)

tr_2016_q1 <- read_csv(here("all_trips", "2016_trips", "Divvy_Trips_2016_Q1.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2016_04 <- read_csv(here("all_trips", "2016_trips", "Divvy_Trips_2016_04.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2016_05 <- read_csv(here("all_trips", "2016_trips", "Divvy_Trips_2016_05.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2016_06 <- read_csv(here("all_trips", "2016_trips", "Divvy_Trips_2016_06.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2016_q3 <- read_csv(here("all_trips", "2016_trips", "Divvy_Trips_2016_Q3.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)
tr_2016_q4 <- read_csv(here("all_trips", "2016_trips", "Divvy_Trips_2016_Q4.csv")) %>% 
  rename(start_time = starttime, stop_time = stoptime, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear)

###combine trips from 2014-2016 and change date time format
tr_2014_2016 <- rbind(tr_2014_q1q2, tr_2014_q3_07, tr_2014_q3_0809, tr_2014_q4,
                      tr_2015_q1, tr_2015_q2, tr_2015_07, tr_2015_08, tr_2015_09,
                      tr_2015_q4, tr_2016_q1, tr_2016_04, tr_2016_05, tr_2016_06,
                      tr_2016_q3, tr_2016_q4) %>% 
  mutate(start_time = strptime(start_time, format = "%m/%d/%Y %H:%M")) %>% 
  mutate(stop_time = strptime(stop_time, format = "%m/%d/%Y %H:%M"))

tr_2017_q1 <- read_csv(here("all_trips", "2017_trips", "Divvy_Trips_2017_Q1.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
tr_2017_q2 <- read_csv(here("all_trips", "2017_trips", "Divvy_Trips_2017_Q2.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year) 
tr_2017_q3 <- read_csv(here("all_trips", "2017_trips", "Divvy_Trips_2017_Q3.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)  
tr_2017_q4 <- read_csv(here("all_trips", "2017_trips", "Divvy_Trips_2017_Q4.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
### combine quarterly 2017 data into a single table
all_2017 <- rbind(tr_2017_q1,tr_2017_q2, tr_2017_q3) %>% 
  mutate(start_time = strptime(start_time, format = "%m/%d/%Y %H:%M:%S")) %>% 
  mutate(stop_time = strptime(stop_time, format = "%m/%d/%Y %H:%M:%S"))
  

#import 2018 and 2019 data tables with correct column names in the correct order
tr_2018_q1 <- read_csv(here("all_trips", "2018_trips", "Divvy_Trips_2018_Q1.csv")) %>% 
  rename(trip_id = "01 - Rental Details Rental ID", start_time = "01 - Rental Details Local Start Time",
         stop_time = "01 - Rental Details Local End Time", bike_id = "01 - Rental Details Bike ID",
         trip_duration = "01 - Rental Details Duration In Seconds Uncapped", from_station_id = "03 - Rental Start Station ID",
         from_station_name = "03 - Rental Start Station Name", to_station_id = "02 - Rental End Station ID",
         to_station_name = "02 - Rental End Station Name", user_type = "User Type", gender = "Member Gender",
         birth_year = "05 - Member Details Member Birthday Year") %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
tr_2018_q2 <- read_csv(here("all_trips", "2018_trips", "Divvy_Trips_2018_Q2.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
tr_2018_q3 <- read_csv(here("all_trips", "2018_trips", "Divvy_Trips_2018_Q3.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
tr_2018_q4 <- read_csv(here("all_trips", "2018_trips", "Divvy_Trips_2018_Q4.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)

tr_2019_q1 <- read_csv(here("all_trips", "2019_trips", "Divvy_Trips_2019_Q1.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
tr_2019_q2 <- read_csv(here("all_trips", "2019_trips", "Divvy_Trips_2019_Q2.csv")) %>% 
  rename(trip_id = "01 - Rental Details Rental ID", start_time = "01 - Rental Details Local Start Time",
         stop_time = "01 - Rental Details Local End Time", bike_id = "01 - Rental Details Bike ID",
         trip_duration = "01 - Rental Details Duration In Seconds Uncapped", from_station_id = "03 - Rental Start Station ID",
         from_station_name = "03 - Rental Start Station Name", to_station_id = "02 - Rental End Station ID",
         to_station_name = "02 - Rental End Station Name", user_type = "User Type", gender = "Member Gender",
         birth_year = "05 - Member Details Member Birthday Year") %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
tr_2019_q3 <- read_csv(here("all_trips", "2019_trips", "Divvy_Trips_2019_Q3.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)
tr_2019_q4 <- read_csv(here("all_trips", "2019_trips", "Divvy_Trips_2019_Q4.csv")) %>% 
  rename(stop_time = end_time, trip_duration = tripduration,
         bike_id =bikeid, user_type = usertype, birth_year = birthyear) %>% 
  select(trip_id, start_time, stop_time, bike_id, trip_duration, from_station_name,
         to_station_name, from_station_id, to_station_id, user_type, gender, birth_year)

#combine 2013-2019 trips into one data table
tr_2013_2019 <- rbind(tr_2013, tr_2014_2016, all_2017, tr_2018_q1, tr_2018_q2,
                      tr_2018_q3, tr_2018_q4, tr_2019_q1, tr_2019_q2, tr_2019_q3,
                      tr_2019_q4 )
#upload 2020 trips data
tr_2020_q1 <- read_csv(here("all_trips", "2020_trips", "Divvy_Trips_2020_Q1.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_04 <- read_csv(here("all_trips", "2020_trips", "202004-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_05 <- read_csv(here("all_trips", "2020_trips", "202005-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_06 <- read_csv(here("all_trips", "2020_trips", "202006-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")  
tr_2020_07 <- read_csv(here("all_trips", "2020_trips", "202007-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_08 <- read_csv(here("all_trips", "2020_trips", "202008-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_09 <- read_csv(here("all_trips", "2020_trips", "202009-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_10 <- read_csv(here("all_trips", "2020_trips", "202010-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_11 <- read_csv(here("all_trips", "2020_trips", "202011-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2020_12 <- read_csv(here("all_trips", "2020_trips", "202012-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")

tr_2021_01 <- read_csv(here("all_trips", "2021_trips", "202101-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_02 <- read_csv(here("all_trips", "2021_trips", "202102-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_03 <- read_csv(here("all_trips", "2021_trips", "202103-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_04 <- read_csv(here("all_trips", "2021_trips", "202104-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_05 <- read_csv(here("all_trips", "2021_trips", "202105-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_06 <- read_csv(here("all_trips", "2021_trips", "202106-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_07 <- read_csv(here("all_trips", "2021_trips", "202107-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_08 <- read_csv(here("all_trips", "2021_trips", "202108-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_09 <- read_csv(here("all_trips", "2021_trips", "202109-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_10 <- read_csv(here("all_trips", "2021_trips", "202110-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_11 <- read_csv(here("all_trips", "2021_trips", "202111-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")
tr_2021_12 <- read_csv(here("all_trips", "2021_trips", "202112-divvy-tripdata.csv")) %>%
  rename(trip_id = "ride_id", start_time = "started_at", stop_time = "ended_at",
         from_station_name = "start_station_name", from_station_id = "start_station_id",
         to_station_name = "end_station_name", to_station_id = "end_station_id", usert_type = "member_casual")

 #combine 2020-2021 trips into a single table
tr_2020_2021 <- rbind(tr_2020_q1, tr_2020_04, tr_2020_05, tr_2020_06, tr_2020_07,
                      tr_2020_08, tr_2020_09, tr_2020_10, tr_2020_11, tr_2020_12,
                      tr_2021_01, tr_2021_02, tr_2021_03, tr_2021_04, tr_2021_05,
                      tr_2021_06, tr_2021_07, tr_2021_08, tr_2021_09, tr_2021_10,
                      tr_2021_11, tr_2021_12)
#export data
write.csv(tr_2020_2021, file = "data_output/trips_2020_2021.csv", row.names = FALSE)
write.csv(tr_2013_2019, file = "data_output/trips_2013_2019.csv", row.names = FALSE)
write.csv(all_distinct_stations, file = "data_output/stations.csv", row.names = FALSE)
