#Classification of remote sensing data via RStoolbox
# Installing dev tools 

install.packages("devtools")
library(devtools)

devtools::install_github("bleutner/RStoolbox")

library(raster)

setwd("C:/lab/") 

# data import
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")
