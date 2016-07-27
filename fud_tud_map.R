
setwd("C:/Users/Zoe/Dropbox/SMD_ParkVisit/Data")
library(tmap)
park_pud <- readOGR("FlickrTwitter/ParkPUD_16Jul2015_proj.shp", "ParkPUD_16Jul2015_proj")
#park_tud2 <- park_tud[-c(1732, 1856),]
#qtm(park_tud2)

park_pud <- readOGR("FlickrTwitter/ParkPUD_16Jul2015.shp", "ParkPUD_16Jul2015")
qtm(park_pud)