#### Preamble ####
# Purpose: Downloads and saves the data from the Toronto Open Data Portal
# Author: Rayan Awad Alim
# Date: 24 September 2024
# Contact: rayan.alim@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)
library(here)


#### Save data ####
raw_flood_data <- show_package("2241becb-39a5-48fb-9d7a-b65b7a557dce") %>% 
  list_package_resources() %>% 
  filter(row_number() == 1) %>% 
  get_resource()

basement_flooding_by_ward <- raw_flood_data[[1]]


write_csv(basement_flooding_by_ward, here("data", "raw_data", "raw_flood_data.csv"))