############################################################################
############################################################################
##  Document Path: ~/Dropbox/Teaching/NOL_Itasca/NoL-2025/NoL-2025_make_figures.R
##
##  Author: Jesús Pinto Ledezma
##
##  Date: 2025-06-28
##
##  Title: First steps in data visualization
##
##  Description: A set of examples for making and interpreting figures 
##
##  R Version: R version 4.5.0 (2025-04-11)
##
#############################################################################
#############################################################################


#############################################################################
###  First step: install necessary libraries
#############################################################################

## {EcoData} for data we will use in this exercise

# remotes::install_github("TheoreticalEcology/EcoData", dependencies = FALSE)

## {tidyverse} for data processing and general data visualization

# install.packages("tidyverse")

# {cowplot} for combining multiple panels 

# install.packages("cowplot")

## {plotly} for advance E3 scatterplot visualizations

# install.packages("plotly)

## {ggtree} and {ape} for phylogenetic visualization

# install.packages("ape")

## {ggtree} is not in CRAN but in a different repository called Bioconductor

# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")

# BiocManager::install("ggtree")

#############################################################################
  

#############################################################################
###  Second step: load installed packages
#############################################################################

library(tidyverse) # Easily Install and Load the 'Tidyverse'
library(EcoData) # A collection of ecological datasets for teaching
library(plotly) # Create Interactive Web Graphics via 'plotly.js' # Create Interactive Web Graphics via 'plotly.js'
library(ape) # Analyses of Phylogenetics and Evolution # Analyses of Phylogenetics and Evolution
library(ggtree) # an R package for visualization of tree and annotation data # an R package for visualization of tree and annotation data
library(cowplot) # Streamlined Plot Theme and Plot Annotations for 'ggplot2'

#############################################################################
  

#############################################################################
###  Third step: inspecting the components of a {ggplot} plot
#############################################################################

# Data: the foundation of any plot, it should be in a data frame format. 

# ggolot(): create a new plot object

# Aesthetics [aes()]: defines how the data is mapped to visual properties, 
# like x and y coordinates, color, size, and shape.

# Geometries [geom_()]: specify the type of plot you want to create 
# (e.g., scatter plot, bar chart, line graph).

# For example:
anolisData %>% # Data
  ggplot(aes(x = attitude, y = awesomeness)) + # Aesthetics
  geom_point() # Geometry

# You can find more examples about which geometry to use here
# https://ggplot2.tidyverse.org/reference/index.html

#############################################################################
  

#############################################################################
###  Fourth step: making our first scatterplot 
#############################################################################

# Let's put our data in the environment
anDT <- anolisData

# Inspect the object anDT. Before making any figure we need first to understand 
# the structure of the data we have at hand
class(anDT)

glimpse(anDT)

# Now let's plot the association between awesomeness and hostility and 
# store the figure in the environment

p1 <- anDT %>% 
  ggplot(aes(
    x = hostility,
    y = awesomeness)
    ) + 
  geom_point() + 
  labs(title = "First step")

p1

#############################################################################
  

#############################################################################
###  Fifth step: improve our first figure
#############################################################################

p2 <- anDT %>%
  ggplot(aes(
    x = hostility,
    y = awesomeness,
    color = island # color points by island
    )
  ) +
  geom_point( # change point size and shape
    size = 3,
    shape = 19
  ) + 
  labs(title = "Second step") + 
  scale_color_viridis_d( # set colors 
    option = "F",
    direction = -1,
    begin = 0,
    end = 0.9
  ) +
  theme_bw() # change the background theme

p2 

#############################################################################
  

#############################################################################
###  Sixth step: adding more tweaks 
#############################################################################

p3 <- anDT %>%
  ggplot(aes(
    x = hostility,
    y = awesomeness,
    color = island # color points by island
  )
  ) +
  geom_point( # change point size and shape
    size = 3,
    shape = 19
  ) +
  scale_color_viridis_d( # set colors and try a different set of colors
    option = "F",
    direction = -1,
    begin = 0,
    end = 0.9
  ) + 
  labs( # change the axis labels
    x = "Mean lizards", 
    y = "Cool lizards", 
    title = "Third step"
  ) + 
  theme_bw() # change the background theme

p3 

#############################################################################
  

#############################################################################
###  Seventh step: final tweaks
#############################################################################

p4 <- anDT %>%
  ggplot(aes(
    x = hostility,
    y = awesomeness,
    color = island # color points by island
  )
  ) +
  geom_point( # change point size and shape
    size = 3,
    shape = 19
  ) +
  scale_color_viridis_d( # set colors and try a different set of colors
    option = "F",
    direction = -1,
    begin = 0,
    end = 0.9, 
    name = "Island" # reformat legend title
  ) + 
  labs( # change the axis labels
    x = "Mean lizards", 
    y = "Cool lizards", 
    title = "Fourth and final step"
  ) + 
  theme_bw() + # change the background theme
  theme(legend.position = "top", 
        legend.title = element_text(size = 15), # increase title of legend's title
        legend.text = element_text(size = 13), # increase legend's labels 
        plot.title = element_text(size = 17, hjust = 0.5), # change title aesthetics
        axis.title = element_text(size = 15), # increase size of label axis title
        axis.text = element_text(size = 13) # increase size of labels
  )

p4 

#############################################################################
  

#############################################################################
###  Eighth step: make our final figure a bit interactive
#############################################################################

# using the function "ggplotly()" of the {plotly} package we can make 
# our scatterplot interactive

ggplotly(p4)

#############################################################################
  

#############################################################################
###  Ninth step: 3D scatterplot
#############################################################################

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

#############################################################################
  

#############################################################################
###  Tenth step: save figures
#############################################################################

getwd()

# Save our final figure
tiff(file = "Downloads/Fig_1_Awesomeness_versus_hostility.tiff", # location where we save the figure
     height = 7, 
     width = 7, 
     res = 500, # resolution
     units = "in", 
     type = "cairo", 
     compression = "lzw") 

p4 

dev.off()

# Lets us combine every panel and see the evolution of the figure

# Save our final figure
tiff(file = "Downloads/Fig_2_Evolution_figure.tiff", # location where we save the figure
     height = 13, 
     width = 13, 
     res = 500, # resolution
     units = "in", 
     type = "cairo", 
     compression = "lzw") 

plot_grid(p1, # panel 1
          p2, # panel 2
          p3, # panel 3
          p4, # panel 4
          ncol = 2, # number of columns in the figure
          nrow = 2, # number of rows in the figure 
          align = "h", 
          labels = c("A)", "B)", 
                     "C)", "D)"), 
          label_size = 20, # labels size
          vjust = 1.25
          ) 

dev.off()

#############################################################################
  

#############################################################################
###  Extra step: visualizing phylogenies
#############################################################################

# Here we are going to use a phylogeny of the same lizards and see 
# their evolutionary relatedness

# as with the data let's store the phylogeny in the environment
anPhy <- anolisTree

##### Using the package {ape} #####

## Basic plot
plot(anPhy) 

## Circular plot with some edits in the species names
plot(anPhy, 
     type = "fan", 
     tip.color = "gray50", 
     cex = 1, # size of names
     edge.width = 3, # width of the branches
     edge.color = "gray50"
     )

##### Using the package {ggtree} #####

p_Phy <- ggtree(anPhy, 
            layout = "circular", 
            color = "gray70") + 
  geom_tiplab(offset = 0.05, color = "gray70")

p_Phy

### Combining phylogeny and data

# replot the phylogeny but increasing the space between the phylogeny and species names
p_Phy2 <- ggtree(anPhy, 
                 layout = "fan", 
                 color = "gray70", 
                 size = 1, 
                 open.angle = 10) + 
  geom_tiplab(size = 4, 
              offset = 0.35, 
              align = TRUE, 
              color = "black")

p_Phy2

##### Combine phylogeny and data #####

# first we need to isolate the data the want to plot and use the species names as rownames
anDT2 <- anDT %>% 
  column_to_rownames("species") %>% # set species as rownames
  select(awesomeness, hostility) %>% # select columns to plot
  rename("Cool" = awesomeness, # rename columns
         "Mean" = hostility)

# Now plot everything together 
p_phy_data <- gheatmap(p_Phy2, # plot with phylogeny
         anDT2, # add data to plot
         offset = 0, 
         width = 0.25,
         colnames_angle = 90, 
         colnames_offset_x = 0,
         colnames_offset_y = 0, 
         font.size = 4, 
         hjust = 0.9, 
         colnames = TRUE
) +
  scale_fill_viridis_c(option = "F", name = "Cool\nMean") # does the legend makes sense?

p_phy_data

#############################################################################
  