#How to measure landscape variability witch R 

library(raster)
library(patchwork)
library(ggplot2)

#Import the working directory 
setwd("C:/lab/")

# Exercise: import the Similaun image
sen <- brick("sentinel.png")

# band1 = NIR
# band2 = red
# band3 = green

# Exercise: plot the image by the ggRGB function
plotRGB(sen, 1, 2, 3, stretch="lin")

# NIR on g component
plotRGB(sen, 2, 1, 3)

#standard deviation on the NIR band 
nir <- sen[[1]]
mean3 <- focal(nir, matrix(1/9, 3, 3), fun=mean)
plot(mean3)

nir <- sen[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(sd3, col=clsd)

# plotting with ggplot
sd3d <- as.data.frame(sd3, xy=T)

ggplot() +
  geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer))

# with viridis
ggplot() +
  geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("Standard deviation by viridis package")

# cividis
ggplot() +
  geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("Standard deviation by viridis package")

# magma
ggplot() +
  geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("Standard deviation by viridis package")

# inferno
ggplot() +
  geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation by viridis package")

# patchwork
p1 <- ggplot() +
  geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("Standard deviation by viridis package")

p2 <- ggplot() +
  geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation by viridis package")

p1 + p2






