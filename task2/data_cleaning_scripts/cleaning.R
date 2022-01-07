library(tidyverse)

raw_cake_data <- read_csv(here::here("raw_data/cake-ingredients-1961.csv"))
raw_ingredient_code <- read_csv(here::here("raw_data/cake_ingredient_code.csv"))


# Cleaned the column names and pivoted the tibble for easier analysis

cake_data_pivoted <- raw_cake_data %>% 
  rename("cake" = "Cake") %>% 
  pivot_longer(-cake, names_to = "ingredients_code", values_to = "amount")


# Moved "cup" from the ingredient column into measure column for sour cream.

ingredient_code <- raw_ingredient_code %>% 
  mutate(ingredient = str_replace(ingredient, "Sour cream cup", "Sour cream"),
         measure = coalesce(measure, "cup"))


# Joined the ingredient code to the data, to see full ingredient names and the 
# type of measurement used for each.

cake_data_joined <- cake_data_pivoted %>% 
  left_join(ingredient_code, by = c("ingredients_code" = "code"))


# I dropped the ingredient code column and removed NAs, because I am only 
# interested in ingredients that are used for each cake.
clean_cake_data <- cake_data_joined %>% 
  select(cake, ingredient, amount, measure) %>% 
  filter(!is.na(amount))


write_csv(clean_cake_data, "clean_data/cake_data.csv")
