## testing script
rm(list=ls()); gc()

setwd("~/COVID/Phase2.1DataRPackage/FourCePhase2.1Data")

devtools::install_github(repo="https://github.com/covidclinical/Phase2.1DataRPackage",
                         subdir="FourCePhase2.1Data", 
                         upgrade=TRUE,force = TRUE)

#line-by-line implementation
#--load libraries
library(utils)
library(dplyr)
library(tidyr)
library(rtf)
library(survival)
library(stringr)
library(data.table)

#--source all scripts
source("./R/functions.R")
source("./R/inputFileFunctions.R")
source("./R/runData.R")
source("./R/runQC.R")

#--parameter
siteid<-"KUMC"

#-------runQC()--------
runQC(siteid)

#-----12/14/2020
# Error in `$<-.data.frame`(`*tmp*`, "concept_code", value = character(0)) : 
#   replacement has 0 rows, data has 270356
#--------------------------traceback the error---------------------------------------------------------
# read Phase1.1 and Phase2.1 data
dir.input=getInputDataDirectoryName()
dir.output=dir.input
phase1.Labs=read.csv(paste0(dir.input,"/Labs-", siteid,".csv"))
phase1.Medications=read.csv(paste0(dir.input, "/Medications-", siteid,".csv"))
phase1.Diagnoses=read.csv(paste0(dir.input, "/Diagnoses-", siteid,".csv"))
phase1.Demographics=read.csv(paste0(dir.input, "/Demographics-", siteid,".csv"))
phase1.DailyCounts=read.csv(paste0(dir.input, "/DailyCounts-", siteid,".csv"))
phase1.ClinicalCourse=read.csv(paste0(dir.input, "/ClinicalCourse-", siteid,".csv"))

phase2.ClinicalCourse=read.csv(paste0(dir.input, "/LocalPatientClinicalCourse.csv"))
phase2.PatientObservations=read.csv(paste0(dir.input, "/LocalPatientObservations.csv"))
phase2.PatientSummary=read.csv(paste0(dir.input, "/LocalPatientSummary.csv"))

#----convert column names-----
colnames(phase1.Labs)<-tolower(colnames(phase1.Labs))
colnames(phase1.Medications)<-tolower(colnames(phase1.Medications))
colnames(phase1.Diagnoses)<-tolower(colnames(phase1.Diagnoses))
colnames(phase1.Demographics)<-tolower(colnames(phase1.Demographics))
colnames(phase1.DailyCounts)<-tolower(colnames(phase1.DailyCounts))
colnames(phase1.ClinicalCourse)<-tolower(colnames(phase1.ClinicalCourse))
colnames(phase2.ClinicalCourse)<-tolower(colnames(phase2.ClinicalCourse))
colnames(phase2.PatientObservations)<-tolower(colnames(phase2.PatientObservations))
colnames(phase2.PatientSummary)<-tolower(colnames(phase2.PatientSummary))


#-----runQC_tab_lab()
runQC_tab_lab(file.nm2=paste0(dir.output, "/Phase2.1DataQCReport.", siteid,".txt"),
              phase2.ClinicalCourse=phase2.ClinicalCourse, 
              phase2.PatientObservations=phase2.PatientObservations, 
              phase1.Labs=phase1.Labs, 
              output.dir=dir.output)

#-------tab_compare_lab()
tab_compare_lab(myday=0,
                phase2.ClinicalCourse=read.csv(paste0(dir.input, "/LocalPatientClinicalCourse.csv")), 
                phase2.PatientObservations=read.csv(paste0(dir.input, "/LocalPatientObservations.csv")), 
                phase1.Labs=read.csv(paste0(dir.input,"/Labs-", siteid,".csv")))

#Line with error: dat$concept_code=as.character(dat$concept_code)
#======column names of all raw data table were defaulted as upper case, need to save as lower case
#---------------------------------------------------------------------------------------------------


#---12/15/2020, after 

