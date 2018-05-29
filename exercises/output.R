source("src/global.R")
library(dplyr)
library(mrgsolve)
rm(list = ls())

##; Run the following code and check the output

mod <- mread_cache("azithro", "model")

out <- 
  mod %>% 
  ev(amt = 500) %>%
  mrgsim(end = 24, delta = 4)


out

class(out)

head(out)

out$CP

as.data.frame(out)

as_data_frame(out)

filter(out, time==12)

mutate(out, success = TRUE) %>% class
