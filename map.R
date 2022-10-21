library(leaflet)
library(rgdal)
library(dplyr)
library(htmltools)


leaflet() %>%
  addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
  addMarkers(13.405, 52.515, popup="Berlin") %>%
  addMarkers(11.582, 48.135, popup="München")
