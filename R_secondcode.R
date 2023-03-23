Library(raster)
#Import 
l2011 <- brick("p224r63_2011.grd")
l2011

# plot
plot(l2011)
# https://www.r-graph-gallery.com/42-colors-names.html
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011, col=cl)

#Exercise : change the colour gamut for all the image 
#Exercise : plot the NIR band 
# b1 : blue
# b2 : green
# b3 : red 
# b4 : NIR 

# Export graphs in R 
pdf("myfirstgraph.pdf")
plot(l2011$B4_sre, col=cl)
dev.off()
# Plotting several bands in a multiframe 
par(mfrow=c(2,1))
plot(l2011[[1]])
plot(l2011[[2]])

par(mfrow=c(2,1))
plot(l2011$B1_sre, col=cl)
plot(l2011$B2_sre, col=cl)

par(mfrow=c(2,2))
#plot blue
clb <- colorRampPalette(c("cyan", "blue2", "blue4")) (100) #100 sono le sfumature
plot(l2011$B1_sre, col=clb)
#plot green
clg <- colorRampPalette(c("chartreuse4", "chartreuse2", "chartreuse")) (100) #100 sono le sfumature
plot(l2011$B2_sre, col=clg)
#plot red
clr <- colorRampPalette(c("brown", "brown3", "brown4")) (100) #100 sono le sfumature
plot(l2011$B3_sre, col=clr)
#plot NIR
cln <- colorRampPalette(c("azure", "azure4", "black")) (100) #100 sono le sfumature
plot(l2011$B4_sre, col=cln)
dev.off()

# RGB plotting 
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

# Multiframe with natural and false colors 
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

#Hinstogram stretching
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

par(mfrow=c(2,1))
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")
dev.off()
#Exercise: plot the NIR band 
plot(l2011[[4]])


# Import data, setting the working directory 
setwd("C:/lab/") #for windows
library(raster) 

#Import the 1988 image 
setwd("C:/lab/")

brick("p224r63_1988_masked.grd")
l1988 <- brick("p224r63_1988_masked.grd")

plot(l1988)
# Exercise: plot in RGB space (natural colors) 
plotRGB(l1988, r=3, g=2, b=1, stretch="lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")

#multiframe 
par(mfrow=c(2,1))

plotRGB(l1988, 4, 3, 2, stretch="lin")
plotRGB(l2011, 4, 3, 2, stretch="lin")

par(mfrow=c(2,2))
plotRGB(l1988, 4, 3, 2, stretch="lin")
plotRGB(l2011, 4, 3, 2, stretch="lin")

plotRGB(l1988, 4, 3, 2, stretch="Hist")
plotRGB(l2011, 4, 3, 2, stretch="Hist")
