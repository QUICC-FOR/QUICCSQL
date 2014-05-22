# Script to get TSN and clean species reference table
# By Steve Vissault

# Load workspace ----------------------------------------------------------
setwd("~/Documents/GitHub/QUICC-SQL/ref_species_R")
setwd("/Users/database/Desktop/QUICC-SQL/ref_species_R")
rm(list=ls())


# init parralelization ----------------------------------------------------

sfInit( parallel=TRUE, cpus=10, type="SOCK" )
sfLibrary(plyr)
sfLibrary(taxize)

# install and load package ------------------------------------------------
library(devtools)
#install_github("ropensci/taxize")
library("taxize")
library("stringr")
library("plyr")
library("snowfall")
library("snow")

# Set parralel -----------------------------------------------------------

# Load data ---------------------------------------------------------------

nb_sp  <- read.csv2("ref_on_sp.csv",stringsAsFactors=F)
qc_sp  <- read.csv2("ref_qc_sp.csv",stringsAsFactors=F)
us_sp  <- read.csv2("ref_us_sp.csv",stringsAsFactors=F)
on_sp  <- read.csv2("ref_on_sp.csv",stringsAsFactors=F)

# Add id based on latin name
qc_sp$id  <- paste(qc_sp$Genus,qc_sp$species)
us_sp$id  <- paste(us_sp$genus,us_sp$species,us_sp$subspecies,us_sp$variety)
on_sp$id  <- paste(on_sp$genus, on_sp$species)

us_seq  <- c(seq(1,dim(us_sp)[1],200),dim(us_sp)[1])
us_ls = list()
for(i in 2:length(us_seq)){
  us_ls[[i-1]]  <- us_sp[us_seq[i-1]:us_seq[i],]  
}


# Cleaning data: GET TSN + Scientific names accepted----------------------------------------------------------------

# Function to merge and validate TSN

cleanup_dat  <- function(data){
  match  <- unique(tnrs(query = data$id, source = "iPlant_TNRS",verbose=FALSE,getpost = "POST")[, -c(3,5:7)])
  match  <- match[match$score>0.8,]
  colnames(match)[1] <- "id"
  data  <- merge(data,match,by="id",all=T)[,-1]
  tsn <- get_tsn(data$acceptedname,ask=FALSE,verbose=FALSE, searchtype = "scientific", accepted = TRUE)
  tsn <- ldply(tsn, itis_acceptname)
  tsn[tsn[,1]=='true',] <- NA
  data$tsn  <-  tsn[,1]
  return(data)
}


res_us  <- sfClusterApplyLB(us_ls, cleanup_dat)

# stop parralelization ----------------------------------------------------

sfExportAll()
sfStop()

tsn_qc  <- cleanup_dat(qc_sp)
save(tsn_qc,file='tsn_qc.Robj')

tsn_on  <- cleanup_dat(on_sp)
save(tsn_on,file='tsn_on.Robj')
