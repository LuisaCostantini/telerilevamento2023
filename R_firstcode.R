# My first code in Git Hub 
# let's install the raster package
install.packages("raster)
library(raster)

# Import data, setting the working directory 
setwd("C:/lab/") #for windows 

brick("p224r63_2011_masked.grd")

#image <- brick("p224r63_2011_masked.grd")

#plotting the data in a savage manner
plot(image)

colorRampPalette(c("red", "orange", "yellow"))(100) #100 sono le sfumature 

clb <- colorRampePalette(c("dark blue", "blue", "light") (100)

plot(image, col =clb)

#plotting one element 
plot(image,[[4]] col =clb)

plot(image$B4_sre, col=cl)

nir <- image[[4]]
