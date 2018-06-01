
source("src/global.R")
library(dplyr)
library(mrgsolve)
rm(list = ls())


##' - Model: model/gcsf.cpp
##' 
##' - Simulate 2.5, 5, and 10 mcg/kg assuming 50, 70, 90 kg individual
##' - Simulate 2.5, 5, and 10 mcg/kg assuming log(WT) ~ N(log(80),0.1)

##' - Do daily SC dosing x 7d

mod <- mread_cache()






