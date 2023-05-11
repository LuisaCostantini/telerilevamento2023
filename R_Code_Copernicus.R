#We use the European program -> Copernicus
#R code for downloading and visualizing Copernicus data 
library(raster)
#we download the package "ncdf4"

install.packages("ncdf4")
library(ncdf4)

library(ggplot2)

library(viridis)

#Import the working directory 
setwd("C:/lab/")
