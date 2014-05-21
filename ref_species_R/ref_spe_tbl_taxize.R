# Script to get TSN and clean species reference table
# By Steve Vissault

# Load workspace ----------------------------------------------------------
#setwd("~/Documents/GitHub/QUICC-SQL/ref_species_R")
setwd("/Users/database/Desktop/QUICC-SQL/ref_species_R")
rm(list=ls())

# install and load package ------------------------------------------------
#install.packages("taxize")
library("taxize")
library("stringr")
library("plyr")

# Load data ---------------------------------------------------------------

nb_sp  <- read.csv2("ref_on_sp.csv",stringsAsFactors=F)
qc_sp  <- read.csv2("ref_qc_sp.csv",stringsAsFactors=F)
us_sp  <- read.csv2("ref_us_sp.csv",stringsAsFactors=F)
on_sp  <- read.csv2("ref_on_sp.csv",stringsAsFactors=F)

# Add id based on latin name
qc_sp$id  <- paste(qc_sp$Genus,qc_sp$species)
us_sp$id  <- paste(us_sp$genus,us_sp$species,us_sp$subspecies,us_sp$variety)
on_sp$id  <- paste(on_sp$genus, on_sp$species)

# Cleaning data: GET TSN + Scientific names accepted----------------------------------------------------------------

cleanup_dat  <- function(data){
  match  <- unique(tnrs(query = data$id, source = "iPlant_TNRS",verbose=FALSE,getpost = "POST")[, -c(3:7)])
  colnames(match)[1] <- "id"
  data  <- merge(data,match,by="id",all=T)[,-1]
  tsn <- get_tsn(data$acceptedname,ask=FALSE,verbose=FALSE, searchtype = "scientific", accepted = TRUE)
  tsn <- ldply(tsn, itis_acceptname)
  tsn[tsn[,1]=='true',] <- NA
  data$tsn  <-  tsn[,1]
  return(data)
}

tsn_qc  <- cleanup_dat(qc_sp)
save(tsn_qc,file='tsn_qc.Robj')
tsn_us  <- cleanup_dat(us_sp)
save(tsn_us,file='tsn_us.Robj')
tsn_on  <- cleanup_dat(on_sp)
save(tsn_on,file='tsn_on.Robj')
