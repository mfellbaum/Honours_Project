chromStart <- seq(from = 1, 
                  to = 29991000,
                  by = 1000)

chromEnd <- seq(from = 10000,
                to = 30000000,
                by = 1000)

chrom <- rep("1", each = length(chromStart))

bedfile <- data.frame(chrom,chromStart,chromEnd)

cat("track name=\"atsweeps\" description=\"BED file for hapcount\"\n",
    file = "hapcount_BED_file_10kb.bed")

write.table(bedfile, file = "hapcount_BED_file_10kb.bed",
            row.names = F, 
            col.names = F,
            quote = F,
            append = T,)
options(scipen=999) 
