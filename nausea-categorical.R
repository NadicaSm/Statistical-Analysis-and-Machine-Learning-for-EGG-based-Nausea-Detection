# Code for producing results presented in Table 6 in the manuscript
# set working directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# required libraries
library(dplyr)
# library(groundhog)
# groundhog.day="2021-10-20"
# pkg = c('dplyr')
# groundhog.library(pkg, groundhog.day, tolerate.R.version='4.1.2')

# R. version
# platform       x86_64-w64-mingw32          
# arch           x86_64                      
# os             mingw32                     
# system         x86_64, mingw32             
# status                                     
# major          4                           
# minor          1.2                         
# year           2021                        
# month          11                          
# day            01                          
# svn rev        81115                       
# language       R                           
# version.string R version 4.1.2 (2021-11-01)
# nickname       Bird Hippie 

# read the data
# read non-noisy data
# dat <- read.csv("dat.csv")
# params <- select(dat, !(c(X, id)))
# read noisy data
# dat <- read.csv("dat-noise_SNR-20dB.csv")
# dat <- read.csv("dat-noise_SNR-10dB.csv")
# dat <- read.csv("dat-noise_SNR+0dB.csv")
# dat <- read.csv("dat-noise_SNR+10dB.csv")
 dat <- read.csv("dat-noise_SNR+20dB.csv")
 params <- select(dat, !(c(X, id)))

# set parameters
dat$nausea_onset <- factor(dat$nausea_onset)
params$nausea_onset <- factor(dat$nausea_onset)

# following parameters should be categorical (level is 10)
plot(dat$SampEntT_m2)
plot(dat$SampEntT_m3)
plot(dat$SampEntT_m4)

# following parameters should not be categorical
plot(dat$SampEntP_m2)
plot(dat$SampEntP_m3)
plot(dat$SampEntP_m4)
plot(dat$SpectEnt)

# change numerical to categorical variables
dat$SampEntT_m2[dat$SampEntT_m2 >= 10] <- "HIGH"
dat$SampEntT_m2[dat$SampEntT_m2 < 10] <- "LOW"
dat$SampEntT_m2 <- as.factor(dat$SampEntT_m2)

dat$SampEntT_m3[dat$SampEntT_m3 >= 10] <- "HIGH"
dat$SampEntT_m3[dat$SampEntT_m3 < 10] <- "LOW"
dat$SampEntT_m3 <- as.factor(dat$SampEntT_m3)

dat$SampEntT_m4[dat$SampEntT_m4 >= 10] <- "HIGH"
dat$SampEntT_m4[dat$SampEntT_m4 < 10] <- "LOW"
dat$SampEntT_m4 <- as.factor(dat$SampEntT_m4)

# chi square test - original data
chisq.test(dat$SampEntT_m2, dat$nausea_onset, simulate.p.value = T)
chisq.test(dat$SampEntT_m3, dat$nausea_onset, simulate.p.value = T)
chisq.test(dat$SampEntT_m4, dat$nausea_onset, simulate.p.value = T)

# count categorical variables
datNausea <- filter(dat, nausea_onset == 1)
datNonNausea <- filter(dat, nausea_onset == 0)

sum(dat$nausea_onset == 1)
sum(dat$nausea_onset == 0)

sum(datNausea$SampEntT_m2 == "HIGH") / sum(dat$nausea_onset == 1)
sum(datNausea$SampEntT_m2 == "LOW") / sum(dat$nausea_onset == 1)
sum(datNonNausea$SampEntT_m2 == "HIGH") / sum(dat$nausea_onset == 0)
sum(datNonNausea$SampEntT_m2 == "LOW") / sum(dat$nausea_onset == 0)

sum(datNausea$SampEntT_m3 == "HIGH") / sum(dat$nausea_onset == 1)
sum(datNausea$SampEntT_m3 == "LOW") / sum(dat$nausea_onset == 1)
sum(datNonNausea$SampEntT_m3 == "HIGH") / sum(dat$nausea_onset == 0)
sum(datNonNausea$SampEntT_m3 == "LOW") / sum(dat$nausea_onset == 0)

sum(datNausea$SampEntT_m4 == "HIGH") / sum(dat$nausea_onset == 1)
sum(datNausea$SampEntT_m4 == "LOW") / sum(dat$nausea_onset == 1)
sum(datNonNausea$SampEntT_m4 == "HIGH") / sum(dat$nausea_onset == 0)
sum(datNonNausea$SampEntT_m4 == "LOW") / sum(dat$nausea_onset == 0)
