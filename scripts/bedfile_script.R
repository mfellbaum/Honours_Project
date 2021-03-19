chromStart <- seq(from = 1, 
                  to = 29990000,
                  by = 9000)

chromEnd <- seq(from = 10000,
                to = 30000000,
                by = 9000)

chrom <- rep("chrom 1", each = length(chromStart))

bedfile <- data.frame(chrom,chromStart,chromEnd)

cat("track name=\"atsweeps\" description=\"BED file for hapcount\"\n",
    file = "hapcount_BED_file_1kb.bed")

write.table(bedfile, file = "hapcount_BED_file_1kb.bed",
            row.names = F, 
            col.names = F,
            quote = F,
            append = T,)
options(scipen=999) 
