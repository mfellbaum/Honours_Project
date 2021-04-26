## Calculate H statistics for all rows in the hapcount file using 2 loops.

# Set working directory
setwd("~/Documents/Uni/4th_year/Honours_Project/Coding")

# Open hapcount table into R 
hapcount_table <- read.table("hapcount_chr1_20kb.hapcount", 
                             fill = T, skip = 1, col.names = c(1:13))

# Open rec table and add rec column to hapcount table
rec_table <- read.table("Rec_AT_Chr1.dat")
rec_vector <- rec_table[["cM.Mb"]]
hapcount_table$x14 <- rec_vector
hapcount_table <- na.omit(hapcount_table)


# Filter out rows with SNPs < 100 and cM/Mb < 0.5
hapcount_table <- hapcount_table[hapcount_table[,4] >= 100,]
hapcount_table <- hapcount_table[hapcount_table[,14] >= 0.5,]


# Define rows and columns
rows <- nrow(hapcount_table)
columns <- ncol(hapcount_table)
row.names(hapcount_table) <- 1:rows

# Create hstats vectors
h1 <- rep(NA, rows)
h12 <- rep(NA, rows)
h2 <- rep(NA, rows)
h21 <- rep(NA, rows)

# Define loop vectors
loop.vector.1 <- 1:rows
loop.vector.2 <- 7:(columns-1)


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
    
    # Define hapfreq and multiplicity vectors for 1 row
    hapfreq[f-6] <- d[2]
    multiplicity[f-6] <- d[1]
     
  }
  
  # Reverse hapfreq and multiplicity vectors 
  hapfreq <- rev(hapfreq)
  hapfreq <- hapfreq[!is.na(hapfreq)]
  multiplicity <- rev(multiplicity)
  multiplicity <- multiplicity[!is.na(multiplicity)]
  
  # Define 2 most common haplotypes for 1 row 
  hapfreq1 <- 0
  hapfreq2 <- 0
  
  hapfreq1 <- hapfreq[1]
  if(multiplicity[1] == 1) {hapfreq2 <- hapfreq[2]}
  else {hapfreq2 <- hapfreq[1]}
  if(is.na(hapfreq2)) {hapfreq2 <- 0}
  
  # Calculate H1, H12, H2 and H2/H1 for all rows
  h1[n] <- sum(h1.single.row, na.rm = T)
  h12[n] <- h1[n] + 2*(hapfreq1/90)*(hapfreq2/90)
  h2[n] <- h1[n]-((hapfreq1/90)^2)
  h21[n] <- h2[n]/h1[n]
}




file.create("h1_20kb_window")
write.table(h1, "h1_20kb_window")

file.create("h12_20kb_window")
write.table(h12, "h12_20kb_window")

file.create("h21_20kb_window")
write.table(h21, "h21_20kb_window")


midpoint <- (hapcount_table[[3]]-10000)/1000000

plot(x = midpoint, y = h1, pch = 20, xlab = "Window midpoint (Mb)", main = "H1 for 20kb fixed windows", ylab = "H1")
plot(x = midpoint, y = h12, pch = 20, xlab = "Window midpoint (Mb)", main = "H12 for 20kb fixed windows", ylab = "H12")
plot(x = midpoint, y = h21, pch = 20, xlab = "Window midpoint (Mb)", main = "H2/H1 for 20kb fixed windows", ylab = "H2/H1")

plot(x = hapcount_table$x14, y = h1, pch = 20, xlab = "Recombination rate (cM/Mb)", main = "H1 as a function of recombination rate", ylab = "H1")
plot(x = hapcount_table$x14, y = h12, pch = 20, xlab = "Recombination rate (cM/Mb)", main = "H12 as a function of recombination rate", ylab = "H12")
plot(x = hapcount_table$x14, y = h21, pch = 20, xlab = "Recombination rate (cM/Mb)", main = "H2/H1 as a function of recombination rate", ylab = "H2/H1")

