#remotes::install_github("TheoreticalEcology/EcoData", dependencies = FALSE)
#https://ggplot2.tidyverse.org/reference/index.html
library(tidyverse)
library(EcoData)

?EcoData

?anolisData

anDT <- anolisData %>% 
  column_to_rownames("species")

glimpse(anDT)

anDT %>% 
  ggplot(aes(x = hostility, 
             y = awesomeness, 
             color = island)) + 
  geom_point(size = 3, 
             shape = 19) + 
  scale_color_viridis_d(option = "F", 
                        direction = -1, 
                        begin = 0, 
                        end = 0.9) + 
  theme_bw()



anDT %>% 
  ggplot(aes(x = hostility, 
             y = awesomeness, 
             color = island)) + 
  geom_point(size = 3, 
             shape = 19) + 
  scale_color_viridis_d(option = "F", 
                        direction = -1, 
                        begin = 0, 
                        end = 0.9, 
                        name = "Island") + 
  labs(x = "Mean lizards", 
       y = "Cool lizards") + 
  #theme_bw() + 
  facet_grid(island ~ .) + 
  theme_linedraw(base_size = 16) + 
  theme(legend.position = "top", 
        axis.title = element_text(size = 15), 
        axis.text = element_text(size = 13)
        )


anDT %>% 
  ggplot(aes(x = hostility, 
             y = awesomeness, 
             color = island, 
             fill = island)
         ) + 
  geom_hex(bins = 40) 


anDT %>% 
  ggplot(aes(x = island, y = awesomeness, fill = island)) + 
  geom_boxplot() + 
  scale_color_viridis_d(option = "F", 
                        direction = -1, 
                        begin = 0, 
                        end = 0.9) + 
  scale_fill_viridis_d(option = "F", 
                        direction = -1, 
                        begin = 0, 
                        end = 0.9) + 
  theme_bw()



anDT %>% 
  ggplot(aes(as_factor(island), fill = ecomorph)) + 
  geom_bar()


anDT %>% 
  ggplot(aes(x = awesomeness)) + 
  geom_histogram() + 
  facet_grid(island ~ .) + 
  theme_bw()


library(plotly)

anDT %>% 
  plot_ly(x = ~hostility,  
          y = ~awesomeness,
          z = ~attitude, 
          color = ~island, 
          colors = viridis::viridis(n = 5, 
                                    option = "F", 
                                    begin = 0, 
                                    end = 0.9, 
                                    direction = 1) 
          
          )


# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("ggtree")

library(ggtree)
library(ape)

anPhy <- anolisTree

plot(anPhy)
axisPhylo()

p <- ggtree(anPhy, layout = "circular") + 
  geom_tiplab(offset = 0.5)

p

gheatmap(p, 
         anDT %>% 
           select(awesomeness, hostility), 
         offset = 0.05, 
         width = 0.3,
         colnames_angle = 90, 
         colnames_offset_y = .5
         ) +
  scale_fill_viridis_c(option = "A", name = "Awesome\nHostile")

