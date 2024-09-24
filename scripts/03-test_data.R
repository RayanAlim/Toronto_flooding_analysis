#### Preamble ####
# Purpose: Sanity check our simulated data
# Author: Rayan Awad Alim
# Date: 24 Spetember 2024
# Contact: rayan.alim@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have simulated data from script '00-simulate_data.R'
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(testthat)

data <- read_csv(here("data", "raw_data", "simulated_flood_data.csv"))

#### Test data ####


# Test1: there is year continuity in each ward
year_check <- data %>%
  group_by(Ward) %>%
  summarise(Year_Continuity = all(diff(Year) == 1))

if(all(year_check$Year_Continuity)) {
  cat("Success: All wards have continuous years.\n")
} else {
  cat("Warning: Some wards have missing or non-sequntial years.\n")
}



# Test 2: see if there are any negative service requests
if(any(data$Service_Requests < 0)) {
  cat("Warning: There are negative values in the Service_Requests column.\n")
} else {
  cat("Success: No negative values in the Service_Requests column.\n")
}



# Test 3: check if there are any repeated years within the same ward
repeated_years <- data %>%
  group_by(Ward, Year) %>%
  filter(n() > 1)

if(nrow(repeated_years) > 0) {
  cat("Warning: There are repeated years for some wards.\n")
} else {
  cat("Success: No repeated years detected for any ward.\n")
}