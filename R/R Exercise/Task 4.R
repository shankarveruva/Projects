#NAME: Shankar Paramatma Veruva
#STUDENT ID: 30513669
#TUTOR NAME: Benjamin Lee
#TUTORIAL NUMBER: 18
#TASKS: 4

# ------------------------------------------------------------------------------------------------------------- #

# Setting up required packages
require(leaflet)

# Loading the required packages
library(leaflet)

# ------------------------------------------------------------------------------------------------------------- #

# TASK 1 Loading the dataset into R
coralsData <- read.csv(file = 'assignment-02-data-formated.csv')

# ------------------------------------------------------------------------------------------------------------- #

# TASK 4 Creating a map using Leaflet that shows the location of the sites.

# https://leaflet-extras.github.io/leaflet-providers/preview/
# https://stackoverflow.com/questions/31562383/using-leaflet-library-to-output-multiple-popup-values

# Creating leaflet map using latitudes and longitudes from dataset and adding label and pop up
map <- leaflet(data = coralsData) %>% 
  addTiles() %>%
  addMarkers(~longitude,
             ~latitude,
             label = coralsData$location,
             popup = paste("location:", coralsData$location, "<br>",
                           "longitude:", coralsData$longitude, "<br>",
                           "latitude:", coralsData$latitude)) %>%
  addProviderTiles(providers$Esri.NatGeoWorldMap)

# Displaying the map
map

# ------------------------------------------------------------------------------------------------------------- #
