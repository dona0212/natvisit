library(shiny)
library(leaflet)
library(rgdal)
library(dplyr)
library(sp)
library(ggplot2)
library(foreign)
setwd("C:/Users/Zoe/Dropbox/SMD_ParkVisit/Data")
park_pud <- readOGR("FlickrTwitter/ParkPUD_16Jul2015_proj.shp", "ParkPUD_16Jul2015_proj")
park_pud <- spTransform(park_pud, "+proj=longlat")
#-----------------NEW LINE
soc_media <- read.dta("FlickrTwitter/8_orig.dta")

#innerjoin(park_pud, soc_media, PID)



#in ui -- click = 
ui <- fluidPage(
  leafletOutput("flickr_map", width = 900, height = 1200)
)


server <- function(input, output) {
  pal <- colorNumeric(
    palette = "Greens",
    domain = log1p(park_pud$PUD_mean) 
  )
  bounds <- bbox(park_pud)
  output$flickr_map <- renderLeaflet({
    leaflet(park_pud) %>%
      addProviderTiles("CartoDB.Positron") %>%
      fitBounds(bounds[1,1], bounds[2,1], bounds[1,2], bounds[2,2]) %>%
      #JOIN HERE?????
      innerjoin(park_pud, soc_media, PID)
     #JOIN HERE?????
      addPolygons(color = ~pal(log1p(PUD_mean)), stroke=FALSE, 
                  fillOpacity = .8,
                  popup=~paste("<b>Name of Park:</b>", SIGNNAME, "<br/>", "<b>Visitation:</b>", PUD_mean, "Flicker photo user days")) %>%
#    addLegend("bottomleft", pal=pal, values=log1p(park_pud$PUD_mean), opacity=2)
    addPolygons(data=park_tud, group=)
  })
}

#0 - 12.9

#shinyApp(ui, server)