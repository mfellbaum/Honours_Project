chromStart <- seq(from = 1, 
                  to = 30000001,
                  by = 1000000)

chromEnd <- seq(from = 1000000,
                to = 31000000,
                by = 1000000)

chrom <- rep("chrom 1", each = length(chromStart))

bedfile <- data.frame(chr,chromStart,chromEnd)

cat("track name=\"atsweeps\" description=\"BED file for hapcount\"\n",
    file = "hapcount_BED_file_test.bed")

write.table(bedfile, file = "hapcount_BED_file_test.bed",
            row.names = F, 
            col.names = F,
            quote = F,
            append = T,)
options(scipen=999) 
