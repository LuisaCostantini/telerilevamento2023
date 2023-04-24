# Time series analysis...

# Greenland increase of temperature
# Data and code from Emanuela Cosma

# R code for importing and analysing several image 
library("raster")

#Import the working directory 

setwd("C:/lab/Greenland") 

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

#Exercise: import all the data (tif images)
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

ls() # list of objects imported and loaded

# list f files:
rlist <- list.files(pattern="lst")
rlist

# to apply a function to many files of a list
import <- lapply(rlist,raster)
import


# plotting in a multiframe
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

TGr <- stack(import) 
TGr
plot(TGr)

plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

# levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(TGr, col=cl)
dev.off()

#Difference between 2005 and 2000 : 

dift <- TGr[[2]] - TGr [[1]]
dift  = TGr [[2]] - TGr [[1]]
plot(dift)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(dift, col=cl)

# levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(TGr, col = cl)

levelplot(TGr, col.regions = cl,
          names.attr = c("July 2000","July 2005", "July 2010", "July 2015"))
levelplot(TGr, col.regions = cl, main = "LST variation in time",
          names.attr = c("July 2000","July 2005", "July 2010", "July 2015"))

dev.off()

# NO2 decrease during the lockdown period ----
#---- Exercise 2: European N02 

library(raster)

setwd("C:/lab/en")

#importing a file (first image file)
en01 <- raster("EN_0001.png")

cl <- colorRampPalette(c('red','orange','yellow'))(100) #

plot(en01, col=cl) # ->  it's January, before the lockdown

en13 <- raster("EN_0013.png")

plot(en13, col = cl) # <- it's March, after lockdown began

# Let's import the whole set (altogether!)

# Exercise: import the whole as in the Greenland example
# by the following steps: list.files, lapply, stack

rlist <- list.files(pattern="EN")

rlist

# lapply(X, FUN)
rimp <- lapply(rlist, raster)


import <- lapply(rlist,raster)
import

# stack
EN <- stack(import)
EN

plot(EN) #plot everything

# Exercise: plot EN01 besides EN13
par(mfrow=c(1,2))
plot(EN[[1]], col=cl)
plot(EN[[13]], col=cl)

# Check 2 
difcheck <- - EN[[1]]
difcheck 
# or:
en113 <- stack(EN[[1]], EN[[13]])
plot(EN113, col=cl)

# let's make the difference:
difen <-  EN[[1]] - EN[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(difen, col=cldif)

# plotRGB of three files together
plotRGB(EN, r=1, g=7, b=13, stretch="lin")
plotRGB(EN, r=1, g=7, b=13, stretch="hist")
dev.off

