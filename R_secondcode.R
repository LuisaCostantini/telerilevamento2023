Library(raster)
#Import ........

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

