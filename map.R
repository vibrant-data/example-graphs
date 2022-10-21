library(leaflet)
library(dplyr)
library(htmltools)

icons <- awesomeIcons(
  icon = 'ios-home',
  iconColor = 'black',
  library = 'ion',
  #markerColor = getColor(df.20)
)

m <- leaflet() %>%
  addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
  #addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
  addAwesomeMarkers(13.405, 52.515, icon=icons, popup="Berlin") %>%
  addAwesomeMarkers(11.582, 48.135, icon=icons, popup="München") %>%
  setView(11.5, 51, zoom = 6)


save_html(m, file="map.html")
