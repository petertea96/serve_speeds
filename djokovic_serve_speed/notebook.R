# -- Djokovic Speed

# -- load libraries
library(dplyr)
library(ggplot2)
library(reshape2)

# ----- # ----- # -----  # -----  # -----  #  -----  # -----  # 
####                GET THE CLEANED DATA                   ####             
# ----- # ----- # -----  # -----  # -----  #  -----  # -----  # 
#--> Get Sackmann speed and play-by-play data
source("~/Documents/Github/serve_speeds/src/collect_speed_data_functions.R")

# collect data from AO 2018 - 2020
djokovic_ao_18 <- get_slam_data('Novak Djokovic',
                                              year = 2018,
                                              tournament = 'ausopen')
djokovic_ao_19 <- get_slam_data('Novak Djokovic',
                                              year = 2019,
                                              tournament = 'ausopen')
djokovic_ao_20 <- get_slam_data('Novak Djokovic',
                                              year = 2020,
                                              tournament = 'ausopen')

# -- Win percentages
djokovic_ao_20 %>%
  group_by(ServeNumber) %>%
  summarise(service_pts = n(),
            service_wins = sum(won_point),
            win_perc = sum(won_point)/n())

djokovic_ao_19 %>%
  group_by(ServeNumber) %>%
  summarise(service_pts = n(),
            service_wins = sum(won_point),
            win_perc = sum(won_point)/n())

table(djokovic_ao_19$match_id)

# -- Plot the Densities
source("~/Documents/Github/serve_speeds/djokovic_serve_speed/src/plot_speed_density.R")

plot_servespeed_density(djokovic_ao_18, 
                        "Novak Djokovic's Serve Speeds \nAustralian Open 2018",
                        tournament = 'ausopen',
                        year = 2018)

plot_servespeed_density(djokovic_ao_19, 
                        "Novak Djokovic's Serve Speeds \nAustralian Open 2019",
                        tournament = 'ausopen',
                        year = 2019)

plot_servespeed_density(djokovic_ao_20, 
                        "Novak Djokovic's Serve Speeds \nAustralian Open 2020",
                        tournament = 'ausopen',
                        year = 2020)

