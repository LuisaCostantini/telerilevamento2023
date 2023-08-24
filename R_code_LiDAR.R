# LIDAR : 3D in R 
# is a method for determining ranges by targeting an object or a surface
#Lidar data is laser data 
#Source inside the sensor that receives a signal 
#If an object is higher the return signal is lower
#With this mechanism you can accommodate any component in 3 sizes

#We use data on the forest coverage of the province of Bolzano 

#Set working directory
setwd("C:/lab/dati") #Windows

# Load the required packages
library(raster) #"Geographic Data Analysis and Modeling"
library(rgdal) #"Geospatial Data Abstraction Library"
library(viridis)
library(ggplot2)
library(patchwork)

# ----Digital Surface Model 2013  
#Load dsm 2013
dsm_2013 <- raster("C:/lab/dati/2013Elevation_DigitalElevationModel-0.5m.tif")
#dsm usual digital model : solids coming out of the ground 

#View info about the raster.
dsm_2013
head(dsm_2013)
tail(dsm_2013)
str(dsm_2013)

# Plot the DSM 2013
plot(dsm_2013, main="Lidar Digital Surface Model San Genesio/Jenesien")

# Coerce the DSM 2013 into a dataframe
dsm_2013d <- as.data.frame(dsm_2013, xy=T)
dsm_2013d
head(dsm_2013d)

# Plot with ggplot
ggplot() +
  geom_raster(dsm_2013d, mapping =aes(x=x, y=y, fill= X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle(" X2013Elevation_DigitalElevationModel.0.5m")

#----Digital Terrain Model 2013

# Load dtm 2013 
dtm_2013 <- raster("C:/lab/dati/2013Elevation_DigitalTerrainModel-0.5m.tif")

#Plot dtm 2013 
plot(dtm_2013, main="Lidar Digital Terrain Model San Genesio/Jenesien")

# Coerce the DTM 2013 into a dataframe
dtm_2013d <- as.data.frame(dtm_2013, xy=T)
dtm_2013d
head(dtm_2013d)

 # Plot with ggplot
ggplot() +
  geom_raster(dtm_2013d, mapping =aes(x=x, y=y, fill=  X2013Elevation_DigitalTerrainModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle(" X2013Elevation_DigitalTerrainModel.0.5m")
  
  #with magma
ggplot() +
  geom_raster(dtm_2013d, mapping =aes(x=x, y=y, fill=  X2013Elevation_DigitalTerrainModel.0.5m)) +
  scale_fill_viridis(option = "magma") +
  ggtitle(" X2013Elevation_DigitalTerrainModel.0.5m")

#----Canopy Height Model 2013
# Create CHM 2013 as difference between dsm and dtm
chm_2013 <- dsm_2013 - dtm_2013 #altezza dei singoli oggetti es alberi, case, frane ecc 

# view CHM attributes
chm_2013
head(chm_2013d)
names(chm_2013d)

# Coerce the CHM 2013 into a dataframe
chm_2013d <- as.data.frame(chm_2013, xy=T)

#Plot with ggplot
ggplot() +
geom_raster(chm_2013d, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("chm 2013")

#with inferno 
ggplot() +
  geom_raster(chm_2013d, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("chm 2013")

#Save the CHM on computer
writeRaster(chm_2013,"chm_2013_San_genesio.tif")

#Now with patchwork plott all 3 together (dsm,dtm,chm)
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



#----Digital Surface Model 2004
#Load dsm 2004
dsm_2004 <- raster("C:/lab/dati/2004Elevation_DigitalElevationModel-2.5m.tif")

#View info about the raster.
dsm_2004

# Plot the DSM 2004
plot(dsm_2004, main="Lidar Digital Surface Model San Genesio/Jenesien")

#----Digital Terrain Model 2004 
# Load dtm 2004
dtm_2004 <- raster("C:/lab/dati/2004Elevation_DigitalTerrainModel-2.5m.tif")

# Plot dtm 2004
plot(dtm_2004, main="Lidar Digital Terrain Model San Genesio/Jenesien")

# Create CHM 2004 as difference between DSM and DTM
chm_2004 <- dsm_2004 - dtm_2004

# View CHM attributes
chm_2004

# Coerce into a dataframe
chm_2004d <- as.data.frame(chm_2004, xy=T)

#Plot CHM 2004
ggplot() +
  geom_raster(chm_2004d, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2004 San Genesio/Jenesien")

#save CHM on computer
writeRaster(chm_2004,"chm_2004_San_genesio.tif")


#error
difference_chm<-chm_2013-chm_2004

#reseample 2013 to 2004 @2.5m
chm_2013_reseampled<-resample(chm_2013, chm_2004)

#calculate difference in CHM
difference<-chm_2013_reseampled-chm_2004

#plot the difference
ggplot() +
  geom_raster(difference, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("difference CHM San Genesio/Jenesien")

#save the rasters
writeRaster(chm_2013_reseampled,"chm_2013_reseampled_San_genesio.tif")
writeRaster(difference,"difference chm San_genesio.tif")
