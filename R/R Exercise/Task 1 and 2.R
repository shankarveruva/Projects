#NAME: Shankar Paramatma Veruva
#STUDENT ID: 30513669
#TUTOR NAME: Benjamin Lee
#TUTORIAL NUMBER: 18
#TASKS: 1,2

# ------------------------------------------------------------------------------------------------------------- #

# Setting up required packages
require(ggplot2)

# Loading the required packages
library(ggplot2)

# ------------------------------------------------------------------------------------------------------------- #

# TASK 1 Loading the dataset into R
coralsData <- read.csv(file = 'assignment-02-data-formated.csv')

# Checking the dimension of coral data
dim(coralsData)

# Checking first few records of coral data
head(coralsData)

# Checking the summary of coral data
summary(coralsData)

# Checking the structure of coral data
str(coralsData)

# We see that the bleaching rate (value) is in the form of factor. Hence, we need to convert it into numeric.
# This will substitute % with nothing and convert value into character
coralsData$value <- sub("%","",coralsData$value)   

# This will convert value into num
coralsData$value <- as.numeric(coralsData$value)   

# Let's check again if value has been changed to num
str(coralsData)

# ------------------------------------------------------------------------------------------------------------- #

# TASK 2 Creating a static visualisation using ggplot2 that shows how the bleaching varies over the years for each type of coral and for each site.

# TASK 2.1 The visualisation uses faceting with each facet showing the bleaching for a type of coral at one site across the time period.

# Creating a basic plot
plot1 <- ggplot(coralsData, aes(year, value, colour = coralType)) + 
  geom_point() + 
  theme(axis.text.x=element_text(angle=90, vjust=0.5)) +
  labs(y = 'bleaching rate (%)',
       title = 'bleaching rate over the years for each coral type and for each site',
       color = 'coral type')

# Faceting with each facet showing the bleaching for a coral type at one site across the time period.
plot2 <- plot1 + facet_grid(coralType~location)

# Displaying the plot
plot2

# ------------------------------------------------------------------------------------------------------------- #

# TASK 2.2 Reordering data as per latitude (descending order)
coralsData <- coralsData[order(coralsData$latitude,decreasing = TRUE),]

# Changing the levels for location as per descending order of latitude
coralsData$location <- factor(coralsData$location, levels=unique(coralsData$location))

# Let's check if location level has changed
str(coralsData)

# ------------------------------------------------------------------------------------------------------------- #

# TASK 2.2.1 Same as TASK 2.1, only difference - visualisation as per ordered latitudes of site/location.
# REF: https://stackoverflow.com/questions/14262497/fixing-the-order-of-facets-in-ggplot

# Creating basic plot
plot1 <- ggplot(coralsData, aes(year, value, colour = coralType)) + 
  geom_point() + 
  theme(axis.text.x=element_text(angle=90, vjust=0.5)) +
  labs(y = 'bleaching rate (%)',
       title = 'bleaching rate over the years for each coral type and for each site',
       color = 'coral type')

# Faceting with each facet showing the bleaching for a coral type at one site (reordered based on latitude) across time period
plot3 <- plot1 + 
  facet_grid(coralType~location)

# Displaying the plot
plot3

# ------------------------------------------------------------------------------------------------------------- #

# TASK 2.3 Same as TASK 2.2.1, only addition - line smoothing

# Faceting with each facet showing line smoothing for a coral type at one site across time period
finalPlot <- plot3 +
  geom_smooth(method = 'lm')

# Displaying the plot
finalPlot

# ------------------------------------------------------------------------------------------------------------- #
