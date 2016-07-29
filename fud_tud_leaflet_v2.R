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
soc_media <- read.csv("FlickrTwitter/orig_8.csv")

park_pud@data$PID <- as.integer(park_pud@data$PID)

#pud_df <- as.data.frame(park_pud@data)

#final_df <- left_join(pud_df, soc_media, "PID")

park_pud@data <- left_join(park_pud@data, soc_media, "PID")

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
      addPolygons(color = ~pal(log1p(PUD_mean)), stroke=FALSE, 
                  fillOpacity = .8,
                  popup=~paste("<b>Name of Park:</b>", SIGNNAME, "<br/>", "<b>Visitation:</b>", PUD_mean, "(Flicker photo user days)", "<br/>",
#                               "<b># of Facilities:</b>", Tot_Facilities, "<br/>",
                               "<b>%Green:</b>", as.integer(GREEN_PER*100), "<br/>",
                               "<b>Median household income:</b>", "$",as.integer(HHD_Income1000*1000), "<br/>",
                               "<b>Median property value:</b>", as.integer(propval_med)))
#                             "<b>%Impervious Surface:</b>", as.integer(Per_impsurf*100)))
#    addLegend("bottomleft", pal=pal, values=log1p(park_pud$PUD_mean), opacity=2)
#    addPolygons(data=park_tud, group=)
})
}

#0 - 12.9

shinyApp(ui, server)