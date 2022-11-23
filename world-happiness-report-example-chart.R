data <- read_csv("world-happiness-report.csv")

# data_filtered <- data %>%
#   filter(`Country name` == "Germany")

data_filtered <- subset(data,startsWith(data$`Country name`,""))

data_filtered %>% 
  ggplot(aes(x = `year`, y = `Generosity`, color = `Country name`) +
  theme(legend.position = "none") +
  geom_line())


ggplot(data = data_filtered,aes(x = year, y = Generosity, color = `Country name`)) +
  theme(legend.position = "none") +
  geom_line() +
  labs(
    title = "World Happiness Report 2021", 
    y = "Generosity"
  ) +
  theme(
    panel.background = element_rect(fill = "white")
  )

  
#aes(color = `Country name`)