# 3D in R 
#usiamo dei dati sulla copertura forestale della provincia di Bolzano 

#Set working directory
setwd("C:/lab/dati")

library(raster) #"Geographic Data Analysis and Modeling"
library(rgdal) #"Geospatial Data Abstraction Library"
library(viridis)
library(ggplot2)
library(patchwork)

# load dsm 2013
dsm_2013 <- raster("C:/lab/dati/2013Elevation_DigitalElevationModel-0.5m.tif")
#dsm modello digitale solito : dei solidi che escono dal terreno 

# view info about the raster.
#DSM è il modello digitale della superficie 
dsm_2013

head(dsm_2013)

tail(dsm_2013)

str(dsm_2013)

# plot the DSM 2013
plot(dsm_2013, main="Lidar Digital Surface Model San Genesio/Jenesien")

#creiamo un dataframe 
dsm_2013d <- as.data.frame(dsm_2013, xy=T)
dsm_2013d
head(dsm_2013d)

#facciamo un gg plot 
ggplot() +
  geom_raster(dsm_2013d, mapping =aes(x=x, y=y, fill= X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle(" X2013Elevation_DigitalElevationModel.0.5m")

#DTM modello ditigale del terreno 
# load dtm 2013 
dtm_2013 <- raster("C:/lab/dati/2013Elevation_DigitalTerrainModel-0.5m.tif")

#plot dtm 2013 
plot(dtm_2013, main="Lidar Digital Terrain Model San Genesio/Jenesien")

#facciamo anche qui un dataframe
dtm_2013d <- as.data.frame(dtm_2013, xy=T)
dtm_2013d
head(dtm_2013d)

#facciamo un plot 
ggplot() +
  geom_raster(dtm_2013d, mapping =aes(x=x, y=y, fill=  X2013Elevation_DigitalTerrainModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle(" X2013Elevation_DigitalTerrainModel.0.5m")
  
  #with magma
ggplot() +
  geom_raster(dtm_2013d, mapping =aes(x=x, y=y, fill=  X2013Elevation_DigitalTerrainModel.0.5m)) +
  scale_fill_viridis(option = "magma") +
  ggtitle(" X2013Elevation_DigitalTerrainModel.0.5m")
  
  # create CHM 2013 as difference between dsm and dtm
chm_2013 <- dsm_2013 - dtm_2013 #altezza dei singoli oggetti es alberi, case, frane ecc 

# view CHM attributes
chm_2013

#creiamo un dataframe 
chm_2013d <- as.data.frame(chm_2013, xy=T)

head(chm_2013d)

chm_2013

plot(chm_2013)

names(chm_2013d)

#plottiamo chm 
ggplot() +
geom_raster(chm_2013d, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("chm 2013")

#with inferno 
ggplot() +
  geom_raster(chm_2013d, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("chm 2013")

#save the CHM on computer
writeRaster(chm_2013,"chm_2013_San_genesio.tif")

#ora con patchwork plottiamoli tutti e 3 insieme (dsm,dtm,chm)
p1 <- ggplot() +
  geom_raster(dsm_2013d, mapping =aes(x=x, y=y, fill= X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle(" X2013Elevation_DigitalElevationModel.0.5m")

p2 <- ggplot() +
  geom_raster(dtm_2013d, mapping =aes(x=x, y=y, fill=  X2013Elevation_DigitalTerrainModel.0.5m)) +
  scale_fill_viridis(option = "magma") +
  ggtitle(" X2013Elevation_DigitalTerrainModel.0.5m")

p3 <- ggplot() +
  geom_raster(chm_2013d, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("chm 2013")

# with patchwork:
p1 + p2 + p3
