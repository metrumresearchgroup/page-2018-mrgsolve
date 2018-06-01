rm(list = ls())

source("src/global.R")
source("src/functions.R")
library(dplyr)
library(mrgsolve)
library(ggplot2)


##' Characterize the variability in day-5 azithromycin 
##' concentrations after the standard dosing of 
##' 500 mg x1 then 250 mg daily x4
##' 
##' Make a plot showing median and 95% prediction interval
##' 
##' Start with no variability in weight; see what is the CV
##' of day-5 trough.  Then try adding some variability 
##' in WT (normal with mean 70 and 25% CV)
##' 
