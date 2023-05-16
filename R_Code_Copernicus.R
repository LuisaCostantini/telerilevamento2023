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

dataset: c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc

ssoil <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")

ssoil

plot(ssoil)

ssoil_d <- as.data.frame(ssoil, xy=T)

head(ssoil)

 ggplot() +
   geom_raster(ssoil_d, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))
   #ggtitle: ("Surface.Soil.Moisture")
   
   # with viridis
 ggplot() +
  geom_raster(ssoil_d, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
  scale_fill_viridis(option="magma")
   
   #Cropping an image 
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
  
 
