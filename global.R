


########################################
# Load the libraries
########################################

library(tidyverse)
library(readxl)
library(lubridate)



########################################
# Variable definitions
########################################


# 1 - Model input
# These are the variables that should be coming from the user
input_demand <- 5000
input_product <- "salad"
input_localisation <- "bw" # Might need to have a gps coordinates here
input_time <- "december"
input_production_mode <- "organic"


# 2 - Model variables
# these are the variables we would like to estimate with the model

production_locations <- NULL
production_total <- NULL
environmental_impact <- NULL
production_times <- NULL


# 3 - Data tables
# These are the tables loaded from the database
annual_production <- NULL
localities <- NULL
products <- NULL
production_modes <- NULL
impacts <- NULL
production_impacts <- NULL

# 4 - Other variables

months <- c("january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december")




########################################
# Load the database tables
########################################

# TODO -> THIS IS FROM AN EXCEL SHEET. SHOUDL BE FROM A REAL DATABASE

annual_production <- read_xlsx("www/sample_database.xlsx", sheet="annual_production")
localities <- read_xlsx("www/sample_database.xlsx", sheet="localities")
products <- read_xlsx("www/sample_database.xlsx", sheet="products")
production_modes <- read_xlsx("www/sample_database.xlsx", sheet="production_modes")
impacts <- read_xlsx("www/sample_database.xlsx", sheet="impacts")
production_impacts <- read_xlsx("www/sample_database.xlsx", sheet="production_impacts")



########################################
# Process the datatables
########################################

# Create a data table that is easier to use by merging the needed information
production_data <<- merge(annual_production, products, by.x = "id_product", by.y = "id") %>% 
  mutate(name_product = name) %>% 
  select(-name)

# merge with the localities
production_data <<- merge(production_data, localities, by.x = "id_province", by.y = "id") %>% 
  mutate(name_locality = name)%>% 
  select(-name)

# merge with the production modes
production_data <<- merge(production_data, production_modes, by.x = "id_mode", by.y = "id") %>% 
  mutate(name_mode = name) %>% 
  select(-name)


# Get the monthly production
# ATTENTION HYPOTHESE -> LA PRODUCTION EST EQUIVALENTE SUR LES MOIS DE RECOLTE
production_data <<- production_data %>% 
  mutate(monthly_quantity = quantity / (stop_harvest - start_harvest))







