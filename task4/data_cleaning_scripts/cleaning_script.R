library(tidyverse)


raw_candy_data_2015 <- readxl::read_xlsx("raw_data/boing-boing-candy-2015.xlsx")
raw_candy_data_2016 <- readxl::read_xlsx("raw_data/boing-boing-candy-2016.xlsx")
raw_candy_data_2017 <- readxl::read_xlsx("raw_data/boing-boing-candy-2017.xlsx")



# For each data set, I cleaned the column names and removed all the columns that
# were not needed for analysis. Then I added a column for "year" so that this
# information is not lost during binding.

candy_data_2015 <- raw_candy_data_2015 %>% 
  janitor::clean_names() %>% 
  select(-(97:124)) %>% 
  select(-c(timestamp, cash_or_other_forms_of_legal_tender, dental_paraphenalia,
            generic_brand_acetaminophen, glow_sticks, broken_glow_stick,
            creepy_religious_comics_chick_tracts, healthy_fruit, 
            hugs_actual_physical_hugs, kale_smoothie, lapel_pins, 
            minibags_of_chips, joy_joy_mit_iodine, senior_mints, spotted_dick,
            peterson_brand_sidewalk_chalk, peanut_butter_jars, vicodin, 
            white_bread, whole_wheat_anything 
            )) %>% 
  rename(age = how_old_are_you,
         going_out = are_you_going_actually_going_trick_or_treating_yourself,
         gummy_bears = gummy_bears_straight_up,
         hersheys_kissables = hershey_s_kissables,
         hersheys_milk_chocolate = hershey_s_milk_chocolate,
         jolly_ranchers_bad_flavor = jolly_rancher_bad_flavor,
         licorice_yes_black = licorice,
         now_and_laters = nown_laters,
         toblerone = tolberone_something_or_other,
         peanut_mms = peanut_m_m_s,
         regular_mms = regular_m_ms,
         mint_mms = mint_m_ms,
         chick_o_sticks = chick_o_sticks_we_don_t_know_what_that_is,
         circus_peanuts = those_odd_marshmallow_circus_peanut_things
         ) %>% 
  mutate(year = 2015)
  


candy_data_2016 <- raw_candy_data_2016 %>% 
  janitor::clean_names() %>% 
  select(-(107:123)) %>% 
  select(-c(timestamp, which_state_province_county_do_you_live_in,
            bonkers_the_board_game, broken_glow_stick, 
            cash_or_other_forms_of_legal_tender, chardonnay,
            creepy_religious_comics_chick_tracts, dental_paraphenalia,
            generic_brand_acetaminophen, glow_sticks, healthy_fruit,
            hugs_actual_physical_hugs, joy_joy_mit_iodine, senior_mints,
            kale_smoothie, minibags_of_chips, third_party_m_ms,
            person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes,
            spotted_dick, vicodin, white_bread, whole_wheat_anything
            )) %>% 
  rename(going_out = are_you_going_actually_going_trick_or_treating_yourself,
         gender = your_gender,
         age = how_old_are_you,
         country = which_country_do_you_live_in,
         bonkers = bonkers_the_candy,
         box_o_raisins = boxo_raisins,
         chick_o_sticks = chick_o_sticks_we_don_t_know_what_that_is,
         gummy_bears = gummy_bears_straight_up,
         hersheys_milk_chocolate = hershey_s_milk_chocolate,
         jolly_ranchers_bad_flavor = jolly_rancher_bad_flavor,
         regular_mms = regular_m_ms,
         peanut_mms = peanut_m_m_s,
         blue_mms = blue_m_ms,
         red_mms = red_m_ms, 
         now_and_laters = nown_laters,
         reeses_peanut_butter_cups = reese_s_peanut_butter_cups,
         sour_patch_kids = sourpatch_kids_i_e_abominations_of_nature,
         sweetums = sweetums_a_friend_to_diabetes,
         circus_peanuts = those_odd_marshmallow_circus_peanut_things,
         toblerone = tolberone_something_or_other,
         ) %>% 
  mutate(year = 2016)



candy_data_2017 <- raw_candy_data_2017 %>% 
  janitor::clean_names() %>% 
  rename_with(str_remove, pattern = "q[0-9]+_") %>% 
  select(-(110:120)) %>% 
  select(-c(internal_id, state_province_county_etc, bonkers_the_board_game,
            broken_glow_stick, cash_or_other_forms_of_legal_tender,
            chardonnay, creepy_religious_comics_chick_tracts, 
            dental_paraphenalia, generic_brand_acetaminophen, glow_sticks,
            healthy_fruit, hugs_actual_physical_hugs, joy_joy_mit_iodine,
            senior_mints, kale_smoothie, green_party_m_ms, independent_m_ms,
            abstained_from_m_ming, minibags_of_chips, 
            real_housewives_of_orange_county_season_9_blue_ray, 
            sandwich_sized_bags_filled_with_boo_berry_crunch, spotted_dick,
            vicodin, white_bread, whole_wheat_anything
            )) %>% 
  rename(x100_grand_bar = `100_grand_bar`,
         mary_janes = anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes,
         box_o_raisins = boxo_raisins,
         chick_o_sticks = chick_o_sticks_we_don_t_know_what_that_is,
         gummy_bears = gummy_bears_straight_up,
         hersheys_milk_chocolate = hershey_s_milk_chocolate,
         jolly_ranchers_bad_flavor = jolly_rancher_bad_flavor,
         regular_mms = regular_m_ms,
         peanut_mms = peanut_m_m_s,
         blue_mms = blue_m_ms,
         red_mms = red_m_ms, 
         now_and_laters = nown_laters,
         reeses_peanut_butter_cups = reese_s_peanut_butter_cups,
         sour_patch_kids = sourpatch_kids_i_e_abominations_of_nature,
         sweetums = sweetums_a_friend_to_diabetes,
         circus_peanuts = those_odd_marshmallow_circus_peanut_things,
         toblerone = tolberone_something_or_other,
  ) %>% 
  mutate(year = 2017)



all_candy_data <- bind_rows(candy_data_2017, 
                            candy_data_2016, 
                            candy_data_2015) %>% 
  select(year, going_out, gender, age, country, everything())



# I turned going_out column to logical 

all_candy_data_fix_going_out <- all_candy_data %>% 
  mutate(going_out = if_else(going_out == "Yes",
                             TRUE,
                             if_else(going_out == "No",
                                     FALSE,
                                     NA)))



all_candy_data_fix_gender <- all_candy_data_fix_going_out %>% 
  mutate(gender = na_if(gender, "I'd rather not say"))



# I put an upper limit on age, since there were many invalid entries.

all_candy_data_fix_age <- all_candy_data_fix_gender %>% 
  mutate(age = as.numeric(age),
         age = if_else(age > 125,
                       NaN,
                       age))



# I turned all invalid country entries with NAs and then fixed typos.

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



# I pivoted the tibble for easier analysis

all_candy_data_pivoted <- all_candy_data_fix_country %>% 
  pivot_longer(x100_grand_bar:peanut_butter_bars,
               names_to = "candy_name", 
               values_to = "rating")



write_csv(all_candy_data_pivoted, "clean_data/all_candy_data.csv")