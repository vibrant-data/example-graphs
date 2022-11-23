library(ggplot2)
library(ggridges)
library(gganimate)
library(dplyr)

'w <- readr::read_csv("wetter-m-1980-85.csv")
t <- readr::read_csv("wetter-m-1985-90.csv")
w <- bind_rows(w,t)
t <- readr::read_csv("wetter-m-1990-95.csv")
w <- bind_rows(w,t)
t <- readr::read_csv("wetter-m-1995-00.csv")
w <- bind_rows(w,t)
t <- readr::read_csv("wetter-m-2000-05.csv")
w <- bind_rows(w,t)
t <- readr::read_csv("wetter-m-2005-10.csv")
w <- bind_rows(w,t)
t <- readr::read_csv("wetter-m-2010-15.csv")
w <- bind_rows(w,t)
t <- readr::read_csv("wetter-m-2015-20.csv")
w <- bind_rows(w,t)
t <- readr::read_csv("wetter-m-2020-21.csv")
w <- bind_rows(w,t)

write.csv(w, "wetter-m-1980-2021.csv")'

w <- readr::read_csv("wetter-m-1980-2021.csv")

str(w)
w$Jahr <- format(w$date, "%Y")
w$Monat <- format(w$date, "%B")
w$Monat <- factor(w$Monat,
                     levels=c(
                       "Januar",
                       "Februar",
                       "März",
                       "April",
                       "Mai",
                       "Juni",
                       "Juli",
                       "August",
                       "September",
                       "Oktober",
                       "November",
                       "Dezember"
                     ))

p <- ggplot(w, aes(x = tavg, y = Monat, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "°C", option = "C") +
  #labs(title = 'Temperatur in München (2021)')+
  xlab("Durchschnittstemperatur")+
  ylab("")+
  theme_minimal()+
  theme(text=element_text(colour="black",family="roboto"),
        axis.text.y = element_text(size = 10), 
        #legend.position="top",
        panel.grid.major=element_line(colour="white"),
        panel.grid.major.x=element_blank(),
        panel.grid.minor.x=element_blank(), #turn off minor gridlines
        panel.grid.minor.y=element_blank())+ #turn off minor gridlines)
  transition_states(Jahr,
                    state_length = 0,
                    wrap=F)+
  ggtitle('Temperatur in München',
          subtitle = '{closest_state}')

animate(p, fps = 25, detail = 5, duration = 20, width = 600, height = 400, renderer = magick_renderer(), bg = 'transparent')
anim_save("munich-historical-weather3.gif")
