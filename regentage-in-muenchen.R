library(ggplot2)
library(dplyr)
library(grid)
library(cowplot)


# read weathr data
data <- readr::read_csv("wetter-m-1980-2021.csv")
# last decade
data <- subset(data, date >= "2011-01-01") #das sind eigtl 11 jahre
# provide statistics
s.regentage <- sum(data$prcp > 0)
s.regentage.p <- round(s.regentage/nrow(data)*100,0)
s.niederschlag <- round(mean(data$prcp),2)
s.niederschlag.t <- round(sum(data$prcp),0)
s.regenhoch.d <- data$date[which(data$prcp == max(data$prcp))]
s.regenhoch <- data$prcp[which(data$prcp == max(data$prcp))]


# negative values for rain plot
data$rainfall <- -1*data$prcp

p1 <- ggplot(data) + 
  #geom_bar(aes(x = date, y = rainfall), colour = "white", stat='identity') +
  geom_bar(aes(x = date, y = rainfall, color=rainfall), stat='identity') +
  #scale_color_gradient(low="lightskyblue1", high="white")+
  scale_color_continuous()+
  annotate(geom = "point", x = s.regenhoch.d, y = min(data$rainfall), colour = "white", size = 3) + 
  #annotate(geom = "text", x = s.regenhoch.d+150, y = min(data$rainfall) + 3, colour = "white", size = 3, hjust = 0, nudge_x=1, label = paste0("Der meiste Regen viel in der Nacht auf den 30.06.2011\n(",s.regenhoch," mm an einem Tag)")) +
  geom_text(x = s.regenhoch.d+200, y = min(data$rainfall) + 3, colour = "white", size = 3, hjust = 0, label = paste0("Der meiste Regen fiel in der Nacht auf den 30.06.2011\n(",s.regenhoch," mm an einem Tag)")) + 
  annotate(geom = "segment", x = s.regenhoch.d+150, xend =s.regenhoch.d+150, y = min(data$rainfall) - 3, yend = min(data$rainfall) + 8,
           colour = "white" ) + 
  annotate(geom = "segment", x = s.regenhoch.d, xend = s.regenhoch.d+150, y = min(data$rainfall) , yend = min(data$rainfall) + 3,
           colour = "white" ) + 
  theme(panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black", colour = NA),
        plot.title = element_text(hjust = 1, size = 36, colour = "white", family = "Raleway"),
        plot.subtitle = element_text(hjust = 1, size = 12, colour = "white", family = "Roboto Condensed"),
        plot.caption = element_text(colour = "white"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text = element_blank()
  ) +
  labs(title = "Regentage in München",
       subtitle = paste0("In den letzten 10 Jahren gab es ",s.regentage," Regentage (insgesamt ",round(s.regentage/nrow(data)*100,0),"%) in München\n Niederschlagsmenge ingesamt: ",s.niederschlag.t," mm (Durchschnittlich ",s.niederschlag," mm)"),
       #caption = "Source https://www.data.jma.go.jp/gmd/risk/obsdl/index.php\nImage Source https://publicdomainq.net",
       x = NULL, y = NULL)
p1
p2 <- rasterGrob(jpeg::readJPEG('res/rain-3524806_1920.jpg'), width = unit(0.85,"npc"), height = unit(0.75,"npc"))

p3 <- plot_grid(p2, p1, ncol = 2, rel_widths = c(1,2)) + 
  theme(plot.background = element_rect(fill = "black", colour = NA))
print(p3)
grid.text(label = "Täglicher Niederschlag in den letzten 10 jahren (01.01.2011 - 31.12.2021)",
          x = 0.57, y = 0.81, gp=gpar(fontsize=8, col="white", fontfamily="Roboto Condensed"))



## version with color gradient
library(tidyverse)
data2 <- data %>%
  rowwise() %>%
  summarise(group = date,
            rainfall = list(0:rainfall)) %>%
            #rainfall = seq(0, rainfall, by = -0.1)) %>%
  unnest(cols = rainfall)

data2 %>%
  ggplot() +
  geom_tile(aes(
    x = group,
    y = rainfall,
    fill = rainfall,
    width = 2
  )) 
  #coord_flip() +
  #scale_fill_viridis_c(option = "C") +
  #theme(legend.position = "none")

p1 <- ggplot(data2) + 
  #geom_bar(aes(x = date, y = rainfall), colour = "white", stat='identity') +
  geom_tile(aes(x = group, y = rainfall, fill=rainfall)) +
  scale_fill_continuous(low="deepskyblue3", high="white")+
  annotate(geom = "point", x = s.regenhoch.d, y = min(data$rainfall), colour = "white", size = 3) + 
  #annotate(geom = "text", x = s.regenhoch.d+150, y = min(data$rainfall) + 3, colour = "white", size = 3, hjust = 0, nudge_x=1, label = paste0("Der meiste Regen viel in der Nacht auf den 30.06.2011\n(",s.regenhoch," mm an einem Tag)")) +
  geom_text(x = s.regenhoch.d+200, y = min(data$rainfall) + 3, colour = "white", size = 3, hjust = 0, label = paste0("Der meiste Regen fiel in der Nacht auf den 30.06.2011\n(",s.regenhoch," mm an einem Tag)")) + 
  annotate(geom = "segment", x = s.regenhoch.d+150, xend =s.regenhoch.d+150, y = min(data$rainfall) - 3, yend = min(data$rainfall) + 8,
           colour = "white" ) + 
  annotate(geom = "segment", x = s.regenhoch.d, xend = s.regenhoch.d+150, y = min(data$rainfall) , yend = min(data$rainfall) + 3,
           colour = "white" ) + 
  theme(panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black", colour = NA),
        plot.title = element_text(hjust = 1, size = 36, colour = "white", family = "Raleway"),
        plot.subtitle = element_text(hjust = 1, size = 12, colour = "white", family = "Roboto Condensed"),
        plot.caption = element_text(colour = "white"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text = element_blank(),
        legend.position = "none"
  ) +
  labs(title = "Regentage in München",
       subtitle = paste0("In den letzten 10 Jahren gab es ",s.regentage," Regentage (insgesamt ",round(s.regentage/nrow(data)*100,0),"%) in München\n Niederschlagsmenge ingesamt: ",s.niederschlag.t," mm (Durchschnittlich ",s.niederschlag," mm)"),
       #caption = "Source https://www.data.jma.go.jp/gmd/risk/obsdl/index.php\nImage Source https://publicdomainq.net",
       x = NULL, y = NULL)
p1
