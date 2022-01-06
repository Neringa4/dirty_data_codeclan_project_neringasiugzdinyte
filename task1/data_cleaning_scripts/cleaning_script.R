library(tidyverse)


raw_decathlon_data <- read_rds("raw_data/decathlon.rds")



# Cleaned column names

clean_names_decathlon <- raw_decathlon_data %>% 
  janitor::clean_names()



# Transferred row names into a column for easier analysis, since it is 
# part of the data and cleaned athlete names.

athlete_names_decathlon <- clean_names_decathlon %>% 
  rownames_to_column("athlete_name") %>% 
  mutate(athlete_name = str_to_title(athlete_name)) %>% 
  mutate(athlete_name = str_replace(athlete_name, "Mcmullen", "McMullen"))



write_csv(athlete_names_dacathlon, "clean_data/decathlon_data.csv")
