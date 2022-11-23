library(tidyverse)
data <- read_csv("world-happiness-report.csv")


data_tidy <- data %>%
  group_by(`Country name`) %>%
  mutate(across(`Life Ladder`:`Negative affect`, scale)) %>%
  gather(key = "var", value = "value", -`Country name`, -year)



data_filtered <- data_tidy %>%
  filter(`Country name` == "Germany")



data <- read_csv("world-happiness-report.csv")

data_count <- data %>%
  count(`Country name`)

remove <- data_count$`Country name`[data_count$n == 1]

data <- data %>%
  filter(!(`Country name` %in% remove))




ggplot(data = data_filtered,aes(x = year, y = value, color = `var`)) +
  theme(legend.position = "none") +
  geom_line() +
  labs(
    title = "World Happiness Report 2021", 
    subtitle = data_filtered$`Country name`,
    caption = paste0("Data from ",range(data_filtered$year)[1],"-",range(data_filtered$year)[2]),
    y = "",
    x = ""
  ) +
  facet_wrap(~var)+
  theme(
    panel.background = element_rect(fill = "white"),
    text=element_text(colour="black",family="roboto"),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    #legend.position="top",
    panel.grid.major=element_blank(),
    panel.grid.minor=element_blank()
    
    ) 

