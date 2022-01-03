library(tidyverse)


raw_decathlon_data <- readr::read_rds("raw_data/decathlon.rds")


clean_names_decathlon <- raw_decathlon_data %>% 
  janitor::clean_names() %>% 
  rename_with(str_remove, pattern = "x")

