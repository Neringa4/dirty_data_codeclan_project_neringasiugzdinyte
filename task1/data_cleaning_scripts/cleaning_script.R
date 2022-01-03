library(tidyverse)


raw_decathlon_data <- readr::read_rds("raw_data/decathlon.rds")


clean_names_decathlon <- raw_decathlon_data %>% 
  janitor::clean_names() %>% 
  rename_with(str_remove, pattern = "x")


athlete_names_decathlon <- clean_names_decathlon %>% 
  rownames_to_column("athlete_name")
  
