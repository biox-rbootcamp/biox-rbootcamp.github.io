library("shiny")
library("ggplot2")

pageWithSidebar(
  
  headerPanel("VST Explorer"),
  
  sidebarPanel(
    
    sliderInput('a', 'a', min = 0, max = 10,
                value = 1, step = 0.1),
    sliderInput('b', 'b', min = 0, max = 20,
                value = 0, step = 0.1)
  ),
  
  mainPanel(
    plotOutput('plot')
  )
)

