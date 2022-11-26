library(shiny)
library(tidyverse)
library(shinycssloaders)
library(plotly)

data <- read_csv("world-happiness-report.csv")

data_tidy <- data %>%
  group_by(`Country name`) %>%
  #mutate(across(`Life Ladder`:`Negative affect`, scale)) %>%
  gather(key = "var", value = "value", -`Country name`, -year)

#data_tidy <- readRDS("world_happiness_tidy.rds")

ui <- fluidPage(
  tags$style(
    HTML('
         h1 {
           font-family:"Roboto"; 
           font-size:1.2em; 
           margin:0px;
         }
         .container-fluid {
           background-color: #e0f4f4;
         }
         .selectize-input input {
           font-family:"Roboto"; 
         }
         ')),
  #fluidRow(  #fluidRow(
    #column(4, align="left",
    #       p("World Happiness Report 2021"),
    #),
    
    column(12, align="center",
           div(style="white-space: nowrap;",
             div(selectInput('country', '', unique(data_tidy$`Country name`),
                         selected = sample(data_tidy$`Country name`, 1)), style="display: inline-block; margin:auto;"),
             div(HTML("WORLD<br>HAPPINESS<br>REPORT<br>2021"), style="display: inline-block; text-align:right; font-family:'Roboto Condensed'; line-height: 80%; margin-left:30px;"),
             )

    ),
  
    verticalLayout(
      withSpinner(plotlyOutput('plot'), type = 6),
    )

  

)

server <- server <- function(input, output) {

  output$plot <- renderPlotly({
    
    data_filtered <- data_tidy %>%
      filter(`Country name` == input$country)
    
    p <- ggplot(data = data_filtered,aes(x = year, y = value, color = `var`)) +
    geom_line() +
    labs(
      #title = "World Happiness Report 2021", 
      #subtitle = data_filtered$`Country name`,
      caption = paste0("Data from ",range(data_filtered$year)[1],"-",range(data_filtered$year)[2]),
      y = "",
      x = ""
    ) +
    facet_wrap(~var, scales = "free_y")+
    theme(
      rect = element_rect(fill = "transparent"),
      panel.background = element_rect(fill = "#E6FAFA"),
      #                                colour = NA_character_), # necessary to avoid drawing panel outline
                                       #colour = "white", size=1),
      strip.background = element_rect(fill = "#DAEDED"),
      strip.text = element_text(family="Roboto Condensed", size=8),
      #text=element_text(colour="black",family="Roboto Condensed"),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      legend.position = "none",
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank()
    ) 
    ggplotly(p, tooltip = c("value","year")) %>% config(displayModeBar = F)
  })
  }

shinyApp(ui = ui, server = server)