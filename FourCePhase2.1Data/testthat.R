## testing script
rm(list=ls()); gc()

setwd("~/COVID/Phase2.1DataRPackage/FourCePhase2.1Data")

#install/refresh package (from fork)
devtools::install_github(repo="https://github.com/sxinger/Phase2.1DataRPackage",
                         subdir="FourCePhase2.1Data", 
                         upgrade=FALSE)


#test runQC()
FourCePhase2.1Data::runQC("KUMC")
