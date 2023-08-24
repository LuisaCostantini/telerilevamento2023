# Species Distribution Modelling
#R code distribution modelling 
install.packages("sdm")
install.packages("rgdal", dependencies=T)

library(sdm)
library(raster) # predictors
library(rgdal) #species; to manage your vector type data (points)

file <- system.file("external/species.shp", package="sdm")
file
species <- shapefile(file)

# looking at the set
species

# plot
plot(species)
plot(species, pch=19)

# looking at the occurrences  if there is a species then the presence or absence of a species the values are either 0 -> absent, instead 1 (point) the species I sampled is present 
species$Occurrence

#We take those points where the occurrence is worth 1 then the presence of the species and plot
presences <- species[species$Occurrence == 1,]
presences #94 attendance of the entire dataset 
plot(presences, col='blue',pch=16)

#Let’s see now the absences (where it is 0 so) and plot 
#There are 106 absences 
absences <- species[species$Occurrence == 0,]
absences
plot(absences, col='red',pch=16)

#Now we plot together the presences and absences 
plot(species[species$Occurrence == 1,],col='blue',pch=16) #presences
points(species[species$Occurrence == 0,],col='red',pch=16)#absences

# predictors: look at the path
path <- system.file("external", package="sdm")

# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

# stack
preds <- stack(lst)
preds
plot(preds) 

#preds are environmental variables and are related to predictions 
# plot preds 
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=19)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=19)#this species loves medium/high t 

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=19)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=19)#Species that prefers areas with highest plant cover 

# model to see how to create a continuous map of species distribution in space 
#Species data on the ground are called train and predictors are environmental
# set the data for the sdm

datasdm <- sdmData(train=species, predictors=preds)
datasdm

# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
m1

# make the raster output layer 
# predict creates a map of species distribution
p1 <- predict(m1, newdata=preds)
p1

# plot the output
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=19)

# add to the stack : with stack I put all environmental variables (preds) together and plotted 
s1 <- stack(preds,p1)
plot(s1, col=cl)

#I change variable names in the final plot and reassign names to the stack and plot again  
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
plot(s1, col=cl)
