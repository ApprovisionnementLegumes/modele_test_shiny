#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    output$supplyPlot <- renderPlot({

        time_num <- which(months == input$time) # the month of interest, in number
        
        print(production_data)
        
        
        # get the specifi production for the given product
        specific_production <- production_data %>% 
            filter(name_product == input$legumes)
        
        if(nrow(specific_production) == 0){
            print("Sorry no data for this product")
            return(0) # get out of the function
        }
        
        # Get the specific production for a given production mode
        specific_production <- specific_production %>% 
            filter(name_mode == input_production_mode)
        
        if(nrow(specific_production) == 0){
            print("Sorry no data for that mode of production in the database")
            return(0) # get out of the function
        }
        
        # Get the specific production for a place
        specific_production <- specific_production %>% 
            filter(name_locality == input_localisation)
        
        if(nrow(specific_production) == 0){
            print("Sorry no data for that locality in the database")
            return(0) # get out of the function
        }
        
        
        # Get the specific production for a given time
        specific_production <- specific_production %>% 
            filter(start_harvest <= time_num & stop_harvest >= time_num)
        
        if(nrow(specific_production) == 0){
            print("Sorry no production for that date")
            return(0) # get out of the function
        }
        
        
        offer <- specific_production$monthly_quantity
        
        
        rs <- data.frame(type = c("offer", "demand"), 
                         value = c(offer, input$quantity))
        
        ggplot(rs, aes(x = type, y = value)) + 
            geom_point()

    })

})
