#### Preamble ####
# Purpose: Cleans the raw flood data obtained from the Toronto Open Data Portal into analysis data
# Author: Rayan Awad Alim
# Date: 24 September 2024
# Contact: rayan.alim@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to download datsets by running script `01-download_data.R`
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(tidyr)
library(here)

#### Clean data- Basement flood data ####
flood_raw_data <-
  read_csv(here("data", "raw_data", "raw_flood_data.csv"), 
           col_types = cols(.default = "c"))

# remove unnecessary rows
flood_data_clean <- flood_raw_data[-1,]

# set correct column names
colnames(flood_data_clean) <- flood_raw_data[1,]

flood_data_clean <- slice(flood_data_clean, 1:(n() - 23))

names(flood_data_clean)[1] <- "Ward"

data_long <- flood_data_clean %>%
  pivot_longer(cols = starts_with("20"), 
               names_to = "Year", 
               values_to = "Service_Requests") %>%
  filter(str_detect(Year, "^\\d+$")) %>%  #filter out the non-numeric year values
  mutate(Year = as.integer(Year),  
         Service_Requests = as.integer(Service_Requests), 
         Ward = as.integer(Ward))  


#Save cleaned flood data only: 
write_csv(data_long, "data/analysis_data/clean_flood_data.csv")

#### Clean data- Wards shapefile ####

# Load the raw data with explicit column types
shape_raw_data <- read_csv(here("data", "raw_data", "wards_shape_file.csv"), 
                           col_types = cols(
                             `_id` = col_double(),
                             AREA_SHORT_CODE = col_character(),
                             geometry = col_character()
                           ))

# Drop unnecessary columns from the shapefile data
clean_shape_data <- shape_raw_data %>%
  select(
    -AREA_ID, -DATE_EFFECTIVE, -DATE_EXPIRY, -AREA_ATTR_ID, -AREA_TYPE_ID, 
    -PARENT_AREA_ID, -AREA_TYPE, -AREA_CLASS_ID, -AREA_CLASS, -AREA_LONG_CODE, 
    -AREA_NAME, -FEATURE_CODE, -FEATURE_CODE_DESC, -TRANS_ID_CREATE, 
    -TRANS_ID_EXPIRE, -OBJECTID
  )

clean_shape_data <- clean_shape_data %>%
  mutate(`_id` = as.integer(`_id`))

#Save cleaned shape data only: 
write_csv(clean_shape_data, "data/analysis_data/clean_shape_data.csv")

merged_data <- clean_shape_data %>%
  left_join(data_long, by = c("_id" = "Ward"))

#Save cleaned merged data : 
write_csv(merged_data, file= here("data", "analysis_data", "clean_merged_data.csv"))
