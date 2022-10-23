# Code for producing results presented in Table 4 in the manuscript
# set working directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# required libraries and reproducible package versioning
library(dplyr)
library(ggplot2)
library(e1071)
library(caret)
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

# read the data
# read non-noisy data (the original data should be read for each run)
dat <- read.csv("dat.csv")
params <- select(dat, !(c(X, id)))
# read noisy data (select one file per one run)
 datN <- read.csv("dat-noise_SNR-20dB.csv")
# datN <- read.csv("dat-noise_SNR-10dB.csv")
# datN <- read.csv("dat-noise_SNR+0dB.csv")
# datN <- read.csv("dat-noise_SNR+10dB.csv")
# datN <- read.csv("dat-noise_SNR+20dB.csv")
paramsN <- select(datN, !(c(X, id, snrEGG)))

# This code creates a classifier on original data and tests them on unseen
# noisy data parameters. Two files (containing original and one noisy set)
# should be uploaded

# set parameters as factors
dat$nausea_onset <- factor(dat$nausea_onset)
params$nausea_onset <- factor(dat$nausea_onset)
datN$nausea_onset <- factor(datN$nausea_onset)
paramsN$nausea_onset <- factor(datN$nausea_onset)

#### Classification ####

# design output and inputs of the classifier
classifier1 <- nausea_onset ~ rms + median + magDf +
  df + cs + sdv + SampEntT_m2 + SampEntT_m3 + SampEntT_m4 + 
  SampEntP_m2 + SampEntP_m3+ SampEntP_m4 + 
  SpectEnt + Autocorr + SD1 + SD2 + SDEGG

# creating test set - not used for validation
set.seed(100)
set <- createDataPartition(params$nausea_onset, p = 0.75, list = FALSE)
TrainSet <- params[set,]
TestSet <- paramsN[-set,]

# leave-one-out cross-validation
trControl <- trainControl(method = "LOOCV",
                          savePredictions = T)

# train the model
model1 <- train(classifier1, data = TrainSet, method = 'rf',
                metric = "Accuracy", trControl = trControl)

# assess the classifier
training_predict1 <- predict(model1, TrainSet, type = "raw")
table(training_predict1, TrainSet$nausea_onset)

test_predict1 <- predict(model1, TestSet, type = "raw")
table(test_predict1, TestSet$nausea_onset)

confMat1 <- table(TrainSet$nausea_onset, training_predict1)
print(round(100*sum(diag(confMat1))/sum(confMat1),2))
confMat11 <- table(test_predict1, TestSet$nausea_onset)
print(round(100*sum(diag(confMat11))/sum(confMat11),2))

# get more info about classifier
d = confusionMatrix(test_predict1,TestSet$nausea_onset)
confusionMatrix(test_predict1,TestSet$nausea_onset)
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

# plot importance (uncomment if necessary)
# plot(caret::varImp(model1), main = "Nausea_onset")
