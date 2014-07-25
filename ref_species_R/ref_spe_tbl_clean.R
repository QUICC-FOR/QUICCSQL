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

#set eol token
options(eolApiKey="6ab6532c0ba87bae5665e9c684dcec73479fef8a")

#load data
ref_spe  <- read.csv2("ref_species.csv",stringsAsFactors=F)


# Functions ---------------------------------------------------------------

paste3 <- function(...,sep=", ") {
  L <- list(...)
  L <- lapply(L,function(x) {x[is.na(x)] <- ""; x})
  ret <-gsub(paste0("(^",sep,"|",sep,"$)"),"",
             gsub(paste0(sep,sep),sep,
                  do.call(paste,c(L,list(sep=sep)))))
  is.na(ret) <- ret==""
  ret
}

sci2comm_error <- function(id) {
  return(tryCatch(sci2comm(scinames=id,db="itis",simplify=T), error=function(e) NULL))
}

##########################################
########### First Filter
##########################################

# Dump TSN with NA (genus empty) --------------------------------------------------------

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
##### Traitment on common names
##########################################

ref_spe$genus  <- str_trim(ref_spe$genus)
ref_spe$species  <- str_trim(ref_spe$species)
ref_spe$en_com_name  <- str_trim(ref_spe$en_com_name)
ref_spe$id  <- str_trim(paste(ref_spe$genus, ref_spe$species, sep=" "))

###### Fr - EOL
fr_name  <- sci2comm(scinames=id,simplify=FALSE)
fr_name  <- ldply(fr_name,function(dat) as.vector(na.omit(dat[dat$eol_preferred == TRUE 
                                                 & dat$language=='fr',"vernacularname"]))[1])
ref_spe_fr  <- ref_spe
ref_spe_fr  <- merge(ref_spe_fr,fr_name,by.x="id",by.y=".id")
ref_spe_fr$fr_com_name  <- str_trim(paste3(ref_spe_fr$fr_com_name,ref_spe_fr$V1))
ref_spe  <- ref_spe_fr[,-12]

###### En - ITIS

en_name  <- sci2comm_error(id)

