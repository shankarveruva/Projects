#NAME: Shankar Paramatma Veruva
#STUDENT ID: 30513669
#TUTOR NAME: Benjamin Lee
#TUTORIAL NUMBER: 18
#TASKS: 3

# ------------------------------------------------------------------------------------------------------------- #

# Setting up required packages
require(ggplot2)
require(shiny)

# Loading the required packages
library(ggplot2)
library(shiny)

# ------------------------------------------------------------------------------------------------------------- #

# TASK 1 Loading the dataset into R
coralsData <- read.csv(file = 'assignment-02-data-formated.csv')

# Checking the structure of coral data
str(coralsData)

# We see that the bleaching rate (value) is in the form of factor. Hence, we need to convert it into numeric.
# This will substitute % with nothing and convert value into character
coralsData$value <- sub("%","",coralsData$value)   

# This will convert value into num
coralsData$value <- as.numeric(coralsData$value)   

# ------------------------------------------------------------------------------------------------------------- #

# TASK 2.2 Reordering data as per latitude (descending order)
coralsData <- coralsData[order(coralsData$latitude,decreasing = TRUE),]

# Changing the levels for location as per descending order of latitude
coralsData$location <- factor(coralsData$location, levels=unique(coralsData$location))

# Let's check if location level has changed
str(coralsData)

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
