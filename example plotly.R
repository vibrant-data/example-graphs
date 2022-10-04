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

widget_file_size <- function(p) {
  d <- getwd()
  withr::with_dir(d, htmlwidgets::saveWidget(p, "index.html"))
  f <- file.path(d, "index.html")
  mb <- round(file.info(f)$size / 1e6, 3)
  message("File is: ", mb," MB")
}


#widget_file_size(fig)
#> File is: 3.495 MB
#widget_file_size(partial_bundle(fig))
#> File is: 1.068 MB


htmlwidgets::saveWidget(fig, "p1.html", selfcontained = F, libdir = "lib")

