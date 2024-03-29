# Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection
This repository contains R code for reproducing results presented in the manuscript "Electrogastrogram-derived Features for Automated Sickness Detection in Driving Simulator" and authored by Grega Jakus (ORCID: [0000-0001-9373-7885](https://orcid.org/0000-0001-9373-7885)), Jaka Sodnik (ORCID: [0000-0002-8915-9493](https://orcid.org/0000-0002-8915-9493)), and Nadica Miljković (ORCID: [0000-0002-3933-6076](https://orcid.org/0000-0002-3933-6076)).

## GitHub repository contents
This repository contains both data and code, as well as [README.md](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/README.md) and [license](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/LICENSE) files.
### EGG-based parameters
EGG-based (Electrogastrogram-based) features on original and noisy data with appropriate SNRs (Signal-to-Noise Raios) are presented in the following .csv tables:
1) [dat.csv](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/dat.csv) - EGG-based parameters/features derived from the original dataset
2) [dat-noise_SNR+0dB.csv](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/dat-noise_SNR%2B0dB.csv) - EGG-based parameters/features derived from the semisynthetic dataset (by adding pseudo-random colored noise of SNR = 0 dB, the actual mean value of SNR is -3 dB)
3) [dat-noise_SNR+10dB.csv](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/dat-noise_SNR%2B10dB.csv) - EGG-based parameters/features derived from the semisynthetic dataset (by adding pseudo-random colored noise of SNR = 0 dB, the actual mean value of SNR is 7 dB)
4) [dat-noise_SNR+20dB.csv](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/dat-noise_SNR%2B20dB.csv) - EGG-based parameters/features derived from the semisynthetic dataset (by adding pseudo-random colored noise of SNR = 0 dB, the actual mean value of SNR is 17 dB)
5) [dat-noise_SNR-10dB.csv](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/dat-noise_SNR-10dB.csv) - EGG-based parameters/features derived from the semisynthetic dataset (by adding pseudo-random colored noise of SNR = 0 dB, the actual mean value of SNR is -13 dB)
6) [dat-noise_SNR-20dB.csv](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/dat-noise_SNR-20dB.csv) - EGG-based parameters/features derived from the semisynthetic dataset (by adding pseudo-random colored noise of SNR = 0 dB, the actual mean value of SNR is -23 dB)
### Code for EGG analysis
The R code (Team, R. C. R. A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna. https://www.r-project.org, 2021) for analysis of the features shared in .csv tables is given in the following scripts:
1) [comparison-noise.R](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/comparison-noise.R) - statistical analysis for comparison of noisy and non-noisy EGG-based parameters and for distinguishing statistical difference on data in relation to the nausea occurence
2) [nausea-categorical.R](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/nausea-categorical.R) - descriptive statistics of categorical variables
3) [rf-nausea-classification.R](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/rf-nausea-classification.R) - classification of nausea occurence based on the EGG-based parameters for each dataset separately
4) [rf-nausea-classification-noisy-set.R](https://github.com/NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection/blob/main/rf-nausea-classification-noisy-set.R) - classification of nausea occurence based on the original EGG-based parameters tested on noisy test data

## EGG-based features
Each datatable shared in .csv format contains the following columns:
1) ordinary number of instance
2) id of the participant
3) rms - Root Mean Square
4) median of the EGG PSD (Power Spectral Density)
5) magDf - magnitude of the dominant frequency of EGG signal
6) df - dominant frequency
7) cs - crest factor of EGG PSD
8) sdv - Spectral Variation Distribution
9) SampEntT_m2 - sample entropy of time series for embedding dimension _m_ = 2
10) SampEntT_m3 - sample entropy of time series for embedding dimension _m_ = 3
11) SampEntT_m4 - sample entropy of time series for embedding dimension _m_ = 4
12) SampEntP_m2 - sample entropy of PSD for embedding dimension _m_ = 2
13) SampEntP_m3 - sample entropy of PSD for embedding dimension _m_ = 3
14) SampEntP_m4 - sample entropy of PSD for embedding dimension _m_ = 4
15) SpectEnt - spectral entropy
16) Autocorr - autocorrelation zero-crossing
17) SD1 - transverse line of the Poincaré plot 
18) SD2 - longitudinal line of the Poincaré plot 
19) SDEGG - standard deviation obtained from SD1 and SD2
20) snrEGG - the actual SNR (Signal-to-Noise Ratio) for the instance (only tables reporting parameters derived from semi-synthetic dataset contain this column)
21) nausea_onset - binary indicator whether for analyzed data segment nausea occured or not

## Note on computational reproducibility
For the sake of computational reproducibility, each R script contains R version and commented header with [groundhog](https://groundhogr.com/) function that loads packages and appropriate dependencies for the selected date from [CRAN](https://cran.r-project.org/) (The Comprehensive R Archive Network).

## Disclaimer
The R code is provided without any guarantee and it is not intended for medical purposes.

## Acknowledgements
Authors’ gratitude goes to Nenad B. Popović for his long collaboration in studies related to EGG research and for fruitful discussions on feature extraction techniques followed by his scientific contribution published elsewhere. The Authors also acknowledge Timotej Gruden, PhD student, for his exceptional work in experiment design and measurement conduction.

## Funding
This research was funded by [HADRIAN](https://hadrianproject.eu/) (Holistic Approach for Driver Role Integration and Automation Allocation for European Mobility Needs) EU Horizon 2020 project, grant number 875597. It was partly supported also by the Slovenian Research Agency within the research program ICT4QoL - Information and Communications Technologies for Quality of Life, grant number P2-0246.
N.M. was partly supported by the Ministry of Education, Science, and Technological Development, Republic of Serbia, grant number 451-03-68/2022-14/200103.

## How to cite this repository?
If you find EGG-based features and R code useful for your own research and teaching class, please cite the following references:
1) Jakus, G., Sodnik, J., & Miljković, N. (2022, October 23). NadicaSm/Statistical-Analysis-and-Machine-Learning-for-EGG-based-Nausea-Detection: v1 (Version v1). Version v1. Zenodo. https://doi.org/10.5281/zenodo.7242797 
2) Jakus, G., Sodnik, J., & Miljković, N. (2022). Electrogastrogram-Derived Features for Automated Sickness Detection in Driving Simulator. Sensors, 22(22), 8616. https://doi.org/10.3390/s22228616
3) Gruden, T., Popović, N. B., Stojmenova, K., Jakus, G., Miljković, N., Tomažič, S., & Sodnik, J. (2021). Electrogastrography in autonomous vehicles—an objective method for assessment of motion sickness in simulated driving environments. Sensors, 21(2), 550.  https://doi.org/10.3390/s21020550
