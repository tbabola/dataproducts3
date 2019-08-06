#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

data <- read.csv("data/nutritionClean.csv")[-1]

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        temp <- data[data$ShorterD==input$foodGroup,]
        g <- ggplot(data=temp, aes(x=temp[,input$xAxis],y=temp[,input$yAxis])) +
                    xlab(input$xAxis) + ylab(input$yAxis) + geom_point()
        g 
    })
    
    output$plotlyPlot <- renderPlotly({
        
        temp <- data[data$ShorterD==input$foodGroup,c(input$xAxis,input$yAxis,"Shrt_Desc")]
        temp <- temp[!is.na(temp[,1])&!is.na(temp[,2]),]
        
        f <- list(
            family = "Courier New, monospace",
            size = 18,
            color = "#7f7f7f"
        )
        x <- list(
            title = input$xAxis,
            titlefont = f
        )
        y <- list(
            title = input$yAxis,
            titlefont = f
        )
        if (input$showModel){
            fitlm <- lm(temp[,input$yAxis] ~ temp[,input$xAxis])
            fitlm
            fv <-  fitlm %>% fitted.values()
            
            p <- plot_ly() %>%
                 add_markers(x = temp[,input$xAxis],
                             y = temp[,input$yAxis], 
                             text= temp$Shrt_Desc) %>%
                     add_lines(x = temp[,input$xAxis], 
                           y = fv, text = paste("R^2: ", summary(fitlm)$r.squared)) %>%
                 layout(xaxis = x, yaxis = y, showlegend = FALSE)
             p 
        }
        else {
            p <- plot_ly() %>%
                add_markers(x = temp[,input$xAxis],
                            y = temp[,input$yAxis], 
                            text= temp$Shrt_Desc) %>%
                layout(xaxis = x, yaxis = y, showlegend = FALSE)
            p 
        }
    })

})
