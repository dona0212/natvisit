library(shiny)
library(leaflet)
setwd("C:/Users/Zoe/Dropbox/SMD_ParkVisit/Data")
park_pud <- readOGR("FlickrTwitter/ParkPUD_16Jul2015_proj.shp", "ParkPUD_16Jul2015_proj")
park_pud <- spTransform(park_pud, "+proj=longlat")

ui <- fluidPage(
  leafletOutput("flickr_map")
)


server <- function(input, output) {
  pal <- colorQuantile(
    palette="Greens",
    domain = park_pud$PUD_mean, n=7
  )
  output$flickr_map <- renderLeaflet({
  leaflet(park_pud) %>%
      #
    addProviderTiles("CartoDB.Positron") %>%
    addPolygons(color = ~pal(PUD_mean), stroke=FALSE)
  })
}

shinyApp(ui, server)
