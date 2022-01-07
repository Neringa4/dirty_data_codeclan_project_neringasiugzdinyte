library(tidyverse)

raw_ship_data <- readxl::read_xls("raw_data/seabirds.xls", sheet = 1)
raw_bird_data <- readxl::read_xls("raw_data/seabirds.xls", sheet = 2)


# I only needed coordinates from this data set

ship_data <- raw_ship_data %>% 
  janitor::clean_names() %>% 
  select(record_id, lat, long)


# Only needed the names of the species and their count in each observation. I 
# also removed instances where no birds were recorded.

bird_data <- raw_bird_data %>% 
  janitor::clean_names() %>% 
  rename_with(str_remove, pattern = "_taxon_age_sex_plumage_phase") %>% 
  select(record_id, species_common_name, species_scientific_name, 
         species_abbreviation, count) %>% 
  filter(species_common_name != "[NO BIRDS RECORDED]")


# Joined the 2 data sets for analysis

all_data <- bird_data %>% 
  left_join(ship_data, by = "record_id") %>% 
  select(-record_id)


write_csv(all_data, "clean_data/bird_data.csv")

