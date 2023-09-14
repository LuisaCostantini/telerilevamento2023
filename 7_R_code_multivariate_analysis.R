# R code MULTIVARIATE ANALYSIS : how to reduce a multidimensional dataset

# Load the required packages
library(raster)
library(ggplot2)
library(viridis)

#Import the working directory 
setwd("C:/lab/") # Windows

# Exercise: import the Similaun image (glacier) 
sen <- brick("sentinel.png")
sen
plot(sen)

#We eliminate the 4th band because it's all yellow, so we use stack
# We combine the 3 bands (the first, the second and the third) with the function "stack"

sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])

plot(sen2)

#We use pairs for a comparison of various variables in our dataset
pairs(sen2)

# PCA (Principal Component Analysis) which we will do on a sample of pixels (same as for classification)
sample <- sampleRandom(sen2, 10000)
pca <- prcomp(sample)

# variance explained: 
summary(pca)

# The first component is the one with the highest variability

# Correlation with original bands
pca

# Pc map: we visualize starting from the analysis of the PCA
pci <- predict(sen2, pca, index=c(1:2))
plot(pci)
plot(pci[[1]])

# Plot using ggplot
pcid <- as.data.frame(pci[[1]], xy=T)

ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis() #yellow is always on top

#magma
ggplot() +
  geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis(option = "magma")

#Inferno 
ggplot() +
  geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis(option = "inferno")

# Focal standard deviation
sd3 <- focal(pci[[1]], matrix(1/9, 3, 3), fun = sd)

# Coerce into a dataframe
sd3d
sd3d <- as.data.frame(sd3, xy=T)

ggplot() +
  geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis()

# speeding up analyses
# aggregate cells: resampling (ricampionamento)
senres <- aggregate(sen, fact=10)

# then repeat the PCA analysis









