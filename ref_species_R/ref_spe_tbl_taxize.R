# Script to get TSN and clean species reference table 
# QUICC-FOR database
# By Steve Vissault

# Load workspace ----------------------------------------------------------
setwd("~/Documents/GitHub/QUICC-SQL/ref_species_R")
#setwd("/Users/database/Desktop/QUICC-SQL/ref_species_R")
rm(list=ls())

# install and load package ------------------------------------------------
#library(devtools)
#install_github("ropensci/taxize")
library("rPlant")
library("taxize")
library("plyr")
library("snowfall")
library("snow")
library("stringr")

# init parralelization ----------------------------------------------------

#sfInit( parallel=TRUE, cpus=16, type="SOCK" )
#sfLibrary(plyr)
#sfLibrary(taxize)

# Load data ---------------------------------------------------------------

nb_sp  <- read.csv2("ref_nb_sp.csv",stringsAsFactors=F)
qc_sp  <- read.csv2("ref_qc_sp.csv",stringsAsFactors=F)
us_sp  <- read.csv2("ref_us_sp.csv",stringsAsFactors=F)
on_sp  <- read.csv2("ref_on_sp.csv",stringsAsFactors=F)

# Add id based on latin name
qc_sp$id  <- paste(qc_sp$Genus,qc_sp$species)
us_sp$id  <- paste(us_sp$genus,us_sp$species)
on_sp$id  <- paste(on_sp$genus, on_sp$species)
nb_sp$id  <- nb_sp$en_verna_name


# Keys --------------------------------------------------------------------

options(eolApiKey="6ab6532c0ba87bae5665e9c684dcec73479fef8a")

# Cleaning data: GET TSN + Scientific names accepted----------------------------------------------------------------

# Function to merge and validate TSN
# dataset need to have a field called id

cleanup_dat  <- function(data){
  data$id  <- str_trim(data$id)
  tsn <- get_tsn(data$id,ask=FALSE, verbose=FALSE, searchtype = "scientific", accepted = TRUE)
  tsn <- ldply(tsn, itis_acceptname)
  tsn[tsn=='true']  <- NA
  data$tsn  <- tsn
  return(data)
}

# Paste function - special NA
paste3 <- function(...,sep=", ") {
  L <- list(...)
  L <- lapply(L,function(x) {x[is.na(x)] <- ""; x})
  ret <-gsub(paste0("(^",sep,"|",sep,"$)"),"",
             gsub(paste0(sep,sep),sep,
                  do.call(paste,c(L,list(sep=sep)))))
  is.na(ret) <- ret==""
  ret
}

# Trait and save ----------------------------------------------------------

tsn_qc  <- cleanup_dat(data=qc_sp)
#save(tsn_qc,file='tsn_qc.Robj')

tsn_on  <- cleanup_dat(data=on_sp)
#save(tsn_on,file='tsn_on.Robj')

tsn_us  <- cleanup_dat(data=us_sp)
#save(tsn_us,file='tsn_us.Robj')

#####################################################################################################
# reshape and merge data ------------------------------------------------------------

dat_on  <- tsn_on[,c(8,3,4,5,1,2)]
dat_us  <- tsn_us[,c(6,3,4,2,1)]
dat_qc  <- tsn_qc[,c(6,3,4,2,1)]

colnames(dat_on)[2:3]  <- c("genus","species")
colnames(dat_us)[2:3]  <- c("genus","species")
colnames(dat_qc)[2:3]  <- c("genus","species")

dat_us  <- data.frame(tsn=as.numeric(dat_us[,1]$V1),dat_us[,2:5])
dat_on  <- data.frame(tsn=as.numeric(dat_on[,1]$V1),dat_on[,2:6])
dat_qc  <- data.frame(tsn=as.numeric(dat_qc[,1]$V1),dat_qc[,2:5])

fin_dat <- merge(dat_on,dat_qc,by=c("tsn","genus","species"),all=T,incomparables=NA)
fin_dat <- merge(fin_dat,dat_us,by=c("tsn","genus","species"),all=T,incomparables=NA)
fin_dat$En_com_name <- paste3(fin_dat$common_nam,fin_dat$common_name,sep=" ;")

fin_dat  <- fin_dat[,c(1:3,11,7,8,5:6,10)]
colnames(fin_dat) <- c("tsn","genus","species","en_com_name","fr_com_name","qc_code","on_tree_code","on_alpha_code","us_code") 

write.csv2(fin_dat,file="ref_species.csv",row.names=F)


###########################################################################
# DONE --------------------------------------------------------------------
###########################################################################





