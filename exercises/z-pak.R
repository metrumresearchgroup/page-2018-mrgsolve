
source("src/global.R")
library(dplyr)
library(mrgsolve)
rm(list = ls())

##' You've been sick for the last two weeks and can't take it any more. 
##' Finally, you decide to go to the doctor, who gives you a diagnosis of 
##' walking pneumonia. When you get home with your azithromycin 
##' prescription, you start wondering about the directions: take 
##' 500 mg as a single dose on Day 1, followed by 250 mg once daily 
##' on Days 2 through 5.

##' Explore this regimen using the following model:
  
##' - Model name: `azithro`
##' - Model location: `model`

##' Simulate out to at least day 14 to see what is happening.

mod <- mread("", "") %>% zero_re




