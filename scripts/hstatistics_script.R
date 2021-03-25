## Calculate H statistics for all rows in the hapcount file using 2 loops.

# When changing the window size I need to update loop.vector.1 and h1.all.rows 
# to match the number of windows. Also need to update the hapcount file name.


# All H stats in 1 script

# Open hapcount table into R 
hapcount_table <- read.table("hapcount_chr1_test.hapcount", 
                             fill = T, skip = 1, col.names = c(1:9))

# Define loop vectors
loop.vector.1 <- 1:31
loop.vector.2 <- c(7,8,9)

# Create hstats vector
h1 <- rep(NA, 31)
h12 <- rep(NA, 31)
h2 <- rep(NA, 31)
h21 <- rep(NA, 31)

# Open outer loop for all rows
for(n in loop.vector.1){
  
# Define hstats vector for single row to reset in each loop    
  h1.single.row <- rep(NA, 3)
  
# Open inner loop for 1 row  
  for(f in loop.vector.2){
    
# Extract haplotype frequency and multiplicity from hapcount table    
    if(hapcount_table[n , f] == "") {break}
    r <- hapcount_table[n , f]
    d <- as.numeric(unlist(strsplit(r, ":")))
    
# Calculate H1 for 1 row    
    j <- ((d[2]/90)^2)*(d[1])
    h1.single.row[(f-6)] <- j 
    
# Define 2 most common haplotypes for 1 row 
    hapfreq1 <- d[2] 
    if(d[1] > 1) {hapfreq2 <- d[2]} 
  }
  
  # Calculate H1 for all rows
  t <- sum(h1.single.row, na.rm = T)
  h1[n] <- t
  
  # Calculate H12 for all rows   
  h12[n] <- t + 2*(hapfreq1/90)*(hapfreq2/90)
  
  # Calculate H2 for all rows  
  h2[n] <- t-((hapfreq1/90)^2)
  
  # Calculate H2/H1 for all rows  
  h21[n] <- h2[n]/h1[n]
}

h1
h12
h21

file.create("h1_1Mb_window")
write.table(h1, "h1_1Mb_window")

file.create("h12_1Mb_window")
write.table(h12, "h12_1Mb_window")

file.create("h21_1Mb_window")
write.table(h21, "h21_1Mb_window")