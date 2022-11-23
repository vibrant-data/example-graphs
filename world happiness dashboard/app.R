library(shiny)
library(tidyverse)
library(shinycssloaders)
library(plotly)

'data <- read_csv("world-happiness-report.csv")

data_tidy <- data %>%
  group_by(`Country name`) %>%
  mutate(across(`Life Ladder`:`Negative affect`, scale)) %>%
  gather(key = "var", value = "value", -`Country name`, -year)'

data_tidy <- readRDS("world_happiness_tidy.rds")


ui <- fluidPage(
  tags$style(
    HTML('
         h4 { margin-top:25px;
         display: flex;
         align-items: center;
         justify-content: center;
         }
         
         .container-fluid {
           background-color: #e0f4f4;

         ')),
  #fluidRow(  #fluidRow(
    column(4, align="left",
           h4("World Happiness Report 2021"),
    ),
    
    column(8, align="center",
           selectInput('country', '', unique(data_tidy$`Country name`),
                       selected = "Germany")
           #)

    ),
  
    verticalLayout(
      withSpinner(plotlyOutput('plot')),
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
    facet_wrap(~var)+
    theme(
      rect = element_rect(fill = "transparent"),
      panel.background = element_rect(fill = "transparent",
                                      colour = NA_character_), # necessary to avoid drawing panel outline
      plot.background = element_rect(fill = "transparent",
                                     colour = NA_character_), # necessary to avoid drawing plot outline
      legend.background = element_rect(fill = "transparent"),
      legend.box.background = element_rect(fill = "transparent"),
      legend.key = element_rect(fill = "transparent"),
      strip.background = element_rect(fill = "#e0f4f4"),
      #text=element_text(colour="black",family="Roboto Condensed"),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      legend.position = "none",
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank()
    ) 
    ggplotly(p, tooltip = c("year")) %>% config(displayModeBar = F)
  })
  }

shinyApp(ui = ui, server = server)