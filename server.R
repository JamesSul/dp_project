
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

message <- function(df) {
        message <- "You can retire safely!"
        if(min(df$remaining) <= 0) {
                dest <- min(df$year[df$remaining <= 0])
                message <- paste("You will be destitute in year", dest)
        }
        message
}
        

shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    

    years <- 1:input$alive
    remains <- input$ivalue
    remaining <- numeric()
    for( i in years) {
            for( j in 1:12) {
                    remains <- (remains + input$monthlyRev - input$monthlyCost*(1 + input$inflation/1200)) * (1 + input$ror/1200)
            }
            remaining[i] <- remains
    }
    df <- data.frame(year = years, remaining = remaining)
   
    # draw the histogram with the specified number of bins
    library(ggplot2)
    library(scales)
    library(RColorBrewer)
    
    
    ggplot(data = df, aes(x = year, y = remaining, fill=remaining)) + 
            geom_bar(stat = "identity") + 
            scale_y_continuous(labels = dollar) + 
            ylab("remaining(in USD)") +
            scale_fill_gradient2(low = "#FF0000", mid = "#FFFFFF", high ="#0000FF", 
                                 midpoint = 0, space = "rgb", guide = "colourbar") +
            guides(fill=FALSE) +
            ggtitle(message(df))
    
  })

  
   output$text1 <- renderText({
          paste("The title of the graph above tells you when your retirement resources will expire.\n",
                "It is currently using the following assumptions:\n",
                 "After you retire, you will live for an additional ", input$alive, " years.\n",
                "inflation rate: ", input$inflation, "%\n",
                "rate of return on investments: " ,input$ror, "%\n",
                "total investments at retirement: $", input$ivalue, "\n",
                "monthly inflows: $" ,input$monthlyRev, "\n",
                "monthly outflows: $" ,input$monthlyCost, "\n",
                "You may change any parameters and click submit to update.",
                sep="")
         # 
          #}
          

        })
  
  
  
})
