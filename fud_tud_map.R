
setwd("C:/Users/Zoe/Dropbox/SMD_ParkVisit/Data")
library(tmap)
library(raster)
library(sp)
library(rgdal)
park_pud <- readOGR("FlickrTwitter/ParkPUD_16Jul2015_proj.shp", "ParkPUD_16Jul2015_proj")
boundary <- readOGR("Boundary/Boroughs_proj.shp", "Boroughs_proj")
#park_tud2 <- park_tud[-c(1732, 1856),]
#qtm(park_tud2)

#park_pud <- readOGR("FlickrTwitter/ParkPUD_16Jul2015.shp", "ParkPUD_16Jul2015")
qtm(park_pud)
#qtm(park_pud, fill="PUD_m", text=iso(a3), text.size = area, root=5, fill.title = "Flicker photo user days (yearly mean) 2005-2014")
#qtm(park_pud, fill="PUD_m", text.size = area, root=5, fill.title = "Flicker photo user days (yearly mean) 2005-2014")
qtm(park_pud, fill="PUD_mean", text.size = area, root=5, fill.title = "Flicker photo user days (yearly mean) 2005-2014")
#to display attribute table
View(park_pud)
#to display values of variables
park_pud$PUD_mean
#to display all variables
colnames(park_pud@data)


#Making maps with multiple layers and nice symbology :-)
#data(boundary, park_pud)
flickr_map <- tm_shape(boundary)+
  tm_polygons(col="white") +
  tm_shape(park_pud) +
  tm_polygons("PUD_mean", palette = "Greens", contrast = .7, style="jenks")
print(flickr_map)
data("World")