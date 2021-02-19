# R script to modify blast results
# Ryohei Thomas Nakano

rm(list=ls())

# packages
library(stringr)

# dir
dir <- commandArgs(trailingOnly=TRUE)[1]
map_rhizo    <- "/netscratch/dep_psl/grp_psl/garridoo/rhizobia/mapping_new.txt"
map_atsphere <- "/biodata/dep_psl/common/culture_collections/mapping.txt"

# import
df <- read.table(paste(dir, "/blast_rhizobia.results.txt", sep=""), header=T, sep="\t")
map <- read.table(map_rhizo, sep="\t", header=T)

# mod
df$ID <- str_sub(df$sseqid, start=1, end=4)
idx <- match(df$ID, map$ID)
df <- data.frame(df, map[idx,])

# out
write.table(df, file=paste(dir, "/blast_rhizobia.results-map.txt", sep=""), sep="\t", quote=F)




# import
df <- read.table(paste(dir, "/blast_public.results.txt", sep=""), header=T, sep="\t")

# mod
df$ID <- str_sub(df$sseqid, start=1, end=4)
idx <- match(df$ID, map$ID)
df <- data.frame(df, map[idx,])

# out
write.table(df, file=paste(dir, "/blast_public.results.txt-map.txt", sep=""), sep="\t", quote=F)






# import
df <- read.table(paste(dir, "/blast_atsphere.results.txt", sep=""), header=T, sep="\t")
map <- read.table(map_atsphere, sep="\t", header=T)

# mod
idx <- match(df$sseqid, map$ID)
df <- data.frame(df, map[idx,])

# out
write.table(df, file=paste(dir, "/blast_atsphere.results-map.txt", sep=""), sep="\t", quote=F)




