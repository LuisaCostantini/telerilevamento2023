# First lesson of Remote Sensing in GitHub: how to plot images
# Let's install the raster package
install.packages("raster)
library(raster)

# Import data, setting the working directory 
setwd("C:/lab/") #for windows 

# Brick function to import the data
brick("p224r63_2011_masked.grd")
image <- brick("p224r63_2011_masked.grd")
image # to get information about the image 
# a RasterBrick is a multi-layer raster object

#Plotting the data in a savage manner
plot(image)

# Colour Palette
cl <- colorRampPalette(c("red", "orange", "yellow"))(100) # 100 are the shades
clb <- colorRampePalette(c("dark blue", "blue", "light") (100)
plot(image, col =cl)

#Plotting one element 
plot(image,[[4]] col =cl) # for the elements I put []
image

plot(image$B4_sre, col=cl)

nir <- image[[4]]
plot(nir, col=cl)

#Exercise : Change of palette
new_palette <- colorRampPalette(c("aquamarine", "cadetblue", "cyan")) (100)
plot(image, col = new_palette)
plot(image[[4]], col = new_palette) # the fourth layer
dev.off()  # it closes graphs

# Exercise: plot the NIR band
# b1 = blue
# b2 = green
# b3 = red
# b4 = NIR

# New colour palette
palette <- colorRampPalette(c("pink", "violet", "darkorchid4")) (100)

# Plot the NIR band of the image in different ways
plot(image$B4_sre, col = new_palette)
plot(image[[4]], col = palette) 

dev.off() 

# Export graphs in R
pdf("myfirstgraph.pdf")
plot(image$B4_sre, col=cl)
dev.off()

# Plotting several bands in a multiframe
par(mfrow=c(2,1))
plot(image[[3]], col=cl) #RED
plot(image[[4]], col=cl) #NIR
dev.off()

# Plotting the first 4 layers / bands
par(mfrow=c(2,2))

# blue
clb <- colorRampPalette(c("blue4","blue2","light blue"))(100) # 100 sono le sfumature
plot(image[[1]], col=clb)

#green
clg <- colorRampPalette(c("chartreuse4","chartreuse2","chartreuse"))(100) # 100 sono le sfumature
plot(image[[2]], col=clg)

#coral
clr <- colorRampPalette(c("coral3","coral1","coral"))(100) # 100 sono le sfumature
plot(image[[3]], col=clr)

#purple
cln <- colorRampPalette(c("darkorchid4","darkorchid2","darkorchid4"))(100) # 100 sono le sfumature
plot(image[[4]], col=cln)

# RGB plotting, plot of multi-layered raster object
plotRGB(image, r=3, g=2, b=1, stretch="Lin") # natural colours 
plotRGB(image, r=4, g=3, b=2, stretch="Lin") # vegetation is red 
plotRGB(image, r=3, g=4, b=2, stretch="Lin") # vegetation is blue
plotRGB(image, r=3, g=2, b=4, stretch="Lin") # vegetation is green 
# # the fourth band is the NIR band, plants strongly reflect NIR 

# Multiframe with natural and false colours
par(mfrow=c(2,1))
plotRGB(image, r=3, g=2, b=1, stretch="Lin")
plotRGB(image, r=4, g=3, b=2, stretch="Lin")

# Histogram stretching
par(mfrow=c(2,1))
plotRGB(image, r=3, g=2, b=1, stretch="Hist")
plotRGB(image, r=4, g=3, b=2, stretch="Hist")

# Linear vs. Histogram stretching
par(mfrow=c(2,1))
plotRGB(image, r=4, g=3, b=2, stretch="Lin")
plotRGB(image, r=4, g=3, b=2, stretch="Hist")

# Exercise: plot the NIR band
plot(image[[4]])

plotRGB(image, r=3, g=2, b=1, stretch="Lin")
plotRGB(image, r=4, g=3, b=2, stretch="Lin")
plotRGB(image, r=3, g=4, b=2, stretch="Lin")
plotRGB(image, r=3, g=2, b=4, stretch="Lin")

dev.off()
# Exercise: import the 1988 image
image_1988 <- brick("p224r63_1988_masked.grd")

# Exercise: plot in RGB space (natural colours)
plotRGB(image_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(image_1988, r=4, g=3, b=2, stretch="Lin")

plotRGB(image_1988, 4, 3, 2, stretch="Lin")

# multiframe
par(mfrow=c(2,1))
plotRGB(image_1988, 4, 3, 2, stretch="Lin")
plotRGB(image, 4, 3, 2, stretch="Lin")
dev.off()
plotRGB(image_1988, 4, 3, 2, stretch="Hist")

# multiframe with 4 images
par(mfrow=c(2,2))
plotRGB(image_1988, 4, 3, 2, stretch="Lin")
plotRGB(image, 4, 3, 2, stretch="Lin")
plotRGB(image_1988, 4, 3, 2, stretch="Hist")
plotRGB(image, 4, 3, 2, stretch="Hist")
