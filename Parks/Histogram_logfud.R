#install.packages("ggplot2")
library(ggplot)

#Flickr User Days
socmed = read.csv("C:/Users/Zoe/Dropbox/SocialMediaNatCap/Analysis/Graphics/data/soc_media.csv")
pdf("C:/Users/Zoe/Dropbox/SocialMediaNatCap/Analysis/Graphics/outputs/logfud.pdf", width = 3.75, height = 4)
mar.orig <- par()$mar # save the original values
par(mar = c(4,4,1,1)) # set your new values; family options are "serif", "mono", "symbol", "sans"
hist(socmed$logfud,
     main=NULL,
     xlab= "log(Flickr Photo Days/year)",
     ylab= "Frequency",
     border="white",
     col="azure4",
     cex.axis=0.7,
     cex.lab=0.7)
dev.off()


#Twitter User Days
socmed = read.csv("C:/Users/Zoe/Dropbox/SocialMediaNatCap/Analysis/Graphics/data/soc_media.csv")
pdf("C:/Users/Zoe/Dropbox/SocialMediaNatCap/Analysis/Graphics/outputs/logtud.pdf", width = 3.75, height = 4)
mar.orig <- par()$mar # save the original values
par(mar = c(4,4,1,1)) # set your new values; family options are "serif", "mono", "symbol", "sans"
hist(socmed$logtud,
     main=NULL,
     xlab= "log(Twitter User Days/year)",
     ylab= "Frequency",
     border="white",
     col="azure4",
     cex.axis=0.7,
     cex.lab=0.7)
dev.off()