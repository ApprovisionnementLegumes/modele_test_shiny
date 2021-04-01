#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Approvisionnement legume"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(

            sliderInput("quantity",
                        "Amount you want",
                        min = 1,
                        max = 5000,
                        value = 2000, step = 100
                        ), 
            
            selectInput("legumes", "Choose vegetable", 
                        choices = c("carrot", "tomato"), multiple = FALSE),
            
            selectInput("time", "Choose month of production", 
                        choices = months, selected = "december")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            
            plotOutput("supplyPlot")
            
        )
    )
))
