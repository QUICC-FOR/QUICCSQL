# Final script 
# Purpose: Clean table
# QUICC-FOR database
# By Steve Vissault

# Load workspace ----------------------------------------------------------

setwd("~/Documents/GitHub/QUICC-SQL/ref_species_R")
#setwd("/Users/database/Desktop/QUICC-SQL/ref_species_R")
rm(list=ls())

# Load data and libraries ---------------------------------------------------

library("knitr")
library("stringr")
library("taxize")
library("plyr")
library('stringr')

#load data
ref_spe  <- read.csv2("ref_species.csv",stringsAsFactors=F)

##########################################
########### First Filter
##########################################

# Dump TSN with NA (only genus empty) --------------------------------------------------------

ref_spe  <- ref_spe[!ref_spe$genus=='',]

##########################################
########### Second Filter
##########################################

# Duplicated lines ---------------------------------------------------------------

allDup <- function (df)
  {
    duplicated(df) | duplicated(df, fromLast = TRUE)
  }

DumpLines  <- ref_spe[allDup(ref_spe[,1:3]),]

DumpLines  <- split(DumpLines,f=factor(DumpLines$tsn))

Reports_dup  <- lapply(DumpLines, function(x){
                cons_code  <- rep(x[1,c("us_code")],dim(x)[1]-1)
                dump_code  <- x[2:dim(x)[1],c("tsn","en_com_name","us_code")]
                fin_code  <- data.frame(dump_code,new_code=cons_code)
                return(fin_code)
              })

Reports_dup  <- do.call(rbind,Reports_dup)
#kable(Reports_dup,format="markdown",row.names=F)

ref_spe  <- ref_spe[!ref_spe$us_code %in% Reports_dup$us_code,]

##########################################
##### Trim white space
##########################################

ref_spe$genus  <- str_trim(ref_spe$genus)
ref_spe$species  <- str_trim(ref_spe$species)
ref_spe$en_com_name  <- str_trim(ref_spe$en_com_name)

##########################################
##### Create ID 
##########################################

# replace empty string by NA in species column
ref_spe[ref_spe$species=="",'species']  <- NA

# TSN + three first letters of genus and species
ref_spe$id_spe  <- toupper(paste(ref_spe$tsn,substr(ref_spe$genus,1,3),substr(ref_spe$species,1,3),sep="-"))

# if id_spe is duplicated add a new letter at the end of the string
ref_spe[duplicated(ref_spe$id_spe),'id_spe']  <- toupper(paste(ref_spe[duplicated(ref_spe$id_spe),'tsn'],substr(ref_spe[duplicated(ref_spe$id_spe),'genus'],1,3),substr(ref_spe[duplicated(ref_spe$id_spe),'species'],1,4),sep="-"))

##########################################
##### Export final table
##########################################

# Replace NA value by an empty string - Best import process in postgreSQL
write.csv2(ref_spe,file='final_ref_table.csv',row.names=F,na='')


