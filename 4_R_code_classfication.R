#Classification of remote sensing data via RStoolbox

# Installing dev tools 
install.packages("devtools")
library(devtools)

devtools::install_github("bleutner/RStoolbox")

library(raster)

# Set the working directory in Windows
setwd("C:/lab/") 

# Data import (image of the sun) and visualize them
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")
so

# Classifying the solar data:

#----1. Get all the single values
# takes values from an image and puts them on the printout 
singlenr <- getValues(so)
singlenr

#takes every single pixel and puts it in tabular form, that is, the reflectances of all the bands
# set.seed(99)

#----2. Classify kmeans 
# group pixels based on classes, means is medium, k as the symbol n means a tot, let’s make 3 classes = 3 centroids)
kcluster <- kmeans(singlenr, centers = 3)
kcluster

#----3. Set values to a raster on the basis of the sun image
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object
#We combine kcluster and cluster with dollar, the function sets the corresponding values spatially to so, first element
#putting the class values 

# Plot using a colour palette
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

#class 1 : highest energy level 21.2%
#class 2 : medium energy level 41.4%
#class 3 : lowest energy level 37.7%

#We now use a function that calculates a frequency of these 3 classes
# What is the pixel size of high energy level? Talking about frequencies
frequencies <- freq(sun_class)
frequencies
tot <- 2221440 # function for the total number of pixels/cells of an image
percentages <- round((frequencies*100)/tot, digits = 5)
percentages #count columns are the perc frequencies

#DAY 2 
#---- GRAND CANYON ----
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

# red = 1 
# green = 2 
# blue = 3

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# Change the stretch to histogram stretching
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# The image is quite big; so crop it!
gc_crop <- crop(gc, drawExtent())
plotRGB(gc_crop, 1, 2, 3, stretch = "lin")

ncell(gc)   # n of pixels of the original image
ncell(gc_crop)   # n of pixels of the cropped image

# Classification :

# 1. Get values
singlenr <- getValues(gc)
singlenr

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values
gcclass <- setValues(gc[[1]], kcluster$cluster) # assign new values to a raster object

# Plot with colour palette
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(gcclass, col=cl)

# class 1: volcanic rocks
# class 2: sandstone
# class 3: conglomerates

frequencies <- freq(gcclass)
tot = 58076148
percentages = frequencies * 100 /  tot
percentages 

# Exercise: classify the map with 4 classes
singlenr_2 <- getValues(gc_crop)
singlenr_2

kcluster_2 <- kmeans(singlenr_2, centers = 4)
kcluster_2

gcclass_2 <- setValues(gc_crop[[1]], kcluster_2$cluster)

cl <- colorRampPalette(c('yellow','black','red', 'blue'))(100)
plot(gcclass_2, col=cl)

frequencies <- freq(gcclass_2)
frequencies
tot <- ncell(gcclass_2)
percentages = frequencies * 100 /  tot
percentages
