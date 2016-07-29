library(rgdal)
library(shiny)
library(leaflet)
library(RColorBrewer)

setwd("C:/Users/dona0212/Documents/SESYNCsandbox/natvisit/public_data")
parkshp <- readOGR("TCParks/TCPark_TUDPUD.shp", "TCPark_TUDPUD")
parkshp <- spTransform(parkshp, "+proj=longlat")

ui <- fluidPage(
  titlePanel("Social Media Visitation to Parks in the Twin Cities, MN"),
  sidebarPanel(
    p("Select a park from the map at the right to explore its social media visitation from Flickr."),
               style = "font-family: 'verdana'; font-si12pt", align = "center"),
  mainPanel("",
  leafletOutput("flickr_map", width = 500, height = 300), width = 700))

server <- function(input, output, session) {
  pal <- colorNumeric(
    palette="Greens",
    domain = log1p(parkshp$PUD_mean))
  
  bounds <- bbox(parkshp)
 
  output$flickr_map <- renderLeaflet({
  leaflet(parkshp) %>%
    addProviderTiles("CartoDB.Positron") %>%
    fitBounds(bounds[1,1], bounds [2,1], bounds[1,2], bounds [2, 2]) %>%
      addPolygons(color = ~pal(log1p(PUD_mean)), stroke=FALSE, fillOpacity = 0.75,
                  popup=~paste("<b>Name of Park:</b>", ParkName, "<br/>", "<b>Visits:</b>", 
                               PUD_mean, "Flickr photo user days"))
    })
}

shinyApp(ui, server)