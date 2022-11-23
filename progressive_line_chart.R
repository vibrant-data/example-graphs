# libraries:
library(ggplot2)
library(gganimate)
library(hrbrthemes)
library(dplyr)
library(viridis)
library(gifski)

tt <- read.csv("trend_datascience.csv")
months <- rownames(tt)[-1]
t <- data.frame("Jahr" = months, "Begriff" = "Data Science", n = tt$Kategorie..Alle.Kategorien[-1])

#tt <- read.csv("trend_dataanalysis.csv")
#t <- bind_rows(t, data.frame("Jahr" = months, "Begriff" = "Data Analysis", n = tt$Kategorie..Alle.Kategorien[-1]))

tt <- read.csv("trend_dataviz.csv")
t <- bind_rows(t, data.frame("Jahr" = months, "Begriff" = "Data Visualization", n = tt$Kategorie..Alle.Kategorien[-1]))

tt <- read.csv("trend_bigdata.csv")
t <- bind_rows(t, data.frame("Jahr" = months, "Begriff" = "Big Data", n = tt$Kategorie..Alle.Kategorien[-1]))

t$Jahr <- as.Date(paste(t$Jahr,"-01",sep=""))
t$n <- as.numeric(t$n)
t[is.na(t)] <- 0
t$Begriff <- as.factor(t$Begriff)

pal <- c("#FF087E", "#083d77", "#59c3c3")

# Plot
p <- t %>%
  ggplot( aes(x=Jahr, y=n, group=Begriff, color=Begriff)) +
  geom_line() +
  geom_point() +
  #scale_color_viridis(discrete = TRUE, option = "D") +
  scale_colour_manual(values = pal, breaks = c("Data Science", "Data Visualization", "Big Data"))+
  #ggtitle("Popularität des Suchbegriffs") +
  #theme_ipsum_rc()+
  scale_x_date(date_breaks = "1 year", date_labels = "%Y")+
  theme_minimal()+
  theme(text=element_text(colour="black",family="roboto"),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x = element_blank(),
        
        legend.position="top",
        legend.title = element_blank(),
        panel.grid.major=element_line(colour="white"),
        panel.grid.major.y=element_blank(),
        panel.grid.minor.x=element_blank(), #turn off minor gridlines
        panel.grid.minor.y=element_blank())+ #turn off minor gridlines)
  transition_reveal(Jahr)+
  ease_aes('linear')+
  enter_fade()+
  exit_fade()

#p

animate(p, fps = 50, detail = 5, duration = 10, end_pause = 10, width = 600, height = 400, res=84, renderer = magick_renderer(), bg = 'transparent')
anim_save("trend_progressive_linechart7.gif")

