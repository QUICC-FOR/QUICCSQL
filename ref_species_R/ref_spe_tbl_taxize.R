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

# Split dataframe  --------------------------------------------------------

# us_seq  <- c(seq(1,dim(us_sp)[1],100),dim(us_sp)[1])
# us_ls = list()
# for(i in 2:length(us_seq)){
#   us_ls[[i-1]]  <- us_sp[us_seq[i-1]:us_seq[i],]  
# }

# Cleaning data: GET TSN + Scientific names accepted----------------------------------------------------------------

# Function to merge and validate TSN
# datset need to have 
#cleanup_dat  <- function(data){
  data  <- us_sp
  match  <- tnrs(query = data$id, source = "iPlant_TNRS",verbose=FALSE,getpost = "POST")[, -c(3,5:7)]
  match  <- match[match$score>0.4,-3]
  colnames(match)[1] <- "id"
  data$id  <- str_trim(data$id)
  data  <- unique(merge(data,match,by="id",all.x=TRUE))
  tsn <- get_tsn(data$id,ask=FALSE, verbose=FALSE, searchtype = "scientific", accepted = TRUE)
  tsn <- ldply(tsn, itis_acceptname)
  data$tsn  <-  tsn[,1]
  data  <- data[,-1]
  return(data)
#}

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

#res_us  <- sfClusterApplyLB(us_ls, cleanup_dat)

# stop parralelization ----------------------------------------------------
#sfExportAll()
#sfStop()

tsn_qc  <- cleanup_dat(data=qc_sp)
#save(tsn_qc,file='tsn_qc.Robj')

tsn_on  <- cleanup_dat(data=on_sp)
#save(tsn_on,file='tsn_on.Robj')

tsn_us  <- cleanup_dat(data=us_sp)
save(tsn_us,file='tsn_us.Robj')

#####################################################################################################

load('tsn_on.Robj')
load('tsn_qc.Robj')
# load('Common_name_en.Robj')
# load('Common_name_fr.Robj')

merge_ref <- merge(tsn_on[,c(1,2,7,8)],tsn_qc[,c(1,2,5,6)],by=c("tsn","acceptedname"),all=T)
colnames(merge_ref)[2:6]  <- c("scientific_name","on_tree_code","on_alpha_code","qc_tree_code","fr_common_name")

# Common name traitment ---------------------------------------------------

###### Fr
Fr_missing  <- merge_ref[is.na(merge_ref$fr_common_name),"scientific_name"]
Fr_missing  <- Fr_missing[which(str_length(Fr_missing)>1)]
                          
Com_Fr  <- sci2comm(scinames=Fr_missing,simplify=FALSE)
Com_Fr  <- ldply(Com_Fr,function(dat) as.vector(na.omit(dat[dat$eol_preferred == TRUE 
                                                         & dat$language=='fr',"vernacularname"]))[1])

colnames(Com_Fr)  <- c("id","fr_common_name")
Com_Fr  <- merge(merge_ref, Com_Fr,by.x="scientific_name",by.y="id",all.x=T)[,c(1,6:7)]
Com_Fr$merge_fr  <- paste3(as.vector(Com_Fr[,2]),as.vector(Com_Fr[,3]),sep="")
final_ref  <- merge(merge_ref,Com_Fr[!is.na(merge_ref),c(1,4)],by="scientific_name")
final_ref  <- final_ref[,-6]
colnames(final_ref)[6]  <- "fr_common_name"

###### En
En_sci  <- merge_ref[,"scientific_name"]
Com_En  <- sci2comm(scinames=En_sci, db='itis')
Com_En  <- ldply(Com_En,function(dat) as.vector(na.omit(dat))[1])
colnames(Com_En)  <- c("scientific_name","en_common_name")
merge_ref  <- merge(merge_ref,Com_En,id="scientific_name") 



