## Calculate H statistics for all rows in the hapcount file using 2 loops.

# Need to update the hapcount file name.


# All H stats in 1 script

# Open hapcount table into R 
hapcount_table <- read.table("hapcount_chr1_10kb.hapcount", 
                             fill = T, skip = 1, col.names = c(1:13))
rows <- nrow(hapcount_table)
columns <- ncol(hapcount_table)

# Create hstats vectors
h1 <- rep(NA, rows)
h12 <- rep(NA, rows)
h2 <- rep(NA, rows)
h21 <- rep(NA, rows)

# Define loop vectors
loop.vector.1 <- 1:rows
loop.vector.2 <- 7:columns


# Open outer loop for all rows
for(n in loop.vector.1){
  
  # Define h1 vector for single row to reset in each loop    
  h1.single.row <- rep(NA, length(loop.vector.2))
  
  # Define hapfreq and multiplicity vectors to reset each loop
  hapfreq <- rep(NA, length(loop.vector.2))
  multiplicity <- rep(NA, length(loop.vector.2))
  
  # Open inner loop for 1 row  
  for(f in loop.vector.2){
    
    # Extract haplotype frequency and multiplicity from hapcount table    
    if(hapcount_table[n , f] == "") {break}
    r <- hapcount_table[n , f]
    d <- as.numeric(unlist(strsplit(r, ":")))
    
    # Calculate H1 for 1 row    
    j <- ((d[2]/90)^2)*(d[1])
    h1.single.row[(f-6)] <- j 
    
    
    # Sort hapfreq and multiplicity 
    hapfreq[f-6] <- d[2]
    hapfreq <- sort(hapfreq, decreasing = T)
    
    # This doesn't work yet - something going wrong with the reverse over loops
    multiplicity[f-6] <- d[1]
    multiplicity <- rev(multiplicity)
    multiplicity <- na.omit(multiplicity)
    
    
    # Define 2 most common haplotypes for 1 row 
    hapfreq1 <- 0
    hapfreq2 <- 0
    
    hapfreq1 <- hapfreq[1]
    if(multiplicity[1] == 1) {hapfreq2 <- hapfreq[2]}
    else {hapfreq2 <- hapfreq[1]}
     
  }
  
  # Calculate H1 for all rows
  h1[n] <- sum(h1.single.row, na.rm = T)
  
  # Calculate H12 for all rows   
  h12[n] <- h1[n] + 2*(hapfreq1/90)*(hapfreq2/90)
  
  # Calculate H2 for all rows  
  h2[n] <- h1[n]-((hapfreq1/90)^2)
  
  # Calculate H2/H1 for all rows  
  h21[n] <- h2[n]/h1[n]
}




file.create("h1_10kb_window")
write.table(h1, "h1_10kb_window")

file.create("h12_10kb_window")
write.table(h12, "h12_10kb_window")

file.create("h21_10kb_window")
write.table(h21, "h21_10kb_window")

plot(h1, pch = 20, xlab = "Window", main = "H1 statistics for 10kb fixed windows")
plot(h12, pch = 20, xlab = "Window", main = "H12 statistics for 10kb fixed windows")
plot(h21, pch = 20, xlab = "Window", main = "H2/H1 statistics for 10kb fixed windows")



# Sketchy way to define the hapfreq - think it would work but not the proper way to do it
#hapfreq2 <- 0
#hapfreq2 <- hapfreq1
#hapfreq1 <- d[2]