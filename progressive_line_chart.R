# libraries:
library(ggplot2)
library(gganimate)
library(babynames)
library(hrbrthemes)
library(dplyr)
library(viridis)
library(gifski)

tt <- read.csv("trend_datascience.csv")
months <- rownames(tt)[-1]
t <- data.frame("Datum" = months, "Begriff" = "Data Science", n = tt$Kategorie..Alle.Kategorien[-1])

tt <- read.csv("trend_dataanalysis.csv")
t <- bind_rows(t, data.frame("Datum" = months, "Begriff" = "Data Analysis", n = tt$Kategorie..Alle.Kategorien[-1]))

tt <- read.csv("trend_dataviz.csv")
t <- bind_rows(t, data.frame("Datum" = months, "Begriff" = "Data Visualization", n = tt$Kategorie..Alle.Kategorien[-1]))

tt <- read.csv("trend_bigdata.csv")
t <- bind_rows(t, data.frame("Datum" = months, "Begriff" = "Big Data", n = tt$Kategorie..Alle.Kategorien[-1]))

t[is.na(t)] <- 0
t$Datum <- as.Date(paste(t$Datum,"-01",sep=""))

# Plot
p <- t %>%
  ggplot( aes(x=Datum, y=n, group=n, color=Begriff)) +
  geom_line() +
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Popularity of American names in the previous 30 years") +
  theme_ipsum() +
  ylab("Number of babies born") +
  transition_reveal(Datum)

animate(p, duration = 5, fps = 20, width = 200, height = 200, renderer = gifski_renderer())
anim_save("output.gif")

