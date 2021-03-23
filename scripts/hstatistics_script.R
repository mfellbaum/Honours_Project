## Calculate H statistics for all rows in the hapcount file using 2 loops.

#H1 

# Open hapcount table into R 
hapcount_table <- read.table("hapcount_chr1_test.hapcount", 
                             fill = T, skip = 1, col.names = c(1:9))

#Calculate H1 statistic

# Define loop vectors
loop.vector.1 <- 1:31
loop.vector.2 <- c(7,8,9)

# Create hstats vector
h1.all.rows <- rep(NA, 31)

# Open outer loop for all rows
for(n in loop.vector.1){
  
# Define hstats vector for single row to reset in each loop    
  h1.single.row <- rep(NA, 3)
  
# Open inner loop for 1 row  
  for(f in loop.vector.2){
    if(hapcount_table[n , f] == "") {break}
    r <- hapcount_table[n , f]
    d <- as.numeric(unlist(strsplit(r, ":")))
    j <- ((d[2]/90)^2)*(d[1])
    h1.single.row[(f-6)] <- j 
  }
  
# Add calculations to the hstats vector
  t <- sum(h1.single.row, na.rm = T)
  h1.all.rows[n] <- t
  
}

h1.all.rows

file.create("h1_1Mb_window")
write.table(hstats.all.rows, "h1_1Mb_window")
plot(h1.all.rows)




# H12 stats using H1 code but added hapfreq1+2

# Open hapcount table into R 
hapcount_table <- read.table("hapcount_chr1_test.hapcount", 
                             fill = T, skip = 1, col.names = c(1:9))

# Define loop vectors
loop.vector.1 <- 1:31
loop.vector.2 <- c(7,8,9)

# Create hstats vector
h1.all.rows <- rep(NA, 31)

# Open outer loop for all rows
for(n in loop.vector.1){
  
# Define hstats vector for single row to reset in each loop    
  h1.single.row <- rep(NA, 3)
  
# Open inner loop for 1 row  
  for(f in loop.vector.2){
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
  h1.all.rows[n] <- t

# Calculate H12 for all rows   
  h12[n] <- t + 2*(hapfreq1/90)*(hapfreq2/90)
}

h12

file.create("h12_1Mb_window")
write.table(h12, "h12_1Mb_window")
plot(h12)

