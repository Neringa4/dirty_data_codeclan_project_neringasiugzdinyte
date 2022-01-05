library(tidyverse)

raw_cake_data <- read_csv("raw_data/cake-ingredients-1961.csv")
ingredient_code <- read_csv("raw_data/cake_ingredient_code.csv")


cake_data_pivoted <- raw_cake_data %>% 
  rename("cake" = "Cake") %>% 
  pivot_longer(-cake, names_to = "ingredients", values_to = "amount")


cake_data_joined <- cake_data_pivoted %>% 
  left_join(ingredient_code, by = c("ingredients" = "code"))


clean_cake_data <- cake_data_joined %>% 
  select(cake, ingredient, amount, measure) %>% 
  filter(!is.na(amount))


write_csv(clean_cake_data, "clean_data/cake_data.csv")
