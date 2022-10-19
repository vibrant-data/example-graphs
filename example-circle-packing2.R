# https://r-graph-gallery.com/338-interactive-circle-packing-with-circlepacker

# Circlepacker package
library(circlepackeR)
# devtools::install_github("jeromefroe/circlepackeR") # If needed

nodes <- read_excel("example-circle-packing-data.xlsx", sheet = 1)
data_edge <- read_excel("example-circle-packing-data.xlsx", sheet = 3)

# Let's use the 'flare dataset' (stored in the ggraph library)
data_edge <- read_excel("example-circle-packing-data.xlsx", sheet = 4)
#data_edge_flare <- flare$edges
#data_edge$from <- gsub(".*\\.","",data_edge$from)
#data_edge$to <- gsub(".*\\.","",data_edge$to)
head(data_edge)   # This is an edge list


# We need to convert it to a nested data frame. the data.tree library is our best friend for that:
library(data.tree)
data_tree <- FromDataFrameNetwork(data_edge)

data_nested <- ToDataFrameTree(data_tree, 
                               level1 = function(x) x$path[2],
                               level2 = function(x) x$path[3],
                               level3 = function(x) x$path[4])[-1,-1]
data_nested <- na.omit(data_nested)


# Now we can plot it as seen before!
data_nested$pathString <- paste("roots", data_nested$level1, data_nested$level2, data_nested$level3, data_nested$level4, sep = "/")
data_nested$value=1
data_Node <- as.Node(data_nested)
p <- circlepackeR(data_Node, size = "value")
p 

# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/circular_packing_circlepackeR1.html"))