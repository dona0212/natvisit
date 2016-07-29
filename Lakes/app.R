library(shiny)

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

visits <- read.csv("private_data/real_data_1obs_log.csv")

server <- shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    visits[, c(input$xcol, input$ycol)]
  })
  
  
  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         pch = 20, cex = 1)
  
  })
  
})


ui <- shinyUI(pageWithSidebar(
  headerPanel('Annual Average Visits vs. Annual Average Secchi Depth'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(visits)),
    selectInput('ycol', 'Y Variable', names(visits),
                selected=names(visits)[[2]])

  ),
  mainPanel(
    plotOutput('plot1')
  )
))

shinyApp(ui, server)