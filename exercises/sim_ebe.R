source("src/global.R")
library(tidyverse)
library(mrgsolve)

patab <- read_table("data/meropenem/patab", skip = 1)

patab <- distinct(patab, .keep_all = TRUE)

head(patab)

mod <- mread_cache("pk2", modlib())

inventory(mod, patab)

patab <- rename(patab, V3 = V2, V2 = V1)

inventory(mod,patab)

data <- read_csv("data/Simulated_DatasetMeropenem.csv", na = '.')

head(data)

data <- filter(data, EVID==1) %>% mutate(DUR = round(AMT/RATE,1), DOSE = AMT)

data <- mutate(data, II = 8, ADDL = 11, CMT = "CENT")

count(data,CMT,AMT,RATE,DUR)

dosing <- left_join(data, patab, by = "ID")

tg <- tgrid(0,24,0.25) + 3*24

out <- 
  mod %>% 
  data_set(dosing) %>%
  carry_out(DOSE,DUR) %>%
  mrgsim(tgrid = tg, obsonly = TRUE) %>% 
  as.data.frame

ggplot(out, aes(TIME,CP, group = ID)) + 
  facet_wrap(DUR~DOSE) + geom_line()

