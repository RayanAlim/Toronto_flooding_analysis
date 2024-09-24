#### Preamble ####
# Purpose: Cleans the raw flood data obtained from the Toronto Open Data Portal into analysis data
# Author: Rayan Awad Alim
# Date: 24 September 2024
# Contact: rayan.alim@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to download datset by running script `01-donload_data.R`
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(tidyr)
library(here)

#### Clean data ####
data <- read_csv(here("data", "raw_data", "raw_flood_data.csv"))

# remove unnecessary rows
data_clean <- data[-1, ]

# set correct column names
colnames(data_clean) <- data[1, ]

data_clean <- slice(data_clean, 1:(n() - 23))

# year columns to numeric
data_clean <- data_clean %>%
  mutate(across(matches("20[0-9]{2}"), as.numeric))

# reshaping the data into long format
data_long <- data_clean %>%
  pivot_longer(cols = starts_with("20"),
               names_to = "Year",
               values_to = "Service_Requests")

#  year columns to numeric
data_long$Year <- as.numeric(data_long$Year)

#### Save data ####

write_csv(data_long, "data/analysis_data/clean_flood_data.csv")
