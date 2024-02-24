bitcoin <- read_csv("Bitcoin.csv")
bitcoin

bitcoin <- clean_names(bitcoin)
bitcoin

bitcoin$date = dmy(bitcoin$date)
bitcoin

bitcoin$year <- year(bitcoin$date)
bitcoin

bitcoin_year <- bitcoin %>% group_by(year) %>% 
  summarise(avg_rating = mean(close, na.rm = TRUE))
bitcoin_year

ggplot(bitcoin_year, aes(x = year, y = avg_rating, color = year)) +
  geom_line() +
  geom_point(size = 2) +
  labs(x = "Years", y = "Prices") +
  ggtitle("Line Plot of Years vs. Prices of Bitcoin") + theme_clean()

bitcoin_date <- bitcoin %>%
  group_by(date) %>%
  mutate(close = close)
bitcoin_date

ggplot(bitcoin_date, aes(x = date, y = close, color = close)) +
  geom_point() +
  labs(x = "Date", y = "Rate of Bitcoin everyday") +
  ggtitle("Scatter Plot of Pages vs. Ratings")

mean_close<- mean(bitcoin$close) #mean of close
mean_close

median_close<- median(bitcoin$close) #median of close
median_close

sd_close<- sd(bitcoin$close) #standard deviation of close
sd_close

min_close<- min(bitcoin$close) #minimum close
min_close

max_close<- max(bitcoin$close) #maximum close
max_close

summary_close<- summary(bitcoin$close) #summary statistics for close
summary_close
