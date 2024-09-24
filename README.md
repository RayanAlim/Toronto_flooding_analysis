# Toronto Basement Flooding Analysis 

## Overview

This analysis looks at basement flooding and sewage service requests across Toronto wards from 2005 to 2023.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Toronto Open Data Portal.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data which include:

  - `00-Simulate_data.R`: Script to simulate marriage license data
  - `01-download_data.R`: Script to download data from Open Data Toronto
  - `02-data_cleaning.R`: Script to clean  the data
  - `03-test_data.R`: Tests to sanity check the data


## Statement on LLM usage

No aspects of the code were written with the help of the auto-complete tool or LLMs.

## Requirements
- R (version 4.0 or higher)