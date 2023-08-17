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
