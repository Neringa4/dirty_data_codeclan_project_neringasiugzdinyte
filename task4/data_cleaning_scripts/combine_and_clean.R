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


all_candy_data_fix_country <- all_candy_data_fix_age %>% 
  mutate(country = str_to_title(country)) %>% 
  mutate(country = case_when(
    str_detect(country, "[0-9]+") ~ NA_character_,
    country == "America" ~ NA_character_,
    country == "Europe" ~ NA_character_,
    country == "Earth" ~ NA_character_,
    country == "Cascadia" ~ NA_character_,
    country == "A" ~ NA_character_,
    country == "Can" ~ NA_character_,
    country == "Canae" ~ NA_character_,
    country == "Ud" ~ NA_character_,
    country == "Atlantis" ~ NA_character_,
    country == "Soviet Canuckistan" ~ NA_character_,
    country == "N. America" ~ NA_character_,
    country == "Narnia" ~ NA_character_,
    country == "I Don't Know Anymore" ~ NA_character_,
    country == "Insanity Lately" ~ NA_character_,
    country == "Fear And Loathing" ~ NA_character_,
    country == "A Tropical Island South Of The Equator" ~ NA_character_,
    country == "Neverland" ~ NA_character_,
    country == "This One" ~ NA_character_,
    country == "There Isn't One For Old Men" ~ NA_character_,
    country == "One Of The Best Ones" ~ NA_character_,
    country == "Somewhere" ~ NA_character_,
    country == "God's Country" ~ NA_character_,
    country == "See Above" ~ NA_character_,
    country == "The Republic Of Cascadia" ~ NA_character_,
    country == "Not The Usa Or Canada" ~ NA_character_,
    country == "Denial" ~ NA_character_,
    TRUE ~ country)) %>% 
  mutate(
    country = str_replace(country, "(?i).*states.*", "United States of America"),
    country = str_replace(country, "(?i)^usa.*", "United States of America"),
    country = str_replace(country, "(?i).*united s.*", "United States of America"),
    country = str_replace(country, "(?i)^murica$", "United States of America"),
    country = str_replace(country, "(?i)^uk$", "United Kingdom"),
    country = str_replace(country, "(?i)^uae$", "United Arab Emirates"),
    country = str_replace(country, "(?i)^england", "United Kingdom"),
    country = str_replace(country, "(?i)^u.s.a.", "United States of America"),
    country = str_replace(country, "(?i)^us of a$", "United States of America"),
    country = str_replace(country, "(?i)^north carolina$", "United States of America"),
    country = str_replace(country, "(?i)^u s$", "United States of America"),
    country = str_replace(country, "(?i)^u.s.$", "United States of America"),
    country = str_replace(country, "(?i)^u.k.$", "United States of America"),
    country = str_replace(country, "(?i)^ussa$", "United States of America"),
    country = str_replace(country, "(?i)^us$", "United States of America"),
    country = str_replace(country, "(?i)'Merica$", "United States of America"),
    country = str_replace(country, "(?i)^Pittsburgh$", "United States of America"),
    country = str_replace(country, "(?i)^New York$", "United States of America"),
    country = str_replace(country, "(?i)^Trumpistan$", "United States of America"),
    country = str_replace(country, "(?i)^California$", "United States of America"),
    country = str_replace(country, "(?i)^Canada`$", "Canada"),
    country = str_replace(country, "(?i)^Scotland$", "United Kingdom"),
    country = str_replace(country, "(?i)^Ahem....Amerca$", "United States of America"),
    country = str_replace(country, "(?i)^New Jersey$", "United States of America"),
    country = str_replace(country, "(?i)^The Netherlands$", "Netherlands"),
    country = str_replace(country, "(?i)^Endland$", "United Kingdom"),
    country = str_replace(country, "(?i)^Murrika$", "United States of America"),
    country = str_replace(country, "(?i)^Alaska$", "United States of America"),
    country = str_replace(country, "(?i)^U S A$", "United States of America"),
    country = str_replace(country, "(?i)^The Best One - Usa$", "United States of America"),
    country = str_replace(country, "(?i)^España$", "Spain"),
    country = str_replace(country, "(?i)^The Yoo Ess Of Aaayyyyyy$", "United States of America"), 
    country = str_replace(country, "(?i)^United Kindom$", "United Kingdom"),
    country = str_replace(country, "(?i)^Eua$", "United States of America"),
    country = str_replace(country, "(?i)^Merica$", "United States of America"),
    country = str_replace(country, "(?i)^Korea$", "South Korea"),
    country = str_replace(country, "Sub-Canadian North America... United States of America", "United States of America"))


all_candy_data_pivoted <- all_candy_data_fix_country %>% 
  pivot_longer(x100_grand_bar:peanut_butter_bars,
               names_to = "candy_name", 
               values_to = "rating")


write_csv(all_candy_data_pivoted, "clean_data/all_candy_data.csv")
