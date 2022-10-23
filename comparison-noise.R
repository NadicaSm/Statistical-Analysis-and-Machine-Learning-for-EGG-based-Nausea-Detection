# Code for producing results presented in Tables 2 and 5 in the manuscript
# set working directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# required libraries and reproducible package versioning
library(dplyr)
library(effsize)
# library(groundhog)
# groundhog.day="2021-06-18"
# pkgs = c('dplyr', 'effsize', tolerate.R.version='4.1.2')
# groundhog.library(pkgs, groundhog.day)

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

# read data (both files should be read, EGG-derived parameters from original data 
# and from semisynthetic data)
# non-noisy
 dat <- read.csv("dat.csv") 
# noisy (uncomment for different SNRs)
 datN <- read.csv("dat-noise_SNR-20dB.csv")
# datN <- read.csv("dat-noise_SNR-10dB.csv")
# datN <- read.csv("dat-noise_SNR+0dB.csv")
# datN <- read.csv("dat-noise_SNR+10dB.csv")
# datN <- read.csv("dat-noise_SNR+20dB.csv")

# mean SNR of noisy data
mean(datN$snrEGG)

# test normality of parameters (for p-value > 0.05 normality can be assumed)
# compare noisy and non-noisy parameters (paired t-test for normally distributed
# data and paired Wilcoxon's Signed-Ranks test for non-normally distributed data)
# For effect size, Cohen's d is used for normally distributed data and Cliff's
# delta for non-normally distributed data.

# Automatic checks for normality is added only in cases where it has been detected
# at least once.

shapiro.test(dat$rms)
shapiro.test(datN$rms)
wilcox.test(dat$rms, datN$rms, paired = T)
cliff.delta(datN$rms, dat$rms)
# nausea and non-nausea
wilcox.test(dat$rms ~ dat$nausea_onset, paired = F)
cliff.delta(dat$rms ~ dat$nausea_onset)
wilcox.test(datN$rms ~ datN$nausea_onset, paired = F)
cliff.delta(datN$rms ~ datN$nausea_onset)

shapiro.test(dat$median)
shapiro.test(datN$median)
p.median <- shapiro.test(dat$median)$p
pN.median <- shapiro.test(datN$median)$p
if (pN.median > 0.05 && p.median > 0.05){
  t.test(dat$median, datN$median, paired = T)
  cohen.d(dat$median, datN$median)
} else{
  wilcox.test(dat$median, datN$median, paired = T)
  cliff.delta(dat$median, datN$median)
}
# nausea and non-nausea
if (p.median > 0.05) {
  t.test(dat$median ~ dat$nausea_onset)
  cohen.d(dat$median ~ dat$nausea_onset)
} else {
  wilcox.test(dat$median ~ dat$nausea_onset, paired = F)
  cliff.delta(dat$median ~ dat$nausea_onset)
}
if (pN.median > 0.05) {
  t.test(datN$median ~ datN$nausea_onset)
  cohen.d(datN$median ~ datN$nausea_onset)
} else {
  wilcox.test(datN$median ~ datN$nausea_onset, paired = F)
  cliff.delta(datN$median ~ datN$nausea_onset)
}
  
shapiro.test(dat$magDf)
shapiro.test(datN$magDf)
wilcox.test(dat$magDf, datN$magDf, paired = T)
cliff.delta(dat$magDf, datN$magDf)
# nausea and non-nausea
wilcox.test(dat$magDf ~ dat$nausea_onset, paired = F)
cliff.delta(dat$magDf ~ dat$nausea_onset)
wilcox.test(datN$magDf ~ datN$nausea_onset, paired = F)
cliff.delta(datN$magDf ~ datN$nausea_onset)

shapiro.test(dat$df)
shapiro.test(datN$df)
wilcox.test(dat$df, datN$df, paired = T)
cliff.delta(dat$df, datN$df)
# nausea and non-nausea
wilcox.test(dat$df ~ dat$nausea_onset, paired = F)
cliff.delta(dat$df ~ dat$nausea_onset)
wilcox.test(datN$df ~ datN$nausea_onset, paired = F)
cliff.delta(datN$df ~ datN$nausea_onset)

shapiro.test(dat$cs)
shapiro.test(datN$cs)
wilcox.test(dat$cs, datN$cs, paired = T)
cliff.delta(dat$cs, datN$cs)
# nausea and non-nausea
wilcox.test(dat$cs ~ dat$nausea_onset, paired = F)
cliff.delta(dat$cs ~ dat$nausea_onset)
wilcox.test(datN$cs ~ datN$nausea_onset, paired = F)
cliff.delta(datN$cs ~ datN$nausea_onset)

shapiro.test(dat$sdv)
shapiro.test(datN$sdv)
wilcox.test(dat$sdv, datN$sdv, paired = T)
cliff.delta(dat$sdv, datN$sdv)
# nausea and non-nausea
t.test(dat$sdv ~ dat$nausea_onset)
cohen.d(dat$sdv ~ dat$nausea_onset)
wilcox.test(datN$sdv ~ datN$nausea_onset, paired = F)
cliff.delta(datN$sdv ~ datN$nausea_onset)

shapiro.test(dat$SampEntT_m2)
shapiro.test(datN$SampEntT_m2)
wilcox.test(dat$SampEntT_m2, datN$SampEntT_m2, paired = T)
cliff.delta(dat$SampEntT_m2, datN$SampEntT_m2)
# nausea and non-nausea
wilcox.test(dat$SampEntT_m2 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SampEntT_m2 ~ dat$nausea_onset)
wilcox.test(datN$SampEntT_m2 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SampEntT_m2 ~ datN$nausea_onset)

shapiro.test(dat$SampEntT_m3)
shapiro.test(datN$SampEntT_m3)
wilcox.test(dat$SampEntT_m3, datN$SampEntT_m3, paired = T)
cliff.delta(dat$SampEntT_m3, datN$SampEntT_m3)
# nausea and non-nausea
wilcox.test(dat$SampEntT_m3 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SampEntT_m3 ~ dat$nausea_onset)
wilcox.test(datN$SampEntT_m3 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SampEntT_m3 ~ datN$nausea_onset)

shapiro.test(dat$SampEntT_m4)
shapiro.test(datN$SampEntT_m4)
wilcox.test(dat$SampEntT_m4, datN$SampEntT_m4, paired = T)
cliff.delta(dat$SampEntT_m4, datN$SampEntT_m4)
# nausea and non-nausea
wilcox.test(dat$SampEntT_m4 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SampEntT_m4 ~ dat$nausea_onset)
wilcox.test(datN$SampEntT_m4 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SampEntT_m4 ~ datN$nausea_onset)

shapiro.test(dat$SampEntP_m2)
shapiro.test(datN$SampEntP_m2)
wilcox.test(dat$SampEntP_m2, datN$SampEntP_m2, paired = T)
cliff.delta(dat$SampEntP_m2, datN$SampEntP_m2)
# nausea and non-nausea
wilcox.test(dat$SampEntP_m2 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SampEntP_m2 ~ dat$nausea_onset)
wilcox.test(datN$SampEntP_m2 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SampEntP_m2 ~ datN$nausea_onset)

shapiro.test(dat$SampEntP_m3)
shapiro.test(datN$SampEntP_m3)
wilcox.test(dat$SampEntP_m3, datN$SampEntP_m3, paired = T)
cliff.delta(dat$SampEntP_m3, datN$SampEntP_m3)
# nausea and non-nausea
wilcox.test(dat$SampEntP_m3 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SampEntP_m3 ~ dat$nausea_onset)
wilcox.test(datN$SampEntP_m3 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SampEntP_m3 ~ datN$nausea_onset)

shapiro.test(dat$SampEntP_m4)
shapiro.test(datN$SampEntP_m4)
wilcox.test(dat$SampEntP_m4, datN$SampEntP_m4, paired = T)
cliff.delta(dat$SampEntP_m4, datN$SampEntP_m4)
# nausea and non-nausea
wilcox.test(dat$SampEntP_m4 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SampEntP_m4 ~ dat$nausea_onset)
wilcox.test(datN$SampEntP_m4 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SampEntP_m4 ~ datN$nausea_onset)

shapiro.test(dat$SpectEnt)
shapiro.test(datN$SpectEnt)
pN.SpectEnt <- shapiro.test(datN$SpectEnt)$p
wilcox.test(dat$SpectEnt, datN$SpectEnt, paired = T)
cliff.delta(dat$SpectEnt, datN$SpectEnt)
# nausea and non-nausea
wilcox.test(dat$SpectEnt ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SpectEnt ~ dat$nausea_onset)
if (pN.SpectEnt > 0.05) {
  t.test(datN$SpectEnt ~ datN$nausea_onset)
  cohen.d(datN$SpectEnt ~ datN$nausea_onset)
} else {
  wilcox.test(datN$SpectEnt ~ datN$nausea_onset, paired = F)
  cliff.delta(datN$SpectEnt ~ datN$nausea_onset)
}

shapiro.test(dat$Autocorr)
shapiro.test(datN$Autocorr)
wilcox.test(dat$Autocorr, datN$Autocorr, paired = T)
cliff.delta(dat$Autocorr, datN$Autocorr)
# nausea and non-nausea
wilcox.test(dat$Autocorr ~ dat$nausea_onset, paired = F)
cliff.delta(dat$Autocorr ~ dat$nausea_onset)
wilcox.test(datN$Autocorr ~ datN$nausea_onset, paired = F)
cliff.delta(datN$Autocorr ~ datN$nausea_onset)

shapiro.test(dat$SD1)
shapiro.test(datN$SD1)
wilcox.test(dat$SD1, datN$SD1, paired = T)
cliff.delta(dat$SD1, datN$SD1)
# nausea and non-nausea
wilcox.test(dat$SD1 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SD1 ~ dat$nausea_onset)
wilcox.test(datN$SD1 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SD1 ~ datN$nausea_onset)

shapiro.test(dat$SD2)
shapiro.test(datN$SD2)
wilcox.test(dat$SD2, datN$SD2, paired = T)
cliff.delta(dat$SD2, datN$SD2)
# nausea and non-nausea
wilcox.test(dat$SD2 ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SD2 ~ dat$nausea_onset)
wilcox.test(datN$SD2 ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SD2 ~ datN$nausea_onset)

shapiro.test(dat$SDEGG)
shapiro.test(datN$SDEGG)
wilcox.test(dat$SDEGG, datN$SDEGG, paired = T)
cliff.delta(dat$SDEGG, datN$SDEGG)
# nausea and non-nausea
wilcox.test(dat$SDEGG ~ dat$nausea_onset, paired = F)
cliff.delta(dat$SDEGG ~ dat$nausea_onset)
wilcox.test(datN$SDEGG ~ datN$nausea_onset, paired = F)
cliff.delta(datN$SDEGG ~ datN$nausea_onset)
