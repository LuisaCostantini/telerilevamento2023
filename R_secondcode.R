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
