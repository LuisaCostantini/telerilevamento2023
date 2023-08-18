# Time series analysis...

# Greenland increase of temperature
# Data and code from Emanuela Cosma

# R code for importing and analysing several image 
library(raster)
library(rasterVis)
library(rgdal)

#Import the working directory 
setwd("C:/lab/Greenland") # for Windows 

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

#Exercise: import all the data (tif images)
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

ls() # list of objects imported and loaded

# list f files: I make the list of files that are inside the folder and I can import all files at the same time with lPPLY
rlist <- list.files(pattern="lst")
rlist

# to apply a function to many files of a list : will be the 4 images my import, we applied the raster function to the whole list 
import <- lapply(rlist,raster)
import

# plotting in a multiframe
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# stack takes the 4 images and puts them together a single object as a satellite image
TGr <- stack(import) 
TGr
plot(TGr)

#Plot with RGB
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

#levelplot(TGr, col.regions = cl,
          names.attr = c("July 2000","July 2005", "July 2010", "July 2015"))
#levelplot(TGr, col.regions = cl, main = "LST variation in time",
          names.attr = c("July 2000","July 2005", "July 2010", "July 2015"))



# NO2 decrease during the lockdown period ----
#---- Exercise 2: European N02 

library(raster)

#New working directory
setwd("C:/lab/en")

#importing a file (first image file)
en01 <- raster("EN_0001.png")
plot(en01) # it's January, before the lockdown

# Plot using a colour palette
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(en01, col=cl) 

# Import and plot the last image 
en13 <- raster("EN_0013.png")
plot(en13, col = cl) # <- it's March, after lockdown began

# Exercise: import the whole as in the Greenland example
# by the following steps: list.files, lapply, stack

# Let's import the whole set 
rlist <- list.files(pattern="EN")
rlist

# lapply(X, FUN)
rimp <- lapply(rlist, raster)
rimp

# stack
en <- stack(import)
en

# Plot everything
plot(en) 

# Exercise: plot EN01 besides EN13
par(mfrow=c(1,2))
plot(en[[1]], col=cl)
plot(en[[13]], col=cl)

# Check 2 
difcheck <- en01- en[[1]]
difcheck 

# or:
en113 <- stack(en[[1]], en[[13]])
plot(en113, col=cl)

# let's make the difference:
difen <-  en[[1]] - en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(difen, col=cldif)

# plotRGB of three files together
plotRGB(en, r=1, g=7, b=13, stretch="lin")
plotRGB(en, r=1, g=7, b=13, stretch="hist")
dev.off

