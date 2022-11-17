# Circlepacker package
library(circlepackeR)     
# devtools::install_github("jeromefroe/circlepackeR") # If needed

# create a nested data frame giving the info of a nested dataset:

d1 <- c("Datenerhebung",
        "Aufbereitung",
        "Verwalten",
        "Analyse",
        "Visualisierung",
        "Interpretation",
        "Vorhersage")

d2 <- c("Fragebogen",
        "Scraping",
        "Datenbereinigung",
        "Datenbanken",
        "Taxonomie",
        "Deskriptive Analyse",
        "Diagramme",
        "Dashboard",
        "Ergebnisbericht",
        "Handlungsempfehlung",
        "Machine Learning")

d3 <- c("Fragebogenentwicklung",
        "Fragebogenstudie",
        "Webscraping",
        "Outlier-Analyse",
        "Netzwerk-Datenbank",
        NA,
        "Vergleichender Bericht",
        "Barplot",
        NA,
        NA,
        "Szenarien-Analyse",
        "Modell-Entwicklung")


vlist <- list(name = "vibrant",
              children = list(
                list(name = d1[1],
                     children = list(
                  list(name = d2[1], 
                       children = list(
                         name = d3[1], size=1,
                         name = d3[2], size=1
                       )),
                  list(name = d2[2], 
                       children = list(
                         name = d3[3], size=1,
                         name = "TEST", size=1
                       ))
                  )),
                list(name = d1[2], 
                     children = list(
                       list(name = "Brazil", size = 1),
                       list(name = "Colombia", size = 1),
                       list(name = "Argentina", size = 1))),
                list(name = d1[3],
                     children = list(
                       list(name = "Germany", size = 1),
                       list(name = "France", size = 1),
                       list(name = "United Kingdom", size = 1))),
                list(name = d1[4], 
                     children = list(
                       list(name = "Nigeria", size = 1),
                       list(name = "Ethiopia", size = 1),
                       list(name = "Egypt", size = 1))),
                list(name = d1[5],  
                     children = list(
                       list(name = "China", size = 1),
                       list(name = "India", size = 1),
                       list(name = "Indonesia", size = 1)))
              )
)

circlepackeR(vlist)

data <- data.frame(
  root=rep("root", 12),
  group=c(
    rep(d1[1],3), 
    rep(d1[2],1),
    rep(d1[3],1),
    rep(d1[4],2),
    rep(d1[5],3),
    rep(d1[6],1),
    rep(d1[7],1)
  ),
  subgroup=c(
    rep(d2[1],2),
    d2[2:11]
  ),
  #subsubgroup=d3,
  subsubgroup=rep(letters[1:3], 4),
  value=sample(seq(1:12), 12)
)

'data <- data.frame(
  root=rep("root", 15),
  group=c(rep("group A",5), rep("group B",5), rep("group C",5)), 
  subgroup= rep(letters[1:5], each=3),
  subsubgroup=rep(letters[1:3], 5),
  value=sample(seq(1:15), 15)
)'

# Change the format. This use the data.tree library. This library needs a column that looks like root/group/subgroup/..., so I build it
library(data.tree)
data$pathString <- paste("world", data$group, data$subgroup, data$subsubgroup, sep = "/")
population <- as.Node(data)

# Make the plot
circlepackeR(population, size = "value")

# You can custom the minimum and maximum value of the color range.
p <- circlepackeR(population, size = "value", color_min = "hsl(56,80%,80%)", color_max = "hsl(341,30%,40%)")
p
# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/circular_packing_circlepackeR2.html"))