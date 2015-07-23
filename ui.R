
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Retirement savings decay"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    sliderInput("alive",
                "How many years will you live after retirement?",
                min = 1,
                max = 50,
                value = 30),
    sliderInput("inflation",
                "What is the projected percent annual inflation rate?",
                min = 0.5,
                max = 10,
                value = 3),
    sliderInput("ror",
                "What is the estimated annual rate of return on your investments?",
                min = 0,
                max = 25,
                value = 8),
    numericInput("ivalue",
                 "How much will you have invested at retirement?",
                 min = 0,
                 value = 325000),
    numericInput("monthlyRev",
                 "How much will you receive monthly from you pension, social security, etc.?",
                 min = 0,
                 value = 2500),
    numericInput("monthlyCost",
                 "How much is your monthly estimated cost of living?",
                 min = 1000,
                 value = 5000),
    submitButton("Submit")
    ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot"),
    verbatimTextOutput("text1")
  )
))
