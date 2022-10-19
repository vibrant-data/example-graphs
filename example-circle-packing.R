# Libraries
library(ggraph)
library(igraph)
library(tidyverse)
library(viridis)
library(readxl)

nodes <- read_excel("example-circle-packing-data.xlsx", sheet = 1)
edges <- read_excel("example-circle-packing-data.xlsx", sheet = 3)

# We need a data frame giving a hierarchical structure. Let's consider the flare dataset:
# edges <- flare$edges
# nodes <- flare$vertices
mygraph <- graph_from_data_frame( edges, vertices=nodes )

# Control the size of each circle: (use the size column of the vertices data frame)
ggraph(mygraph, layout = 'circlepack', weight=level) + 
  geom_node_circle() +
  theme_void()

# Left: color depends of depth
p <- ggraph(mygraph, layout = 'circlepack', weight=level) + 
  geom_node_circle(aes(fill = depth)) +
  theme_void() + 
  theme(legend.position="FALSE")
p
# Adjust color palette: viridis
p + scale_fill_viridis()
# Adjust color palette: colorBrewer
p + scale_fill_distiller(palette = "RdPu") 


# Create a subset of the dataset (I remove 1 level)
edges2 <- edges %>% 
  filter(to %in% from) %>% 
  droplevels()
nodes2 <- nodes %>% 
  filter(name %in% c(edges$from, edges$to)) %>% 
  droplevels()
nodes$size <- runif(nrow(nodes))

# Rebuild the graph object
mygraph <- graph_from_data_frame( edges, vertices=nodes )

# left
ggraph(mygraph, layout = 'circlepack', weight=level ) + 
  geom_node_circle(aes(fill = depth)) +
  geom_node_text( aes(label=name, filter=leaf, fill=depth, size=1)) +
  theme_void() + 
  theme(legend.position="FALSE") + 
  scale_fill_viridis()
# Right 
ggraph(mygraph, layout = 'circlepack', weight=level ) + 
  geom_node_circle(aes(fill = depth)) +
  geom_node_label( aes(label=name, filter=leaf, size=1)) +
  theme_void() + 
  theme(legend.position="FALSE") + 
  scale_fill_viridis()

