#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

data <- read.csv("data/nutritionClean.csv")[-1]

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Nutrition Data of Food Groups"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("foodGroup", 
                        "Food group", 
                        data$ShorterD,
                        selected = TRUE),
             selectInput("xAxis",
                         "X axis measurement",
                         names(data[,unlist(lapply(data,is.numeric))])[-1],
                         selected = TRUE),
             selectInput("yAxis",
                         "Y axis measurement",
                         names(data[,unlist(lapply(data,is.numeric))])[-1],
                         selected =  names(data[,unlist(lapply(data,is.numeric))])[3]),
            checkboxInput("showModel","Show Model?", TRUE),
            p("When Model is shown, hover over fit line to see the R^2 value.")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            #plotOutput("distPlot"),
            plotlyOutput("plotlyPlot")
        )
    )
))
