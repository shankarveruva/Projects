#NAME: Shankar Paramatma Veruva
#STUDENT ID: 30513669
#TUTOR NAME: Benjamin Lee
#TUTORIAL NUMBER: 18

# ------------------------------------------------------------------------------------------------------------- #

# Setting up required packages
require(ggplot2)
require(leaflet)
require(shiny)

# Loading the required packages
library(ggplot2)
library(leaflet)
library(shiny)

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

# TASK 3 Extending the static visualisation specified on point 2 into an interactive Shiny visualisation 
# that allows users to choose the type of coral to be displayed and the choice of smoother.

# ui section
uiTask3 <- fluidPage( 
  
  # Application title
  headerPanel("Coral Bleaching In Australia"),
  
  # Sidebar that includes coral type and choice of smoother drop-down
  # Default values are set as the first element for both coral type and smoother
  sidebarLayout(
    sidebarPanel(
      
      # Drop-down for coral type
      selectInput("coralType", "coral type:", 
                  unique(coralsData$coralType)
      ),
      
      # Drop-down for choice of smoother
      selectInput("smoother", "choice of smoother:",
                  list("No Smoother"="ns",
                       "auto"="auto",
                       "lm"="lm",
                       "loess"= "loess",
                       "gam"="gam",
                       "glm"= "glm"
                  ),
      )
      
    ),
    
    # Setting the output as ggplot
    mainPanel(
      plotOutput("ggplot")
    )
  )
)


# server section
serverTask3 <- function(input, output) {
  
  # Generate a plot of the selected coral type and choice of smoother
  output$ggplot <- renderPlot({
    
    # Filter the coral dataset as per selected coral type
    plotData <- coralsData[coralsData$coralType == input$coralType,]
    
    # Initialising the title text as per selected coral type
    titleText <- paste('bleaching rate over the years for', input$coralType, 'and for each site')
    
    # Creating a basic plot
    plot1 <- ggplot(plotData, aes(year, value, color = location)) + 
      geom_point() + 
      facet_grid(~location) +
      theme(axis.text.x=element_text(angle=90, vjust=0.5)) +
      labs(y = 'bleaching rate (%)',
           title = titleText,
           color = 'site location')
    
    # Plotting the desired graph as per selected coral type and choice of smoother
    if (input$smoother == "ns") {
      plot1
    }
    
    else{
      plot1 +
        geom_smooth(method = input$smoother)
    }
  })
}

# Running the app
shinyApp(uiTask3, serverTask3)

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

# TASK 5 Merging the map into your interactive Shiny visualisation. 

# ui section
uiTask5 <- fluidPage( 
  
  # Application title
  headerPanel("Coral Bleaching In Australia"),
  
  # Sidebar that includes coral type and choice of smoother drop-down
  # Default values are set as the first element for both coral type and smoother
  sidebarLayout(
    sidebarPanel(
      # Drop-down for coral type
      selectInput("coralType", "coral type:", 
                  unique(coralsData$coralType)
      ),
      
      # Drop-down for choice of smoother
      selectInput("smoother", "choice of smoother:",
                  list("No Smoother"="ns",
                       "auto"="auto",
                       "lm"="lm",
                       "loess"= "loess",
                       "gam"="gam",
                       "glm"= "glm"
                  ),
      )
      
    ),
    
    # Setting the output as ggplot (for facet graph) and leaflet (for map)
    mainPanel(
      plotOutput("ggplot"), leafletOutput("leaflet")
    )
  )
)


# server section
serverTask5 <- function(input, output) {
  
  # Generate a plot of the selected coral type and choice of smoother
  output$ggplot <- renderPlot({
    
    # Filter the coral dataset as per selected coral type
    plotData <- coralsData[coralsData$coralType == input$coralType,]
    
    # Initialising the title text as per selected coral type
    titleText <- paste('bleaching rate over the years for', input$coralType, 'and for each site')
    
    # Creating a basic plot
    plot1 <- ggplot(plotData, aes(year, value, color = location)) + 
      geom_point() + 
      facet_grid(~location) +
      theme(axis.text.x=element_text(angle=90, vjust=0.5)) +
      labs(y = 'bleaching rate (%)',
           title = titleText,
           color = 'site location')
    
    # Plotting the desired graph as per selected coral type and choice of smoother
    if (input$smoother == "ns") {
      plot1
    }
    
    else{
      plot1 +
        geom_smooth(method = input$smoother)
    }
  })
  
  
  # Generating a leaflet map
  output$leaflet <- renderLeaflet({
    
    # Filter the coral dataset as per selected coral type
    plotData <- coralsData[coralsData$coralType == input$coralType,]
    
    # Creating leaflet map using latitudes and longitudes from dataset and adding label and pop up
    leaflet(data = plotData) %>% 
      addTiles() %>%
      addMarkers(~longitude,
                 ~latitude,
                 label = plotData$location,
                 popup = paste("location:", plotData$location, "<br>",
                               "longitude:", plotData$longitude, "<br>",
                               "latitude:", plotData$latitude)) %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap)
    
  })
}

# Running the app
shinyApp(uiTask5, serverTask5)

# ------------------------------------------------------------------------------------------------------------- #