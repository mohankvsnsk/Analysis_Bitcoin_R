#Required Libraries
library(ggplot2)
library(ggthemes)
library(ggeasy)
library(pacman)
library(lubridate)
library(janitor)
library(tidyverse)
library(knitr)
library(gridExtra)
#Reading Csv file
bit_df <-read_csv("BitCoin.csv")
#Cleaning the data set
bit_df <- clean_names(bit_df)
#Basic operations to check data set
str(bit_df)
head(bit_df)
#Converting data types in data set
bit_df$date <- dmy(bit_df$date)
bit_df$year <- year(bit_df$date)
bit_df$month <- month(bit_df$date)
head(bit_df)
#Statistical Analysis
#Open column
open_summary <- bit_df %>%
  summarize(
    min_open = min(open),
    max_open = max(open),
    mean_open = mean(open),
    median_open = median(open),
    sd_open = sd(open)
  )

# Display the summary statistics in a table using kable
kable(open_summary, caption = "Summary Statistics of 'open' column", format = "markdown")
#Close column
close_summary <- bit_df %>%
  summarize(
    min_open = min(close),
    max_open = max(close),
    mean_open = mean(close),
    median_open = median(close),
    sd_open = sd(close)
  )

# Display the summary statistics in a table using kable
kable(close_summary, caption = "Summary Statistics of 'close' column", format = "markdown")
#High column
high_summary <- bit_df %>%
  summarize(
    min_open = min(high),
    max_open = max(high),
    mean_open = mean(high),
    median_open = median(high),
    sd_open = sd(high)
  )

# Display the summary statistics in a table using kable
kable(high_summary, caption = "Summary Statistics of 'high' column", format = "markdown")
#Low column
low_summary <- bit_df %>%
  summarize(
    min_open = min(low),
    max_open = max(low),
    mean_open = mean(low),
    median_open = median(low),
    sd_open = sd(low)
  )

# Display the summary statistics in a table using kable
kable(low_summary, caption = "Summary Statistics of 'low' column", format = "markdown")
# Combining summary statistics into a single table
combined_summary <- bind_rows(
  high_summary %>% mutate(category = "High"),
  low_summary %>% mutate(category = "Low"),
  open_summary %>% mutate(category = "Open"),
  close_summary %>% mutate(category = "Close")
)

combined_summary
#Graph
# Function to create individual plots
create_plot <- function(data, y_var, y_label) {
  plot <- ggplot(data, aes(x = category, y = !!rlang::sym(y_var))) +
    geom_bar(stat = "identity", position = position_dodge(width = 0.7), fill = "skyblue") +
    geom_text(aes(label = round(!!rlang::sym(y_var), 2)), vjust = -0.5, size = 3) +
    labs(title = paste("Summary of", y_label, "for Different Categories"), y = y_label) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  return(plot)
}

# Create individual plots
plot_min_open <- create_plot(combined_summary, "min_open", "Min")
plot_max_open <- create_plot(combined_summary, "max_open", "Max")
plot_mean_open <- create_plot(combined_summary, "mean_open", "Mean")
plot_median_open <- create_plot(combined_summary, "median_open", "Median")
plot_sd_open <- create_plot(combined_summary, "sd_open", "Standard Deviation")

# Combine plots into a single window
grid.arrange(plot_min_open, plot_max_open, plot_mean_open, ncol = 3)
grid.arrange(plot_median_open, plot_sd_open, ncol = 2)
#Hypothesis Testing
summary(bit_df)
#one sample t test

t_test_open <- t.test(bit_df$open, alternative = c("less"), mu = 500, conf.level = 0.95)
t_test_close <- t.test(bit_df$close, alternative = c("greater"), mu = 700, conf.level = 0.95)
t_test_high <- t.test(bit_df$high, mu = 800, conf.level = 0.95)
t_test_low <- t.test(bit_df$low,mu = 1000, conf.level = 0.95)
t_test_open
t_test_close
t_test_high
t_test_low
#two sample t test
# paired t test
# Performing a paired t-test between 'open' and 'close' prices
t_test_paired <- t.test(bit_df$open, bit_df$close, paired = TRUE, conf.level = 0.95)

# Display the test results
print(t_test_paired)

# independent t test
t_test_high_low <- t.test(bit_df$high, bit_df$low, paired = FALSE,conf.level = 0.95)

# Display the test results
print(t_test_high_low)



