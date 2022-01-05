library(tidyverse)

source("data_cleaning_scripts/column_name_clenaing_and_selection.R")

all_candy_data <- bind_rows(candy_data_2017, 
                            candy_data_2016, 
                            candy_data_2015) %>% 
  select(year, going_out, gender, age, country, everything())


