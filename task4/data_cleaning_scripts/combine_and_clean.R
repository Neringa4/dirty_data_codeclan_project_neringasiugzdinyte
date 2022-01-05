library(tidyverse)

source("data_cleaning_scripts/column_name_clenaing_and_selection.R")

all_candy_data <- bind_rows(candy_data_2017, 
                            candy_data_2016, 
                            candy_data_2015) %>% 
  select(year, going_out, gender, age, country, everything())


all_candy_data_fix_going_out <- all_candy_data %>% 
  mutate(going_out = if_else(going_out == "Yes",
                             TRUE,
                             if_else(going_out == "No",
                                     FALSE,
                                     NA)))


all_candy_data_fix_gender <- all_candy_data_fix_going_out %>% 
  mutate(gender = na_if(gender, "I'd rather not say"))


all_candy_data_fix_age <- all_candy_data_fix_gender %>% 
  mutate(age = as.numeric(age),
         age = if_else(age > 125,
                       NaN,
                       age))


