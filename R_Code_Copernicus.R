#COPERNICUS
#We use the European program -> Copernicus
#R code for downloading and visualizing Copernicus data 
library(raster)

#we download the package "ncdf4"
install.packages("ncdf4")

# Load the required packages
library(ncdf4)
library(ggplot2)
library(viridis)
library(raster)

#Import the working directory 
setwd("C:/lab/") #Windows

# register and download data from:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# Upload the data as a raster object
# dataset: c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc
ssoil <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")
ssoil
plot(ssoil)

# Coerce data into a dataframe
ssoil_d <- as.data.frame(ssoil, xy=T)

#Function which returns the first n rows of the dataset
head(ssoil)

# Columns' names of the dataframe
colnames(ssoil_d)

#Now plot with ggplot
 ggplot() +
   geom_raster(ssoil_d, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))
   #ggtitle: ("Surface.Soil.Moisture")
   
   # with viridis
 ggplot() +
  geom_raster(ssoil_d, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
  scale_fill_viridis(option="magma")
   
#Cropping an image 
#We cut out the study area practically -23 is the x maximum the y is 62 and 68 and these numbers
#I see them from the previous plotting with ggplot 
#We use the coordinates that is best for reproducibility
ext <- c(23, 30, 62, 68)
ext <- c(-23, 30, 62, 68)

ssoil_crop <- crop(ssoil, ext)
plot(ssoil_crop)
ssoil_crop
   
# Exercise: plot via ggplot the cropped image
ssoil.crop.d <- as.data.frame(ssoil_crop, xy=T)
head(ssoil.crop.d)
names(ssoil.crop.d)

ggplot() +
  geom_raster(ssoil.crop.d, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
  ggtitle("Cropped Soil Moisture from Copernicus") +
  scale_fill_viridis(option="cividis")
  
 
