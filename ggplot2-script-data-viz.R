# Data Visualisation with ggplot2
# MDCS42270 Bioinformatics analysis of high throughput data
# Lecturer: Dr Carolina Correia
# 04th March 2021

# Exercises were extracted from the online book R for Data Science
# by Hadley Wickham and Garrett Grolemund
# https://r4ds.had.co.nz/data-visualisation.html


# This is a comment


#### 01 Setup ####

# Navigate to Tools > Global Options > Uncheck Restore .RData

# Uncomment lines below to install packages once, then load at the beginning of an analysis
#install.packages(c("renv", "tidyverse"), dependencies = TRUE)

# If you're starting a new analysis, initialise the renv environment
renv::init()
# If prompted to choose an option in the console, review the meaning of the options here:
# https://cran.r-project.org/web/packages/renv/vignettes/faq.html

# If you're coming back to the analysis, uncomment the line below to restore renv environment
# renv::restore()

# renv will help you keep using the same package versions for a project.
# Very useful when you are working on multiple projects that need different package versions.

# Load libraries
library(tidyverse)
library(magrittr)

#### 02 Look at the dataset ####

# We are going to use a dataset that comes with ggplot2
# Check what the help page says about this dataset
help(mpg)

# Look at the first 10 rows and get dimensions (tibble)
mpg

# Look at the first 6 rows  and get dimensions (for regular dataframes)
head(mpg)
dim(mpg)

# Look at the entire dataset
View(mpg) # This function only works in RStudio

#### 03 Creating a ggplot ####

ggplot(data = mpg) + # Tell ggplot2 which dataset to use
  geom_point(mapping = aes(x = displ, y = hwy)) # Map columns from dataset to x and y axes

# displ, a car’s engine size, in litres.

# hwy, a car’s fuel efficiency on the highway, in miles per gallon (mpg).
# A car with a low fuel efficiency consumes more fuel than a car with a high
# fuel efficiency when they travel the same distance.

# The plot shows a negative relationship between engine size (displ) and
# fuel efficiency (hwy). In other words, cars with big engines use more fuel.

#### 04 Mapping additional aesthetics ####

ggplot(data = mpg) + # Tell ggplot2 which dataset to use
  geom_point(mapping = aes(x = displ, y = hwy, colour = class)) # Map columns from dataset to x and y axes, and define colour by type of car

# The class variable of the mpg dataset classifies cars into groups such as
# compact, midsize, and SUV.

#### 05 Layer multiple geometries in a single plot ####

# When using multiple geoms, it's best to apply local mapping
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # Tell ggplot2 which dataset to use and map columns from dataset to x and y axes
  geom_point(mapping = aes(colour = class)) + # Map columns from dataset to define colour by type of car
  geom_smooth() # Add a second geom in a separate layer

# By default, geom_smooth computes a smooth local regression and fits it to the data.
# This helps us add a smoothing line in order to see what the trends look like.

# What happens if you apply global mapping
ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point(aes(colour = class)) +
  geom_smooth()

# A geom is the geometrical object that a plot uses to represent data.
# People often describe plots by the type of geom that the plot uses.
# For example, bar charts use bar geoms, line charts use line geoms,
# boxplots use boxplot geoms, and so on. Scatterplots break the trend;
# they use the point geom.

#### 06 Customising a ggplot ####

# Change axes labels
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # Tell ggplot2 which dataset to use and map columns from dataset to x and y axes
  geom_point(mapping = aes(colour = class)) + # Map columns from dataset to define colour by type of car
  geom_smooth() + # Add a second geom in a separate layer
  xlab("Engine size") + # Change label on x axis without changing the dataset's column name
  ylab("Fuel efficiency in the highway") # Change label on y axis without changing the dataset's column name

# Add title, subtitle, and caption
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # Tell ggplot2 which dataset to use and map columns from dataset to x and y axes
  geom_point(mapping = aes(colour = class)) + # Map columns from dataset to define colour by type of car
  geom_smooth() + # Add a second geom in a separate layer
  xlab("Engine size") + # Change label on x axis without changing the dataset's column name
  ylab("Fuel efficiency in the highway") + # Change label on y axis without changing the dataset's column name
  labs(title = "Relationship between engine size and fuel efficiency",
          subtitle = "Cars with big engines use more fuel",
          caption = "Data source: EPA")

#### 07 Apply a facet to a ggplot ####

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # Tell ggplot2 which dataset to use and map columns from dataset to x and y axes
  geom_point() + # Removed colour mapping by type of car
  geom_smooth() + # Add a second geom in a separate layer
  facet_wrap(~ class, nrow = 2) + # Split plot into facets by type of car. Each subplot display one subset of the data.
  xlab("Engine size") + # Change label on x axis without changing the dataset's column name
  ylab("Fuel efficiency in the highway") + # Change label on y axis without changing the dataset's column name
  labs(title = "Relationship between engine size and fuel efficiency",
       subtitle = "Cars with big engines use more fuel",
       caption = "Data source: EPA") -> mpg_plot

#### 08 Save ggplot to a file ####

ggsave("engine_fuel_plot.png", # Name of the file to be created with the plot. You can also replace .png with .pdf
       plot = mpg_plot, # Variable that points to the plot in the R environment
       path = NULL, # If NULL, file you'll be save in your working directory. Otherwise, you can tell the function where to save it
       width = 10, # Define the plot's width
       height = 6, # Define the plot's height
       units = "in", # Unit used for determining plot's size. Can also be "cm" or "mm"
       dpi = 300, # High quality for printing
       limitsize = FALSE) # Tell ggsave not to limit the size of the file
