source("src/global.R")
library(dplyr)
library(mrgsolve)
rm(list = ls())


##' Here is a PBPK model for DDI between a statin and CsA
mod <- mread("yoshikado", "model") %>% update(delta = 0.1, end = 12)
see(mod)

##' A single pitavastatin dose
pit <- ev(amt = 30, cmt = 1)


##' A single pitavastatin dose 30 min after CsA
csa <- ev(amt = 2000, cmt = 2)
ddi <- seq(csa, wait = 0.5, pit)


##' Find the ikiu parameter value
##' Generate a sensitivity analysis on this parameter, 
##' varying with uniform distribution between 0.1 and 5 times
##' the nominal value; do this with an idata set
##' 
##' - Make a plot
##' - Summarize the variability in Cmax
##' - Summarize the variability in AUC
##' 

