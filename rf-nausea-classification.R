# Code for producing results presented in Table 3 and Fig. 4 in the manuscript
# set working directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# required libraries and reproducible package versioning
library(dplyr)
library(ggplot2)
library(caret)
library(e1071)
library(randomForest)
library(randomForestExplainer)
library(pROC)
# library(groundhog)
# groundhog.day="2021-10-20"
# pkgs = c('dplyr', 'ggplot2', 'e1071', 'caret', 'randomForest', 
#          'randomForestExplainer', 'pROC')
# groundhog.library(pkgs, groundhog.day, tolerate.R.version='4.1.2')

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

# read the data (change the file manually)
# read non-noisy data
# dat <- read.csv("dat.csv")
# read noisy data
 dat <- read.csv("dat-noise_SNR-20dB.csv")
# dat <- read.csv("dat-noise_SNR-10dB.csv")
# dat <- read.csv("dat-noise_SNR+0dB.csv")
# dat <- read.csv("dat-noise_SNR+10dB.csv")
# dat <- read.csv("dat-noise_SNR+20dB.csv")

# renaming parameters
dat <- rename(dat, CS = cs)
dat <- rename(dat, SDV = sdv)
dat <- rename(dat, RMS = rms)
dat <- rename(dat, DF = df)
dat <- rename(dat, MagDF = magDf)

# This code creates a classifier on original data or on noisy data parameters.
# Only one file (containing original or one noisy set) should be uploaded

# non-noisy params
# params <- select(dat, !(c(X, id)))

# noisy params, change if reading noisy params
 params <- select(dat, !(c(X, id, snrEGG)))

# set params as factors
dat$nausea_onset <- factor(dat$nausea_onset)
params$nausea_onset <- factor(dat$nausea_onset)

#### Classification ####

# design output and inputs of the classifier
classifier1 <- nausea_onset ~ RMS + median + MagDF +
  DF + CS + SDV + SampEntT_m2 + SampEntT_m3 + SampEntT_m4 + 
  SampEntP_m2 + SampEntP_m3+ SampEntP_m4 + 
  SpectEnt + Autocorr + SD1 + SD2 + SDEGG

# creating test set - not used for validation
set.seed(100)
set <- createDataPartition(params$nausea_onset, p = 0.75, list = FALSE)
TrainSet <- params[set,]
TestSet <- params[-set,]

# leave-one-out cross-validation
trControl <- trainControl(method = "LOOCV",
                          savePredictions = T)

# train the model
model1 <- train(classifier1, data = TrainSet, method = 'rf',
                metric = "Accuracy", trControl = trControl)

# assess classifier
training_predict1 <- predict(model1, TrainSet, type = "raw")
table(training_predict1, TrainSet$nausea_onset)

test_predict1 <- predict(model1, TestSet, type = "raw")
table(test_predict1, TestSet$nausea_onset)

confMat1 <- table(TrainSet$nausea_onset, training_predict1)
print(round(100*sum(diag(confMat1))/sum(confMat1),2))
confMat11 <- table(test_predict1, TestSet$nausea_onset)
print(round(100*sum(diag(confMat11))/sum(confMat11),2))

# get more info about classifier performance on test set
d = confusionMatrix(test_predict1, TestSet$nausea_onset)
confusionMatrix(test_predict1, TestSet$nausea_onset)
print(d$byClass[5])
print(d$byClass[6])
model1

# ROC and AUC for test set
roc_score <- roc(as.numeric(TestSet$nausea_onset), as.numeric(test_predict1)) # AUC score
roc_score
# change title for each run, if you want to save figures
title <- "ROC, SNR = 17 dB"
# title <- "ROC, SNR = 7 dB"
# title <- "ROC, SNR = -3 dB"
# title <- "ROC, SNR = -13 dB"
# title <- "ROC, SNR = -23 dB"
plot(roc_score, main = title)

# ROC and AUC for training set
ROC <- plot.roc(model1$pred$obs, model1$pred$rowIndex)
coords(ROC, "b", ret = "t", best.method = "youden")
ROC$auc

# plot importances
#ggplot(caret::varImp(model1)) + theme_light() +
#  theme(text = element_text(size = 20)) + 
#  xlim(c("Autocorr", "SampEntP_m3", "CS", "DF", "SampEntP_m4"))
#ggsave("dat.jpg", dpi=300)

#ggplot(caret::varImp(model1)) + theme_light() +
#  theme(text = element_text(size = 20)) + 
#  xlim(c("SampEntT_m3", "SampEntP_m2", "SpectEnt", "SampEntP_m3", "SampEntP_m4"))
#ggsave("dat-noise_SNR-20dB.jpg", dpi=300)

#ggplot(caret::varImp(model1)) + theme_light() +
#  theme(text = element_text(size = 20)) + 
#  xlim(c("MagDF", "SpectEnt", "SampEntP_m3", "SampEntP_m2", "median"))
#ggsave("dat-noise_SNR-10dB.jpg", dpi=300)

#ggplot(caret::varImp(model1)) + theme_light() +
#  theme(text = element_text(size = 20)) + 
#  xlim(c("SampEntP_m2", "SampEntP_m3", "DF", "SampEntP_m4", "median"))
#ggsave("dat-noise_SNR+0dB.jpg", dpi=300)

#ggplot(caret::varImp(model1)) + theme_light() +
#  theme(text = element_text(size = 20)) + 
#  xlim(c("SampEntP_m2", "SpectEnt", "SampEntP_m3", "DF", "SampEntP_m4"))
#ggsave("dat-noise_SNR+10dB.jpg", dpi=300)

#ggplot(caret::varImp(model1)) + theme_light() +
#  theme(text = element_text(size = 20)) + 
#  xlim(c("SampEntT_m2", "SampEntP_m2", "SampEntP_m4", "SampEntT_m3", "SampEntP_m3"))
#ggsave("dat-noise_SNR+20dB.jpg", dpi=300)
