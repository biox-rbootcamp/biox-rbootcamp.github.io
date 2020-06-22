

ccnet = network(ccnb1_net, directed = FALSE)


ccdf = ggnetwork(ccnet)

ggf = ggplot(ccdf,aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(curvature=0.1) + 
  geom_nodes(aes(x = x, y = y),size = 14,color = "#8856a7") +
  geom_nodetext(aes(label = vertex.names),size = 3,color = "white") +
  theme_blank() + 
  theme(legend.position = "none")