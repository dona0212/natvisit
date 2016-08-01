library(shiny)
library(leaflet)
library(rgdal)
setwd("C:/Users/Zoe/Dropbox/SMD_ParkVisit/Data")
park_pud <- readOGR("FlickrTwitter/ParkPUD_16Jul2015_proj.shp", "ParkPUD_16Jul2015_proj")
park_pud <- spTransform(park_pud, "+proj=longlat")

ui <- fluidPage(
  leafletOutput("flickr_map")
)


server <- function(input, output) {
#  pal <- colorNumeric(
#    palette = "Greens",
#    domain = log1p(park_pud$PUD_mean) 
#  )
  bounds <- bbox(park_pud)
  output$flickr_map <- renderLeaflet({
    leaflet(park_pud) %>%
      addProviderTiles("CartoDB.Positron") %>%
      fitBounds(bounds[1,1], bounds[2,1], bounds[1,2], bounds[2,2]) %>%
      addPolygons(color = "Green", stroke=FALSE, 
                  popup=~paste("Name of Park:", SIGNNAME, "<br/>", "Visitation:", PUD_mean))%>%
    addLegend("bottomleft", pal=pal, values=log1p(park_pud$PUD_mean), opacity=2)
  })
}

#0 - 12.9

shinyApp(ui, server)