# -- Djokovic shiny app
#setwd("~/Documents/GitHub/serve_speeds/djokovic_serve_speed/shiny")
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

# --
source("~/Documents/Github/serve_speeds/djokovic_serve_speed/src/plot_speed_density.R")


djokovic_data <- read.csv('~/Documents/GitHub/serve_speeds/djokovic_serve_speed/shiny/djokovic.csv')

ui <- dashboardPage(
  dashboardHeader(title = 'Djokovic Grand Slam Serve Speeds'),
  dashboardSidebar(
    selectizeInput(inputId = 'tournament_id',
                   '1. Tournament',
                   choices = levels(djokovic_data$tournament),
                   options = list(placeholder = "Type your tournament")),
    conditionalPanel(condition = 'input.tournament_id != ""',
                     selectizeInput('year', 
                                    '2. Year',
                                    choices = c(2018,2019),
                                    options = list(placeholder = "Which year?")))
    ),
  dashboardBody(fluidRow(valueBoxOutput("icon1")),
    fluidRow(box(title = '',
                             footer = 'Stats on the T',
                             collapsible = TRUE,
                             solidHeader = TRUE,
                             div(style = 'font-size: 105%'),
                             plotOutput('entire_speed_plot'))),
                fluidRow(box(title = 'Another one')))
  )
  

# -- server
server <- function(input, output, session) {
  reduced_df <- reactive({djokovic_data %>%
      filter(tournament == input$tournament_id) %>%
      filter(year == input$year)})
  
  output$entire_speed_plot <- renderPlot({
    plot_servespeed_density(reduced_df(), 
                            tournament = input$tournament_id,
                            plot_title = '',
                            year = input$year)
  })
  
  output$icon1 <-renderValueBox({
    #icon = pushed; modx
    valueBox(paste('All Speeds'),
             paste('Australian Open 2018'), 
             icon = icon('chart-area'), color = 'blue')
  })
  
  
}

shinyApp(ui, server)
