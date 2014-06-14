# Final script 
# Purpose: Clean table
# QUICC-FOR database
# By Steve Vissault

# Common name traitment ---------------------------------------------------

ref_spe  <- 



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
