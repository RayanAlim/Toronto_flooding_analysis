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


#### Save data - Basement Flooding info ####
raw_flood_data <- show_package("2241becb-39a5-48fb-9d7a-b65b7a557dce") %>% 
  list_package_resources() %>% 
  filter(row_number() == 1) %>% 
  get_resource()

basement_flooding_by_ward <- raw_flood_data[[1]]


write_csv(basement_flooding_by_ward, here("data", "raw_data", "raw_flood_data.csv"))


#### Save data- Wards shapefile (Code chunk directly from TO Open Data Site) %>% 

# get package
package <- show_package("5e7a8234-f805-43ac-820f-03d7c360b588")

# get all resources for this package
resources <- list_package_resources("5e7a8234-f805-43ac-820f-03d7c360b588")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
wards_shape_file <- filter(datastore_resources, row_number()==1) %>% get_resource()


write_csv(wards_shape_file, here("data", "raw_data", "wards_shape_file.csv"))
