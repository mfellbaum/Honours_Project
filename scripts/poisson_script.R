depth <- density(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH)

mean <- mean(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH)
var <- var(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH)
qpois(c(0.0025, 0.9975), mean)


plot(depth, frame = FALSE, col = "red",
     main = "Density plot of mean site depth of ATsweeps chr1",
     xlim = c(10, 80),
     xlab = "Mean site depth")

lines(dpois(seq(0, max(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH), 1), mean),
      col = "green", lty = 2)

abline(v = qpois(c(0.005, 0.995), mean), col=c("blue", "blue"),
       lty = 3:3)

legend(50, 0.06, legend=c("Actual data","Poisson curve", "qpois 99%"),
       col=c("red","green", "blue"), lty=1:2:3, cex=0.8)



legend(50, 0.06, legend=c("ATsweeps","qpois = 0.005", "qpois = 0.995"),
       col=c("red","green", "blue"), lty=1:1, cex=0.8)

plot(density(dpois(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH, 
                   mean(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH))),
     xlim = c(-0.002, 0.002))

plot(dpois(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH, 
           mean(filtered_site_mean_depth_chr1_AT.ldepth$MEAN_DEPTH)))

plot(dpois(depth, mean))