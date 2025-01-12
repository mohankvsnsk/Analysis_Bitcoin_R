## Introduction  

This project analyzes a dataset of Bitcoin prices from 2013 to 2017, including daily opening, closing, highest, and lowest values. Using R programming, the dataset was cleaned, processed, and visualized to uncover historical trends and compute statistical measures. Key packages like `tidyverse`, `janitor`, and `lubridate` were utilized for efficient data manipulation and analysis.

---

## Tasks  

### 1. Data Loading and Cleaning  
- **Data Import**: The dataset was loaded using `read_csv()` from the `tidyverse` package.  
- **Cleaning**: Variable names were cleaned using `clean_names()` from the `janitor` package.  
- **Date Conversion**: The `dmy()` function from the `lubridate` package converted date values into a standard format.  
- **Year Extraction**: A new column, `year`, was added to store the year for each date.

```R
bitcoin <- read_csv("Bitcoin.csv")
bitcoin <- clean_names(bitcoin)
bitcoin$date <- dmy(bitcoin$date)
bitcoin$year <- year(bitcoin$date)
```

---

### 2. Statistical Calculations  
Summary statistics for the `close` variable (daily closing prices):  
- **Mean**: `695.56`  
- **Median**: `447.53`  
- **Standard Deviation**: `800.56`  
- **Minimum**: `68.43`  
- **Maximum**: `4892.01`  

```R
mean_close <- mean(bitcoin$close)
median_close <- median(bitcoin$close)
sd_close <- sd(bitcoin$close)
min_close <- min(bitcoin$close)
max_close <- max(bitcoin$close)
summary_close <- summary(bitcoin$close)
```

---

### 3. Data Subsetting  

#### a. Annual Averages  
Grouped by year, the average closing price of Bitcoin was calculated and stored in a new data frame, `bitcoin_year`.  
```R
bitcoin_year <- bitcoin %>% group_by(year) %>%
  summarise(avg_rating = mean(close, na.rm = TRUE))
```

#### b. Daily Closes  
A new data frame, `bitcoin_date`, grouped by date, duplicated the `close` variable for visualization purposes.  
```R
bitcoin_date <- bitcoin %>% group_by(date) %>%
  mutate(close = close)
```

---

### 4. Data Visualizations  

#### a. Line Plot  
**Title**: "Line Plot of Years vs. Prices of Bitcoin"  
- **X-axis**: Years  
- **Y-axis**: Average closing prices  
- **Purpose**: Visualizes yearly average prices.  

![image](https://github.com/user-attachments/assets/2efe1783-725f-4edd-bca2-6d5f0bc8ea75)


#### b. Scatter Plot  
**Title**: "Scatter Plot of Pages vs. Ratings"  
- **X-axis**: Date  
- **Y-axis**: Daily closing prices  
- **Purpose**: Visualizes daily closing prices with color-coded points.  

![image](https://github.com/user-attachments/assets/c02f13af-ba90-4713-a17f-f9f667122ddc)


---
# Module 3 R Practice

## Introduction
This R script performs comprehensive analysis and statistical testing on Bitcoin data. It includes data cleaning, summary statistics calculation, graphical representation of statistics, and hypothesis testing using one-sample and two-sample t-tests.

---

## Tasks

### 1. Data Loading and Cleaning
- **Reading CSV File:**
  ```R
  bit_df <- read_csv("BitCoin.csv")
  ```
  The dataset contains six columns: `id`, `date`, `open`, `high`, `low`, and `close`. The `date` column is converted from character to date format using the `dmy()` function.

- **Data Preparation:**
  - Converted `date` column to a date format.
  - Extracted `year` and `month` from the `date` column using `lubridate`.

---

### 2. Statistical Calculations
- Calculated summary statistics (`min`, `max`, `mean`, `median`, `sd`) for the columns `open`, `close`, `high`, and `low`.

#### Example Summary Statistics Table (for `open` column):
| min_open | max_open | mean_open | median_open | sd_open |
|----------|----------|-----------|-------------|---------|
| 68.5     | 4901.42  | 693.4974  | 446.89      | 797.3651 |

- Combined statistics for all columns into a summary table:
  | min_open | max_open | mean_open | median_open | sd_open | category |
  |----------|----------|-----------|-------------|---------|----------|
  | 74.6     | 4975.04  | 712.7766  | 452.48      | 825.6228| High     |
  | 65.5     | 4679.53  | 674.3655  | 440.5       | 768.1094| Low      |
  | 68.5     | 4901.42  | 693.4974  | 447.89      | 797.3651| Open     |
  | 68.43    | 4892.01  | 695.5634  | 447.53      | 800.5576| Close    |

---

### 3. Data Visualizations
- Created bar plots to visualize:
  - Median and Standard Deviation (Figure 1)
  - Minimum, Maximum, and Mean (Figure 2)

- Example code snippet for bar plots:

![image](https://github.com/user-attachments/assets/a170509c-5767-4ecb-adf4-b6b55dfdd4d8)


![image](https://github.com/user-attachments/assets/bb68ff75-badd-4634-9c10-f7daa0d0b8c1)


---

### 4. Hypothesis Testing
- Conducted **One-Sample T-Tests**:
  - `open`: Mean is greater than 500 (p-value < 0.05)
  - `close`: No significant difference from 700 (p-value > 0.05)
  - `high`: Mean significantly differs from 800 (p-value < 0.05)
  - `low`: Mean significantly differs from 1000 (p-value < 0.05)

- Conducted **Two-Sample T-Tests**:
  - Paired T-Test (Open vs Close): No significant difference (p-value > 0.05).
  - Independent T-Test (High vs Low): No significant difference (p-value > 0.05).

#### Example T-Test Results:
```R
t_test_open <- t.test(bit_df$open, mu = 500, conf.level = 0.95)
print(t_test_open)
```
**Result:**
- t = 9.7341
- p-value = 1
- Confidence Interval: (-Inf, 726.2132)

---

# Module 5 R Practice

## Introduction
This project conducts an extensive analysis of Bitcoin's historical data. It focuses on:
- Data cleaning and preparation.
- Statistical summaries for key columns ('open,' 'close,' 'high,' and 'low').
- Correlation analysis between attributes.
- Linear regression modeling to explore the relationship between 'open' and 'close' Bitcoin prices.

The analysis is presented with visualizations and detailed statistical insights to enhance data understanding and exploration.

---

## Tasks

### 1. Data Loading and Cleaning
1. **Reading the CSV File**
   - The dataset contains six columns: `id`, `date`, `open`, `high`, `low`, and `close`.
   - Column types were verified and formatted as needed.

2. **Cleaning the Dataset**
   - Converted the `date` column to a proper date format using `lubridate::dmy()`.
   - Extracted `year` and `month` from the `date` column for temporal analysis.

### 2. Statistical Analysis
**Summary Statistics for Key Columns:**
- Calculated minimum, maximum, mean, median, and standard deviation for `open`, `close`, `high`, and `low` columns.
- Combined results into a single summary table with the following metrics:
  
  | Category | Min   | Max    | Mean   | Median | Std. Dev |
  |----------|-------|--------|--------|--------|----------|
  | High     | 74.6  | 4975.0 | 713.0  | 452.0  | 826.0    |
  | Low      | 65.5  | 4679.0 | 674.0  | 440.0  | 768.0    |
  | Open     | 68.5  | 4901.4 | 693.5  | 446.9  | 797.4    |
  | Close    | 68.4  | 4892.0 | 696.0  | 448.0  | 801.0    |

### 3. Correlation Analysis & Visualization
- **Correlation Matrix:**
  - Strong linear relationships were observed among the `open`, `close`, `high`, and `low` columns (correlation values close to 1).
  - `Month` exhibited weak correlations with price-related columns (values close to 0).

- **Correlation Plot:**
  - Visualized using `ggcorrplot`, which clearly represented these relationships with labeled circular charts.

![image](https://github.com/user-attachments/assets/f345eec1-fc11-4469-b425-277683705b54)


### 4. Regression Analysis
- **Linear Regression Model:**
  - Dependent Variable: `close`
  - Independent Variable: `open`

- **Model Results:**
  - Equation: `close = 0.780690 + 1.001853 * open`
  - R-squared: `0.9957` (indicating a very strong model fit).
  - Residual Standard Error: `52.39`
  - Coefficients:
    - `open`: Significant (p < 2e-16) with a coefficient of `1.001853`.
    - Intercept: Not statistically significant (p = 0.652).

---
## Conclusion  

This project demonstrates how R can be utilized for efficient data processing and analysis. The cleaned Bitcoin dataset was analyzed to compute key statistics and visualized to reveal historical trends. The study provided insights into Bitcoin's price movements, offering a foundation for further analysis or predictive modeling.  
The analysis included:
- Data cleaning and summary statistics for key financial columns.
- Visualizations highlighting central tendencies and variations.
- Hypothesis testing revealed:
  - Significant deviations for `open`, `high`, and `low` columns from specified values.
  - No significant differences between `open` and `close` or `high` and `low` prices.
1. **Data Cleaning:** The dataset was successfully cleaned and prepared for analysis.
2. **Statistical Insights:** Summary statistics provided detailed insights into the distribution of Bitcoin prices.
3. **Correlation Analysis:** Highlighted strong relationships among key variables.
4. **Regression Analysis:** Demonstrated a highly predictive relationship between `open` and `close` prices.
5. **Visualizations:** Enhanced understanding of data trends and relationships.

This comprehensive analysis provides valuable insights into Bitcoin's historical price data, making it a robust starting point for further predictive modeling and exploration.
---

## Citations  

1. Holtz, Y. (n.d.). [Add text labels with ggplot2](https://r-graph-gallery.com/275-add-text-labels-with-ggplot2.html).  

2. GeeksforGeeks. (2021, December 16). [Calculate the average variance and standard deviation in R programming](https://www.geeksforgeeks.org/calculate-the-average-variance-and-standard-deviation-in-r-programming/).

3. Banerjee, A., Chitnis, U. B., Jadhav, S., Bhawalkar, J. S., & Chaudhury, S. (2009). Hypothesis testing, type I and type II errors. Industrial Psychiatry Journal, 18(2), 127.
https://doi.org/10.4103/0972-6748.62274

4.Auguié, B. (2019, July 13). Laying out multiple plots on a page.
https://cran.r-project.org/web/packages/egg/vignettes/Ecosystem.html

---  
