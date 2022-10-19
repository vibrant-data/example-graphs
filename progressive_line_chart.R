# libraries:
library(ggplot2)
library(gganimate)
library(babynames)
library(hrbrthemes)
library(dplyr)
library(viridis)
library(gifski)

# Keep only 3 names
don <- babynames %>% 
  filter(name %in% c("Ashley", "Patricia", "Helen")) %>%
  filter(sex=="F")

# Plot
p <- don %>%
  ggplot( aes(x=year, y=n, group=name, color=name)) +
  geom_line() +
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Popularity of American names in the previous 30 years") +
  #theme_ipsum() +
  ylab("Number of babies born") +
  transition_reveal(year)

animate(p, duration = 5, fps = 20, width = 200, height = 200, renderer = gifski_renderer())
anim_save("output.gif")

