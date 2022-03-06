library(tidyverse)
library(here)
trips_2013_2019 <- read_csv(here("data_output", "trips_2013_2019.csv"))
trips_2020_2021 <- read_csv(here("data_output", "trips_2020_2021.csv")) 
#user types in 2013-2019
head(distinct(trips_2013_2019, user_type, .keep_all = TRUE)) #"Customer", "Subscriber", "Dependent"
head(distinct(trips_2020_2021, usert_type, .keep_all = FALSE)) # "member", "casual"

t_2013_2019 <- trips_2013_2019 %>% 
  add_column(rideable_type = NA, .after = "trip_id") %>% 
  select(-bike_id)

t_2020_2021 <- trips_2020_2021 %>% 
  mutate(trip_duration = stop_time - start_time, .after = "stop_time")%>%
  add_column(gender = NA) %>% 
  add_column(birth_year = NA) %>% 
  select(-start_lat, -start_lng, -end_lat, -end_lng) %>% 
  rename(user_type = usert_type)

# what kind of user is a dependent? dependent does have gender or birthyear info. does that imply they are members/subscribers
View(filter(t_2013_2019, user_type == "Dependent"))

t_2013_2019$user_type[t_2013_2019$user_type == "Subscriber"] <- "memeber"  
t_2013_2019$user_type[t_2013_2019$user_type == "Customer"] <- "casual"

#exclude user type "dependent"
t_2013_2019 <-t_2013_2019 %>% 
  filter(user_type != "Dependent")

#combine 2013-2019
t_2013_2021 <- rbind(t_2013_2019, t_2020_2021)
library(here)
write.csv(t_2013_2021, file = "data_output/trips_clean_2013_2021_4.csv", row.names = FALSE)
###############################Statistics#############################################################################

# bar chart Average trip duration
# bar chart count of trips using each rideable type
library(ggplot2)
#need to remove short trips for consistency
t_2013_2021 <-
  t_2013_2021 %>% 
  filter(trip_duration >= 60)

# check to make sure no short trips
short_trips <-
  t_2013_2021 %>% 
  filter(trip_duration < 60)

# correct misspelling "memeber"
t_2013_2021 <-
  t_2013_2021 %>% 
  mutate(user_type = if_else(user_type == "memeber", "member", user_type))

# total number of casual riders and total number of members
user_count <- t_2013_2021 %>% 
  group_by(user_type) %>% 
  count(user_type)

#number of rides
ggplot(t_2013_2021, aes(x = user_type, fill= user_type)) + geom_bar() + 
  labs(title = "Number of rides by casual users vs. memebrs",
       subtitle = "2013-2021") +
  xlab("User type") +
  ylab("Number of Rides")+
  annotate('text', x=1, y=8700000, label = "9,091,567")+
  annotate('text', x=2, y=20000000, label = "20,471,239")

t_2013_2021$user_type[t_2013_2021$user_type == "Subscriber"] <- "memeber"  
t_2013_2021$user_type[t_2013_2021$user_type == "Customer"] <- "casual"

#number of rides by year
library(lubridate)
yearly_rides <- t_2013_2021 %>% 
  group_by(user_type, year=year(start_time)) %>% 
  summarise(total = n()/1000000)
ggplot(yearly_rides, aes(x=year, y=total, color=user_type)) +
  geom_point() +
  geom_smooth(alpha = 0, se = FALSE)+
  scale_x_discrete(limits=c(2013:2021))+
  ylab('Number of rides in millions')+
  xlab('Year')+
  labs(title = 'Annual number of casual rides vs memebr rides')
  
write.csv(yearly_rides, file ="data_output/yearly_rides.csv", row.names = FALSE)

#average trip duration in minutes
avg_trip_duration <- t_2013_2021 %>% 
  group_by(user_type) %>% 
  summarise(mean = mean(trip_duration/60)) 
ggplot(avg_trip_duration, aes(x= user_type, y= as.numeric(mean), fill = user_type)) +
  geom_col() +
  xlab("User type")+
  ylab("Average trip duration in minutes")+
  annotate('text', x=1, y= 30, label = '~ 38 minutes')+
  annotate('text', x=2, y=10, label ='~ 13 minutes')+
  labs(title = 'Average trip duration of casual riders vs. members',
       subtitle ='2013-2021')
 

#average ride length for users by day of week (line)
daily_rides_length <-t_2013_2021 %>% 
  group_by(user_type, day = wday(start_time, label = TRUE)) %>% 
  summarise(mean= mean(trip_duration/60))
ggplot(daily_rides_length, aes(x=day, y = mean)) +
  geom_col(aes(fill=user_type))+
  ylab('Average trip duration in minutes')+
  labs(title= 'Average trip duration by weekday')
  
#average ride length each year for each user type (line)
annual_avg_ride_length <- t_2013_2021 %>% 
  mutate(start_year = year(start_time)) %>% 
  group_by(user_type, start_year) %>% 
  summarise(mean = mean(trip_duration/60))
ggplot(annual_avg_ride_length, aes(x=start_year, y= mean, fill=user_type)) +
  geom_col()+
  labs(title = 'Average trip duration each year', subtitle='2013-2021')+
  xlab("Year")+
  ylab("Average trip duration in minutes")+
  scale_x_discrete(
    limits= c(2013:2021)
  ) +
  facet_wrap('user_type')+
  theme(axis.text.x = element_text(angle =30))

total_trips <- count(t_2013_2021)

#number of rides for users by day of week
daily_rides_num <- t_2013_2021 %>% 
  mutate(start_day = wday(start_time, label = TRUE)) %>% 
  group_by(user_type, start_day) %>% 
  summarise(num_rides = n())

weekday_vs_weekends <- daily_rides_num %>% 
  mutate(weekday = (start_day > "Sun" & start_day < "Sat")
    ) %>% 
  group_by(user_type, weekday) %>% 
  summarise(rides_by_day = sum(num_rides))



ggplot(weekday_vs_weekends, aes(x="", y=rides_by_day, fill = weekday))+
  geom_bar(stat="identity", width = 1)+
  facet_wrap('user_type')+
  theme_void()

ggplot(daily_rides_num, aes(x=start_day, y=num_rides, fill = user_type)) + 
  geom_col() +
  facet_wrap('user_type')+
  xlab('Day')+
  ylab('Number of rides')+
  labs(title = 'Number of rides each day of the week', subtitle= '2013-2021')
#number of rides for users by month
monthly_rides_num <- t_2013_2021 %>% 
  mutate(month_start = month(start_time,label = TRUE)) %>% 
  group_by(user_type, month_start) %>% 
  summarise(num_rides = n())
ggplot(monthly_rides_num, aes(x=month_start, y=num_rides, fill = user_type)) + 
  geom_col() +
  facet_wrap('user_type')+
  xlab('Month')+
  ylab('Number of rides')+
  labs(title = 'Number of rides each month', subtitle= '2013-2021')+
  theme(axis.text.x = element_text(angle = 45))
#number of rides for users by hour per each day
hourly_rides_num <- t_2013_2021 %>% 
  mutate(start_hour = hour(start_time)) %>% 
  mutate(start_day = wday(start_time, label = TRUE)) %>% 
  group_by(user_type, start_day, start_hour) %>% 
  summarise(num_rides = n())
ggplot(hourly_rides_num, aes(x=start_hour, y=num_rides, fill = user_type)) + 
  geom_col() +
  facet_grid(rows = vars(start_day), cols = vars(user_type))+
  xlab('Hour')+
  ylab('Number of rides')+
  labs(title = 'Number of rides starting each hour of the day', subtitle= '2013-2021')+
  theme(axis.text.x = element_text(angle = 90),
        axis.text.y = element_blank())

## rideable type
rideable_type <- t_2020_2021 %>% 
  group_by(user_type, rideable_type) %>% 
  summarise(share_of_rides = n())

ggplot(rideable_type, aes(x="",y=share_of_rides,fill=rideable_type))+
  geom_col(position = 'dodge')+
  facet_wrap('user_type')

#group data by start station
trip_by_station <- t_2013_2021 %>% 
  group_by(user_type, from_station_name) %>% 
  summarise(num_rides = n())
write.csv(trip_by_station, file="trip_by_station.csv", row.names =FALSE)

