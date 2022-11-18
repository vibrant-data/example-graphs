library(ggplot2)
library(plotly)
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")
ggplotly(p)
 



library(plotly)

fig <-  plot_ly(x = c(0,1, 2), y = c(2, 1, 3), type = 'bar') %>%
  config(fig, displayModeBar = FALSE)%>% 
  layout(title = "",
         paper_bgcolor='transparent',
         plot_bgcolor='#e5ecf6', 
         xaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'), 
         yaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'))

#fig <- fig %>% toWebGL()

fig

'widget_file_size <- function(p) {
  d <- getwd()
  withr::with_dir(d, htmlwidgets::saveWidget(p, "index.html"))
  f <- file.path(d, "index.html")
  mb <- round(file.info(f)$size / 1e6, 3)
  message("File is: ", mb," MB")
}'


#widget_file_size(fig)
#> File is: 3.495 MB
#widget_file_size(partial_bundle(fig))
#> File is: 1.068 MB


htmlwidgets::saveWidget(fig, "p1.html", selfcontained = F, libdir = "lib")




###########################


fig <- plot_ly(type = 'mesh3d',
               x = c(0.5, 0.5, 0.5, 0.5, 0, 0, 1, 1),
               y = c(0, 1, 1, 0, 0, 1, 1, 0),
               z = c(0, 0, 0, 0, 1, 1, 1, 1),
               i = c(7, 0, 0, 0, 4, 4, 6, 6, 4, 0, 3, 2),
               j = c(3, 4, 1, 2, 5, 6, 5, 2, 0, 1, 6, 3),
               k = c(0, 7, 2, 3, 6, 7, 1, 1, 5, 5, 7, 6),
               intensity = seq(0, 1, length = 8),
               color = seq(0, 1, length = 8),
               colors = colorRamp(viridis::turbo(8))
) 
fig <- fig %>% layout(showlegend = FALSE) %>%
  config(fig, displayModeBar = FALSE)%>% 
  layout(title = "",
         plot_bgcolor  = "rgba(0, 0, 0, 0)",
         paper_bgcolor = "rgba(0, 0, 0, 0)",
         fig_bgcolor   = "rgba(0, 0, 0, 0)")

fig

#htmltools::save_html(fig, "p2.html")
htmlwidgets::saveWidget(fig, "p2.html", selfcontained = F, libdir = "lib")
