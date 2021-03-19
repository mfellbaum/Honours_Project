## Calculate H statistics for all rows in the hapcount file using 2 loops.
# Updated to see how it looks on github

# Open hapcount table into R 
hapcount_table <- read.table("hapcount_chr1_test.hapcount", 
                             fill = T, skip = 1, col.names = c(1:9))

#Calculate H1 statistic
# H1 = Si = 1, . . .n pi2

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

# Calculate H12 statistic
#  H12 = (p1 + p2)2 + Si>2 pi2 = H1 + 2p1p2

# Define loop vectors
loop.vector.1 <- 1:31
loop.vector.2 <- c(7,8,9)
loop.vector.3 <- c(7,8)

# Create hstats vector
h12.all.rows <- rep(NA, 31)

# Open outer loop for all rows
for(n in loop.vector.1){
  
  # Define hstats vector for single row to reset in each loop    
  h12.single.row <- rep(NA, 3)
  
  # Open inner loop for 1 row  
  for(f in loop.vector.2){
    if(hapcount_table[n , f] == "") {break}
    r <- hapcount_table[n , f]
    d <- as.numeric(unlist(strsplit(r, ":")))
    j <- ((d[2]/90)^2)*(d[1]) 
    
# Trying to add the + 2*hap1*hap2 using loops but don't think this will work.    
    for(x in loop.vector.3){
        v <- hapcount_table[n, x]
        a <- rep(NA, 2)
        a <- as.numeric(unlist(strsplit(v, ":")))
        c <- sum(a)
        }
     b <- j + 2*c
     hap12[f-6] <- b
      
    
    h12.single.row[(f-6)] <- j 
  }
  
  # Add calculations to the hstats vector
  t <- sum(h12.single.row, na.rm = T)
  h12.all.rows[n] <- t
  
}

h12.all.rows

file.create("h12_1Mb_window")
write.table(hstats.all.rows, "h12_1Mb_window")
plot(h12.all.rows)
