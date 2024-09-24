#### Preamble ####
# Purpose: Simulates  flood service request data across Toronto wards from 2013-2023
# Author: Rayan Awad Alim
# Date: 24 September 2024
# Contact: rayan.alim@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(304)

# Load required libraries
library(dplyr)
library(tidyr)

wards <- 1:25  # For the 25 Toronto wards
years <- 2013:2023  # years

# Have combo of all years and wards
combinations <- crossing(Ward = wards, Year = years)

# Simulate service requests to ranom value b/w 30 and 250
service_requests <- combinations %>%
  mutate(Service_Requests = sample(30:250, n(), replace = TRUE))

# Save the simulated data
write_csv(service_requests,
          here("data", "raw_data", "simulated_flood_data.csv"))