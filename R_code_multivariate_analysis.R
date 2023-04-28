# R code multivariate analysis 
#How to reduce a multidimensional dataset 

library(raster)
library(ggplot2)
library(viridis)

#Import the working directory 

setwd("C:/lab/") # Windows

# Exercise: import the Similaun image (glacier) 

sen <- brick("sentinel.png")
sen
plot(sen)

# We combine the 3 bands (the first, the second and the third) with the function "stack"

sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])

plot(sen2)

#We use pairs for a comparison of various variables in our dataset
pairs(sen2)

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000)
pca <- prcomp(sample)

# variance explained: 
summary(pca)

# correlation with original bands
pca

# pc map: we visualize starting from the analysis of the pca
pci <- predict(sen2, pca, index=c(1:2))
plot(pci)
plot(pci[[1]])

# ggplot
pcid <- as.data.frame(pci[[1]], xy=T)

ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis()

#magma
ggplot() +
  geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis(option = "magma")

#Inferno 
ggplot() +
  geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis(option = "inferno")


# speeding up analyses
# aggregate cells: resampling (ricampionamento)
senres <- aggregate(sen, fact=10)

# then repeat the PCA analysis









