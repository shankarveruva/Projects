#NAME: Shankar Paramatma Veruva
#STUDENT ID: 30513669
#TUTOR NAME: Benjamin Lee
#TUTORIAL NUMBER: 18
#ASSIGNMENT: FIT5147 Narrative Visualisation Project

# ------------------------------------------------------------------------------------------------------------- #

# Loading required packages
library('shiny')
library('shinydashboard')
library('leaflet')
library('plotly')
library('dplyr')
library('shinythemes')
library('ggplot2')
library('rvest')
library('xml2')

#### ----------------------------------------------------------------------------------------------------- ####

# Read climbing file
climbingData <- read.csv(file = 'climbing_statistics.csv')

# Renaming the columns
colnames(climbingData) <- c("date","route","attempted","succeeded")

# Convert into date format
climbingData$date <- as.Date(climbingData$date, format = "%m/%d/%Y")

# Convert routes into characters
climbingData$route <- as.factor(climbingData$route)

# If attempts are less than the successful attempts, make them same
climbingData[climbingData$attempted < climbingData$succeeded, c('succeeded')] <- climbingData[climbingData$attempted < climbingData$succeeded, c('attempted')]

# Aggregating attempts and succeeded based on date
climbingData <- aggregate(climbingData[,c(3,4)], by=climbingData[,c(1,2)], FUN = sum)

# Calculating failed attempts
climbingData$failed <- climbingData$attempted - climbingData$succeeded

# Now let's split date column into month, day and year respectively
# REF: https://stackoverflow.com/questions/17496358/r-help-converting-factor-to-date
# Fetch date parts
# Day
climbingData$day <- weekdays(climbingData$date, abbreviate = TRUE)
climbingData$day <- factor(climbingData$day, levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

# Month
climbingData$month <- months(climbingData$date, abbreviate = TRUE)
climbingData$month <- factor(climbingData$month, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov","Dec"))

# Year
climbingData$year <- as.integer(format(climbingData$date, format = "%Y"))

# ------------------------------------------------------------------------------------------------------------- #

# This particular route was duplicated with and without apostrophe. So changing the route name
climbingData[climbingData$route=='Fuhrers Finger',]$route <- "Fuhrer's Finger"

# Agregating number of attempts based on month and route names
routesPerMonth <- aggregate(climbingData[,c(3,4,5)], by=climbingData[,c(2,7)], FUN = sum)

# Creating a list of routes in decreasing order of overall attempts made
routes <- aggregate(climbingData[,c(3,4,5)], by=list(climbingData[,c(2)]), FUN = sum)
colnames(routes)[1] <- 'route'
routes <- routes[order(-routes$attempted),]

# Duplicating the df to prepare a df for popular routes
attemptsPerRoute <- routes

# Setting the routes as factors
attemptsPerRoute$route <- factor(routes$route, levels = unique(routes$route)[order(routes$attempted, decreasing = FALSE)])

# Picking only top 5 popular routes
attemptsPerRoute <- attemptsPerRoute[1:5,]

# ------------------------------------------------------------------------------------------------------------- #

# Number of attempts and success percentage per year

# Aggregate succeeded and failed attempts per year
attemptsPerYear <- aggregate(climbingData[,c(3,4,5)], by=list(climbingData$year), FUN = sum)

# Rename the columns
colnames(attemptsPerYear)[1] <- 'year'

# Creating success per year df from the previous one
successPerYear <- attemptsPerYear

# Dropping columns that aren't required
successPerYear[,c(3,4)] <- NULL

# Rename the existing columns
colnames(successPerYear) <- c('year', 'successPercentage')

# Calculate success percentage
successPerYear$successPercentage <- attemptsPerYear$succeeded/attemptsPerYear$attempted * 100

# Rounding off success percentage upto 2 decimal points
successPerYear[,2] <- round(successPerYear[,2],2)

# ------------------------------------------------------------------------------------------------------------- #

# Number of attempts and success percentage per month

# Aggregate succeeded and failed attempts per month
attemptsPerMonth <- aggregate(climbingData[,c(3,4,5)], by=list(climbingData$month), FUN = sum)

# Rename the columns
colnames(attemptsPerMonth)[1] <- 'month'

# Creating success per month df from the previous one
successPerMonth <- attemptsPerMonth

# Dropping columns that aren't required
successPerMonth[,c(3,4)] <- NULL

# Rename the eisting columns
colnames(successPerMonth) <- c('month', 'successPercentage')

# Calculate success percentage
successPerMonth$successPercentage <- attemptsPerMonth$succeeded/attemptsPerMonth$attempted * 100

# Rounding off success percentage upto 2 decimal points
successPerMonth[,2] <- round(successPerMonth[,2],2)

# ------------------------------------------------------------------------------------------------------------- #

# Number of attempts and success perentage per day

# Aggregate succeeded and failed attempts per day
attemptsPerDay <- aggregate(climbingData[,c(3,4,5)], by=list(climbingData$day), FUN = sum)

# Rename the columns
colnames(attemptsPerDay)[1] <- 'day'

# Creating success per day df from the previous one
successPerDay <- attemptsPerDay

# Dropping columns that aren't required
successPerDay[,c(3,4)] <- NULL

# Rename the existing columns
colnames(successPerDay) <- c('day', 'successPercentage')

# Calculate success percentage
successPerDay$successPercentage <- attemptsPerDay$succeeded/attemptsPerDay$attempted * 100

# Rounding off success percentage upto 2 decimal points
successPerDay[,2] <- round(successPerDay[,2],2)

#### ----------------------------------------------------------------------------------------------------- ####

# URL of weatherbase from where I'll fetch weather related stats
url <- "https://www.weatherbase.com/weather/weather.php3?s=498654&cityname=Mount-Rainier-National-Park-Washington-United-States-of-America&units=us"

# Read the html content from the site
webpage <- read_html(url)

# Using CSS selectors to scrape the data section
content <- html_nodes(webpage,'.data')

# Converting the data to text
content <- html_text(content)

# Converting --- to 0
for(i in 1:length(content)){
  if(content[i]=="---")
    content[i] <- 0
}

# Converting the text to numbers
content <- as.numeric(content)

# Split the data into 11 parts so as to separate data as per parameters such as avg temp, precipitation etc
statistics <- split(content, ceiling(seq_along(content)/13))

#### ----------------------------------------------------------------------------------------------------- ####

# Using CSS selectors to scrape recording years and topic
titles <- html_nodes(webpage,'.years , #h4font')

# Converting the data to text
titles <- html_text(titles)

# Trimming the spaces
titles <- gsub("^\\s+|\\s+$", "", titles)

# Creating dataframe to store the recording years and topic
record <- data.frame()

# Assigning the paramter (topic)
j <- 1
for(i in seq(1,length(titles),2)){
  record[j,'type'] <- titles[i]
  j <- j + 1
}

# Assigning the reording in terms of years
j <- 1
for(i in seq(2,length(titles),2)){
  record[j,'recording'] <- titles[i]
  j <- j + 1
}

#### ----------------------------------------------------------------------------------------------------- ####


# Using CSS selectors to scrape the months
all.labels <- html_nodes(webpage,'td')

# Converting the data to text
all.labels <- html_text(all.labels)

# Creating an empty list to store months
month.list <- c()

# Extracting only months
j <- 1
for (i in seq(32,54,2)){
  month.list[j] <- all.labels[i]
  j <- j + 1
}

# Trimming the spaces
month.list <- gsub("^\\s+|\\s+$", "", month.list)

# Converting months into factor
month.list <- factor(month.list, levels = unique(month.list))

#### ----------------------------------------------------------------------------------------------------- ####

# AVG TEMP

# Number of years on record
avg.temp.recording <- record[1,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for avg temp
j <- 1
for(i in (2:length(statistics$`1`))){
  value.list[j] <- statistics$`1`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
average.temp <- data.frame(month.list, value.list)
colnames(average.temp) <- c('Month', 'Value')
average.temp$Type <- 'Average Temperature (F)'

#### ----------------------------------------------------------------------------------------------------- ####

# AVG HI TEMP

# Number of years on record
avg.high.temp.recording <- record[2,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for avg high temp
j <- 1
for(i in (2:length(statistics$`2`))){
  value.list[j] <- statistics$`2`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
average.high.temp <- data.frame(month.list, value.list)
colnames(average.high.temp) <- c('Month', 'Value')
average.high.temp$Type <- 'Average High Temperature (F)'

#### ----------------------------------------------------------------------------------------------------- ####

# AVG LOW TEMP

# Number of years on record
avg.low.temp.recording <- record[3,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for avg low temp
j <- 1
for(i in (2:length(statistics$`3`))){
  value.list[j] <- statistics$`3`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
average.low.temp <- data.frame(month.list, value.list)
colnames(average.low.temp) <- c('Month', 'Value')
average.low.temp$Type <- 'Average Low Temperature (F)'

# Combining average temp, average high temp and average low temp into one dataframe
combined.temp <- rbind(average.temp,average.high.temp,average.low.temp)

#### ----------------------------------------------------------------------------------------------------- ####

# PRECIPITATION

# Number of years on record
precipitation.recording <- record[4,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for precipitation
j <- 1
for(i in (2:length(statistics$`4`))){
  value.list[j] <- statistics$`4`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
precipitation <- data.frame(month.list, value.list)
colnames(precipitation) <- c('Month', 'Value')
precipitation$Type <- 'Average Precipitation (In)'

#### ----------------------------------------------------------------------------------------------------- ####

# NUMBER OF DAYS WITH PRECIPITATION

# Number of years on record
precipitation.days.recording <- record[5,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for number of days with precipitation
j <- 1
for(i in (2:length(statistics$`5`))){
  value.list[j] <- statistics$`5`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
precipitation.days <- data.frame(month.list, value.list)
colnames(precipitation.days) <- c('Month', 'Value')
precipitation.days$Type <- 'Number Of Days With Precipitation (Days)'

#### ----------------------------------------------------------------------------------------------------- ####

# HIGHEST RECORDED TEMP

# Number of years on record
highest.temp.recording <- record[6,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for highest recorded temp
j <- 1
for(i in (2:length(statistics$`6`))){
  value.list[j] <- statistics$`6`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
highest.temp <- data.frame(month.list, value.list)
colnames(highest.temp) <- c('Month', 'Value')
highest.temp$Type <- 'Highest Recorded Temperature (F)'

#### ----------------------------------------------------------------------------------------------------- ####

# LOWEST RECORDED TEMP

# Number of years on record
lowest.temp.recording <- record[7,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for lowest recorded temp
j <- 1
for(i in (2:length(statistics$`7`))){
  value.list[j] <- statistics$`7`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
lowest.temp <- data.frame(month.list, value.list)
colnames(lowest.temp) <- c('Month', 'Value')
lowest.temp$Type <- 'Lowest Recorded Temperature (F)'

# Combining the highest and lowest monthly temp into one dataframe
temp <- rbind(highest.temp,lowest.temp)

#### ----------------------------------------------------------------------------------------------------- ####

# AVG LENGTH OF DAY

# Number of years on record
average.length.day.recording <- record[8,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for average length of the day
j <- 1
for(i in (2:length(statistics$`8`))){
  value.list[j] <- statistics$`8`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
average.length.day <- data.frame(month.list, value.list)
colnames(average.length.day) <- c('Month', 'Value')
average.length.day$Type <- 'Average Length Of Day (Hours)'

#### ----------------------------------------------------------------------------------------------------- ####

# AVG NO OF DAYS ABOVE 90F

# Number of years on record
days.above.recording <- record[9,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for average number of days above 90F
j <- 1
for(i in (2:length(statistics$`9`))){
  value.list[j] <- statistics$`9`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
days.above.90F <- data.frame(month.list, value.list)
colnames(days.above.90F) <- c('Month', 'Value')
days.above.90F$Type <- 'Average Number Of Days Above 90F OR 32C (Days)'

#### ----------------------------------------------------------------------------------------------------- ####

# AVG NO OF DAYS BELOW 32F

# Number of years on record
days.below.recording <- record[10,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for average number of days below 32F
j <- 1
for(i in (2:length(statistics$`10`))){
  value.list[j] <- statistics$`10`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
days.below.32F <- data.frame(month.list, value.list)
colnames(days.below.32F) <- c('Month', 'Value')
days.below.32F$Type <- 'Average Number Of Days Below 32F OR 0C (Days)'

# Combining number of days above 90F and below 32F into one dataframe
days <- rbind(days.above.90F, days.below.32F)

#### ----------------------------------------------------------------------------------------------------- ####

# AVG SNOWFALL

# Number of years on record
snow.recording <- record[11,'recording']

# Creating an empty list to store values
value.list <- c()

# Extracting values for avg snowfall
j <- 1
for(i in (2:length(statistics$`11`))){
  value.list[j] <- statistics$`11`[i]
  j <- j + 1
}

# Creating a dataframe with month, value and type information
snowfall <- data.frame(month.list, value.list)
colnames(snowfall) <- c('Month', 'Value')
snowfall$Type <- 'Average Snowfall (In)'

#### ----------------------------------------------------------------------------------------------------- ####

# Shiny UI
ui <- fluidPage(
  titlePanel(img(src = "mount rainier title.png", width=1500), windowTitle = 'Mount Rainier'),
  navbarPage(
    "MOUNT RAINIER",
    theme = shinytheme(theme = 'flatly'),
    tabPanel(
      # First tab
      "Introduction",
      fluidPage(
        # Basic introdution
        p("THINKING ABOUT HEADING TO MOUNT RAINIER OR WANT TO KNOW SOME INTERESTING FACTS ABOUT MOUNT RAINIER??", style="text-align: center; font-weight: bold;"),
        p("WELL, GO READ ON THE INFO AND CHECKOUT DETAILS ABOUT THE CLIMBING STATS, ROUTES AND WEATHER ON OTHER TABS!!", style="text-align: center; font-weight: bold;"),
        h3('Mount Rainier, Washington', align='center'),br(),
        column(
          6,
          p("Mount Rainier is perhaps the single most impressive mountain in the 48 contiguous United States. It ranks fifth in height, a tiny bit lower than California's Mt. Whitney (14,494'/4418m) and three Sawatch Range peaks in Colorado. And it ranks second to Mount Shasta in total volume for a single peak. But no other peak has the combination of high elevation, massive bulk, and extensive glaciation--and Mt. Rainier stands alone in splendid isolation, with only 40 miles separating sea level at Puget Sound from its glacier-clad summit. No other peak nearby even remotely challenges its supremacy.", style="text-align: justify;"),br(),
          p("In most of the United States, a hike of 3000 vertical feet to the summit of a peak is considered about average; 4000 to 5000 vertical feet is considered a very long and extremely tiring trip, and anything above 6000 vertical feet is rare and devastatingly difficult. However, Mt. Rainier, by its easiet route, requires ascending 9000 vertical feet (2740m). This distance is the same as for the climb from advance basecamp in the Western Cwm to the summit of Mt. Everest.", style="text-align: justify;"),br(),
          p("Even though Rainier's elevation is low by the standards of the Himalaya and the Andes, there are only 20 mountains on earth have more topographic prominence--it just beats out K2 for spot #21 on the list of most prominence peaks on earth. Mount Whitney, at #81, is the next peak in the contiguous USA on that list.", style="text-align: justify;"),br(),
          p("Mt. Rainier can be seen from 150 miles away, and makes an appropriate design for Washington's license plate, since it's visible from such a large chunk of the state. Looming over Seattle and Tacoma, sometimes above the layer of clouds, Rainier has an overwhelming presence like that of few other peaks in the world.", style="text-align: justify;"),br(),
          p("The upper mountain is covered with large glaciers and snowfields covering over 30 square miles, much of this terrain covered with yawning crevasses. To the casual tourist or climber, the only current evidence of volcanic activity on the mountain is some ice caves in the small, shallow summit crater, created by steam melting the snow. However, geologists consider Rainier an active volcano, and small eruptions were seen in in 1894-1895. As recently as the year 1400 a devastating lahar from the slopes of the mountain inundated large areas of lowland with thick mud deposits.", style="text-align: justify;"),br(),
          p("To know how many attempts were made, how many of them were successful and how many of them failed, checkout next tab!", style="text-align: center; font-weight: bold;"),
        ),
        column(
          6,
          # Displaying map and overview
          leafletOutput("leaflet", height=300, width = 700),
          h4("OVERVIEW", style="text-align: center;"),
          strong('Location: '),span('Washington, USA'),br(),
          strong('Elevation: '),span('14,411 feet, 4392 meters'),br(),
          strong('True Isolation: '),span('731.18 mi, 1176.72 km'),br(),
          strong('Alternate Name(s): '),span('Mount Tahoma, Mount Tacoma'),br(),
          strong('Peak Type: '),span('Volcano'),br(),
          strong('Latitude/Longitude: '),span('46.852947, -121.760424 (Dec Deg)'),br(),
          strong('First Ascent: '),span('1870 by Hazard Stevens and P. B. Van Trump'),br(),
          strong('Last Eruption: '),span('November to December 1894'),br(),
          strong('Common Routes Taken: '),span('Disappointment Cleaver, Emmons-Winthrop and Ingraham District'),br(),
          strong('Best Time To Visit: '),span('June - August'),br()
        )
      )
    ),
    
    tabPanel(
      # Second tab
      "Attempts",
      fluidPage(
        # Sidebar from where user can choose the level of granularity
        sidebarLayout(
          sidebarPanel(
            
            helpText("Select yearly, monthly or weekday granularity to view trends and hover over chart area to view stats."),
            
            selectInput("granularity", "Level Of Granularity:",
                        list("Yearly"="year",
                             "Monthly"="month",
                             "Weekday"="day"
                        )
            ), width = 2
          ),
          # Main panel where graph is displayed based on user selection
          mainPanel(
            plotlyOutput("routesPerGranularity", width = 1200), br(),
            htmlOutput('routesGranularity')
          )
        )
      )
    ),
    
    tabPanel(
      # Third tab
      "Popular Routes",
      fluidPage(
            plotlyOutput("attemptsPerRoute", width = 1200,height=400), br(),
            htmlOutput('attempts.route.text')
        )
    ),
    
    tabPanel(
      # Fourth tab
      "Attempts per Routes",
      fluidPage(
        # Sidebar from where user can select route name and checkout it's monthly trend
        sidebarLayout(
          sidebarPanel(
            
            helpText("Select a route to view trends over year and hover over chart area to view stats."),
            
            selectInput("route.name", "Routes:",
                        unique(routes$route)
            ), width = 2,
            helpText("Find out the routes which were taken during odd times of the year and how did that end up for the climbers."),
          ),
          # Main panel where graph is displayed based on user selection
          mainPanel(
            plotlyOutput("routesPerMonth", width = 1200),
            htmlOutput('route.text')
          )
        )
      )
    ),
    
    tabPanel(
      # Fifth tab
      "Weather Trends",
      fluidPage(
        # Sub tab panel which consists of weather stats
        tabsetPanel(
          tabPanel("Temperature", 
                   plotlyOutput("temp.plot",height = 300, width=1000), br(),
                   span('The red line shows the average monthly high temperature, blue line shows the average monthly low temperature and green line shows the average monthly temperature in fahrenheit. At Mt. Rainier, winter season stretches from December to Februrary, spring season from March to May, summer season from June to August and autumn season from September to November.'), br(),
                   span(strong('The best time to visit Mt. Rainier is when the temperature is on the higher side i.e. Jun to Aug.')), br(),br(), br(),
                   plotlyOutput("temp.plot2",height = 300, width=1000), br(),
                   span('The above graph shows the lowest and the highest monthly temperature recorded since the past 70 years. The red line shows the monthly highest temperature recorded where as the blue line shows the monthly lowest temperature recorded in fahrenheit. The lowest and highest monthly temperature ranges from -9F to 105F respectively over a year. August has recorded the highest temperature with 105F whereas January has recorded the lowest temperature with -9F!')),
          tabPanel("Precipitation", 
                   plotlyOutput("precipitation.plot",height = 300, width=1000), br(),
                   span('The wettest month is December with average monthly precipitation of 13.7 inches while the driest month is July with average monthly precipitation of 1.4 inches. The above statistics are based on past 48 years. At Mt. Rainier, it rains heavily from November to January. So, make sure to visit this place during summer season to be able to enjoy trekking and camping experience.'),br(), br(), br(),
                   plotlyOutput("precipitation.days.plot",height = 300, width=1000), br(),
                   span('It generally rains throughout the year at Mt. Rainier. As mentioned earlier, July is the driest month with only 6 number of days with preipitation whereas December and January are the wettest months with about 21 days with precipitation!')),
          tabPanel("Day Light", 
                   plotlyOutput("average.length.day.plot",height = 300, width=1000), br(),
                   span('The average monthly legnth of the day is generally shorter during winter season and longest during summer season with just 9.2 hours of day light in the month of December whereas about 16.5 hours of day light in the month of July. The average length of the day is longest during summer season while it decreases drastically during winters.')),
          tabPanel("Number Of Days Above 90F Or Below 32F", 
                   plotlyOutput("days.temp.plot",height = 300, width=1000), br(),
                   span('It is a rare occurrence to have number of days above 90F at Mt. Rainier! On most days, the temperature is below 32F. December and January have the most number of cold days with 27.7 and 26 days.')),
          tabPanel("Snowfall", 
                   plotlyOutput("snow.plot",height = 300, width=1000), br(),
                   span('Mt. Rainier has experiences heavy snowfall during the winter season. The average snowfall over the year is 185.4 inches while the most snowfall happens during December and January with 37.8 and 50.6 inches. There is no snowfall during the summer season, late spring and early autumn.'), br(),
                   p('<--- CHECKOUT SOME PICS AND PUNS ON THE NEXT NAVIGATION TAB! --->', style="text-align: center; font-weight: bold;"))
          
        )
        ),
      ),
    
    tabPanel(
      # Sixth tab
      "Pics and Puns",
      fluidPage(
        column(6,
               img(src = "mount rainier spring.png", width=500, height=300),
               p('Mount Rainier during spring and early summer.'), br(),
               strong("Q. What kind of music does a mountain like?"), br(),span('A. Rock music!'),br(),br(),
               img(src = "Emmons Glacier.png", width=500, height=300),
               p('Traversing the Emmons Glacier (2014-08-09). Photo by Aditya Sankar.'),br(),
               strong("Q. What do you call an attractive volcano?"), br(),span('A. Lava-ble!'),br(),br(),
               img(src = "Anne pic.png", width=500, height=300),
               p('Experiencing sunrise just below the summit of Mt. Rainier. Photo by Annie Dube.')
               ),
        column(6,
               img(src = "Disappointment Cleaver2.png", width=500, height=300),
               p('Team descending the cleaver after successful summit (2014-09-22). Photo by Ken Curtis.'),br(),
               strong("Q. What do mountains wear to keep warm?"), br(),span('A. Snowcaps!'),br(),br(),
               img(src = "Daria pic.png", width=500, height=300),
               p('Crevasse photo by Daria.'),br(),
               strong("Q. What do you call a funny mountain?"), br(),span('A. Hill-arious!'),br(),br(),
               img(src = "Disappointment Cleaver.png", width=500, height=300),
               p('Just above the Disappointment Cleaver (2006-06-20). Photo by Andrew Knell.')
               )
      ),
    )
    )
  )




# Shiny server
server <- function(input, output) {
  
  # Generating a leaflet map to show Mt. Rainier
  output$leaflet <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  
      addMarkers(lng=-121.760424, lat=46.852947, popup="Mount Rainier") %>% 
      setView(lng=-121.760424, lat=46.852947, zoom = 13)
  })
  
  # Generate a plot of monthly temp (avg, high and low)
  output$temp.plot <- renderPlotly({
    ggplotly(
      ggplot() +
        geom_line(data=combined.temp, mapping = aes(x=Month, y=Value, color=Type), group=1) +
        geom_point(data=combined.temp, mapping = aes(x=Month, y=Value, color=Type)) +
        theme_classic() +
        labs(x = 'Months',
             y = 'Temperature in Fahrenheit',
             title = paste('Average Monthly Temperature In Fahrenheit (',avg.temp.recording, ')',sep = ' ')) +
        scale_color_manual(values=c("red", "steelblue", "darkgreen"))
    )
  })
  
  # Generate a plot of monthly temp (recorded high and low)
  output$temp.plot2 <- renderPlotly({
    # Creating a basic plot
    ggplotly(
      ggplot() +
        geom_line(data=temp, mapping = aes(x=Month, y=Value, color=Type), group=1) +
        geom_point(data=temp, mapping = aes(x=Month, y=Value, color=Type)) +
        theme_classic() +
        labs(x = 'Months',
             y = 'Temperature in Fahrenheit',
             title = paste('Lowest and Highest Monthly Temperature In Fahrenheit (',highest.temp.recording, ')',sep = ' ')) +
        scale_color_manual(values=c("red", "skyblue"))
    )
  })
  
  # Generate a plot of monthly avg precipitation
  output$precipitation.plot <- renderPlotly({
    # Creating a basic plot
    ggplotly(
      ggplot() +
        geom_line(data=precipitation, mapping = aes(x=Month, y=Value, color = Type), group=1) +
        geom_point(data=precipitation, mapping = aes(x=Month, y=Value, color = Type)) +
        theme_classic() +
        labs(x = 'Months',
             y = 'Precipitation In Inches',
             title = paste('Average Monthly Precipitation In Inches (',precipitation.recording, ')',sep = ' '),
             color = 'Type')  +
        scale_color_manual(values=c("skyblue"))
    )
  })
  
  # Generate a plot of number of days with precipitation
  output$precipitation.days.plot <- renderPlotly({
    # Creating a basic plot
    ggplotly(
      ggplot() +
        geom_line(data=precipitation.days, mapping = aes(x=Month, y=Value, color = Type), group=1) +
        geom_point(data=precipitation.days, mapping = aes(x=Month, y=Value, color = Type)) +
        theme_classic() +
        labs(x = 'Months',
             y = 'Number Of Days',
             title = paste('Number Of Days With Precipitation In Days (',precipitation.days.recording, ')',sep = ' '),
             color = 'Type')  +
        scale_color_manual(values=c("steelblue"))
    )
  })
  
  # Generate a plot of average length of days per month
  output$average.length.day.plot <- renderPlotly({
    # Creating a basic plot
    ggplotly(
      ggplot() +
        geom_line(data=average.length.day, mapping = aes(x=Month, y=Value, color = Type), group=1) +
        geom_point(data=average.length.day, mapping = aes(x=Month, y=Value, color = Type)) +
        theme_classic() +
        labs(x = 'Months',
             y = 'Number Of Hours',
             title = paste('Average Length Of Day In Hours (',average.length.day.recording, ')',sep = ' '),
             color = 'Type')  +
        scale_color_manual(values=c("orange"))
    )
  })
  
  # Generate a plot for average number of days above 90F and below 32F
  output$days.temp.plot <- renderPlotly({
    # Creating a basic plot
    ggplotly(
      ggplot() +
        geom_line(data=days, mapping = aes(x=Month, y=Value, color = Type), group=1) +
        geom_point(data=days, mapping = aes(x=Month, y=Value, color = Type)) +
        theme_classic() +
        labs(x = 'Months',
             y = 'Days',
             title = paste('Average Number Of Days Above 90F/32C or Below 32F/0C In Days (',days.above.recording, ')',sep = ' '),
             color = 'Type')  +
        scale_color_manual(values=c("orange","steelblue"))
    )
  })
  
  # Generate a plot of average snowfall
  output$snow.plot <- renderPlotly({
    # Creating a basic plot
    ggplotly(
      ggplot() +
        geom_line(data=snowfall, mapping = aes(x=Month, y=Value, color = Type), group=1) +
        geom_point(data=snowfall, mapping = aes(x=Month, y=Value, color = Type)) +
        theme_classic() +
        labs(x = 'Months',
             y = 'Snowfall In Inches',
             title = paste('Average Snowfall In Inches (',snow.recording, ')',sep = ' '),
             color = 'Type')  +
        scale_color_manual(values=c("skyblue"))
    )
  })
  
  
  # Generate a plot for number of attempts and success percentage at yearly/monthly/day level of granularity
  output$routesPerGranularity <- renderPlotly({
    
    # Setting the secondary axis of success percentage
    double.y <- list(
      overlaying = 'y',
      side = 'right',
      title = 'Success Percentage (%)',
      range = c(0,100)
    )
    
    # If user selects year
    if(input$granularity == 'year'){
      year.plot <- plot_ly(attemptsPerYear, x = ~year, y = ~succeeded, type = 'bar', name="Succeeded Attempts", 
                      marker = list(color=c('steelblue')),
                      hovertemplate = paste('<i>Year</i>: %{x}',
                                            '<br><i>Value</i>: %{y}<br>'))
      year.plot <- year.plot %>% add_trace(y = ~failed, name="Failed Attempts", marker = list(color=c('brown')),
                                 hovertemplate = paste('<i>Year</i>: %{x}',
                                                       '<br><i>Value</i>: %{y}<br>'))
      year.plot <- year.plot %>% add_trace(data = successPerYear,y = ~successPercentage, type = 'scatter', mode='lines+markers',
                                 name = "Success Percentage (%)", marker = list(color='green'), line=list(color='green'),
                                 yaxis = "y2",
                                 hovertemplate = paste('<i>Year</i>: %{x}',
                                                       '<br><i>Success Percentage</i>: %{y}<br>'))
      year.plot <- year.plot %>% layout(title = 'Number of Attempts and Success Percentage per Year (2010-2015)',
        yaxis = list(title='Total Number Of Attempts'), barmode = 'stack', yaxis2 = double.y,
        legend = list(orientation = "v",   
                      xanchor = "center", 
                      y = 0.5, x = 1.2)
      )
      
      # Display the plot
      year.plot
    }
    
    # If user selects month
    else if(input$granularity == 'month'){
      month.plot <- plot_ly(attemptsPerMonth, x = ~month, y = ~succeeded, type = 'bar', name="Succeeded Attempts", 
                      marker = list(color=c('steelblue')),
                      hovertemplate = paste('<i>Month</i>: %{x}',
                                            '<br><i>Value</i>: %{y}<br>'))
      month.plot <- month.plot %>% add_trace(y = ~failed, name="Failed Attempts", marker = list(color=c('brown')),
                                 hovertemplate = paste('<i>Month</i>: %{x}',
                                                       '<br><i>Value</i>: %{y}<br>'))
      month.plot <- month.plot %>% add_trace(data = successPerMonth,y = ~successPercentage, type = 'scatter', mode='lines+markers',
                                 name = "Success Percentage (%)", marker = list(color='green'), line=list(color='green'),
                                 yaxis = "y2",
                                 hovertemplate = paste('<i>Month</i>: %{x}',
                                                       '<br><i>Success Percentage</i>: %{y}<br>'))
      month.plot <- month.plot %>% layout(title = 'Number of Attempts and Success Percentage per Month (2010-2015)',
        yaxis = list(title='Total Number Of Attempts'), barmode = 'stack', yaxis2 = double.y,
        legend = list(orientation = "v",   
                      xanchor = "center",  
                      y = 0.5, x = 1.2)
      )
      
      # Displaying the plot
      month.plot
    }
    
    # If user selects weekday
    else if(input$granularity == 'day'){
      day.plot <- plot_ly(attemptsPerDay, x = ~day, y = ~succeeded, type = 'bar', name="Succeeded Attempts", 
                      marker = list(color=c('steelblue')),
                      hovertemplate = paste('<i>Day</i>: %{x}',
                                            '<br><i>Value</i>: %{y}<br>'))
      day.plot <- day.plot %>% add_trace(y = ~failed, name="Failed Attempts", marker = list(color=c('brown')),
                                 hovertemplate = paste('<i>Day</i>: %{x}',
                                                       '<br><i>Value</i>: %{y}<br>'))
      day.plot <- day.plot %>% add_trace(data = successPerDay,y = ~successPercentage, type = 'scatter', mode='lines+markers',
                                 name = "Success Percentage (%)", marker = list(color='green'), line=list(color='green'),
                                 yaxis = "y2",
                                 hovertemplate = paste('<i>Day</i>: %{x}',
                                                       '<br><i>Success Percentage</i>: %{y}<br>'))
      day.plot <- day.plot %>% layout(title = 'Number of Attempts and Success Percentage per Weekday (2010-2015)',
        yaxis = list(title='Total Number Of Attempts'), barmode = 'stack', yaxis2 = double.y,
        legend = list(orientation = "v",   
                      xanchor = "center",  
                      y = 0.5, x = 1.2)
      )
      
      # Displaying the plot
      day.plot
    }
  })
  
  
  # Generate relevant text based on user's selection on routes granularity
  output$routesGranularity <- renderUI({
    if(input$granularity == 'year')
      HTML(paste("Crowd has been always excited to go hiking and camping at Mt. Rainier. The numbers are consistently around 10k on a yearly basis!", "",
                 "The brown segment indicates the number of failed attempts, blue segment indicates number of succeeded attempts and the green segment indicates the success percentage.", "",
                 "The maximum success percentage was seen in the year 2014 with 56.77% whereas the least success percentage was seen in the year 2010 with 46.5%.", "",
                 "The success percentage has been around 50% for past many years. It is considered to be one of the difficult treks. So, if you're planning to go, prepare well!", "",
                 "<b><--- Checkout other granularities and then goto next tab to see which route is more popular! ---></b>", sep ="<br/>"))
    else if(input$granularity == 'month')
      HTML(paste("As mentioned earlier, most people visit Mt. Rainier from May, late spring season to August, end of the summer season. Other times it is quite difficult to go for trekking/camping because of the harsh weather conditions.", "",
                 "The brown segment indicates the number of failed attempts, blue segment indicates number of succeeded attempts and the green segment indicates the success percentage.", "",
                 "The maximum number of attempts and success percentage was seen for month July with 57.87% whereas the least success percentage was seen fort the month May with 37.78%.", "",
                 "January and December are two of the coldest months at Mt. Rainier. So, if you're planning to go, May end to Aug end would be a good time!", "",
                 "<b><--- Checkout other granularities and then goto next tab to see which route is more popular! ---></b>", sep ="<br/>"))
    else if(input$granularity == 'day')
      HTML(paste("It is expected that people go out when they're free! Based on the past statistics, as it can be seen from above plot, people tend to go for trekking/camping during wekeend.", "",
                 "The brown segment indicates the number of failed attempts, blue segment indicates number of succeeded attempts and the green segment indicates the success percentage.", "",
                 "Success Percentage is pretty much the same (around 50%) no matter which day you pick! So, it's upto you to pick a day - either pick a day when there's less crowd so that you can enjoy the nature or pick a weekend and enjoy with people and nature.", "",
                 "<b><--- Checkout other granularities and then goto next tab to see which route is more popular! ---></b>", sep ="<br/>"))
  })
  
  # Plot for popular routes
  output$attemptsPerRoute <- renderPlotly({
    # Creating a basic plot
    plot_ly() %>%
      layout(title = 'Top 5 Popular Routes (2010-2015)',
                 yaxis = list(title='Route Names', dtick=1), xaxis = list(title='Total Number Of Attempts')) %>% 
      add_trace(x = attemptsPerRoute$attempted, y =attemptsPerRoute$route, name=" ",
                type = 'bar', orientation = 'h',
                hovertemplate = paste('<i>Route</i>: %{y}','<br><i>Attempts</i>: %{x}<br>'))
  })
  
  
  # Generate text commenting about attempts per route
  output$attempts.route.text <- renderUI({
    HTML(paste("There about 30 routes that can be taken. Among those, <i>Disappointment Cleaver</i> is the most common route taken. Followed by <i>Emmons-Winthrop</i> and <i>Ingraham Direct</i>", "",
               "<b><--- Goto next tab to see which routes are taken during which part of the year and success percentage for each route! ---></b>", sep ="<br/>"))
  })

  
  
  # Generate a plot of number of attempts per month for user selected route
  output$routesPerMonth <- renderPlotly({
    
    # Setting the secondary axis of success percentage
    double.y <- list(
      overlaying = 'y',
      side = 'right',
      title = 'Success Percentage (%)',
      range = c(0,100)
    )
    
    # Filtering the dataset based on user's selection
    plot.data <- routesPerMonth[routesPerMonth$route == input$route.name,]

    # Calculate success percentage per month for selected route
    plot.data$successPercentage <- plot.data$succeeded/plot.data$attempted * 100
    
    # Rounding off success percentage
    plot.data[,6] <- round(plot.data[,6],2)
  
    # Creating a dummy dataframe to display all the months in case some are missing from original dataset
    month.df <- data.frame('month'=factor(unique(routesPerMonth$month), levels = unique(routesPerMonth$month)))

    # Merging both into a data frame, setting 0 where months have NA values
    plot.data<- merge(month.df,plot.data,by="month", all.x=TRUE)
    plot.data$route <- input$route.name
    plot.data[is.na(plot.data)] <- 0
    
    # Reorder the data based on levels of month
    plot.data <- plot.data[order(plot.data$month),]

    route.plot <- plot_ly(plot.data, x = ~month, y = ~succeeded, type = 'bar', name="Succeeded Attempts", 
                    marker = list(color=c('steelblue')),
                    hovertemplate = paste('<i>Month</i>: %{x}',
                                          '<br><i>Value</i>: %{y}<br>'))
    route.plot <- route.plot %>% add_trace(y = ~failed, name="Failed Attempts", marker = list(color=c('brown')),
                               hovertemplate = paste('<i>Month</i>: %{x}',
                                                     '<br><i>Value</i>: %{y}<br>'))
    route.plot <- route.plot %>% add_trace(y = ~successPercentage, type = 'scatter', mode='lines+markers',
                               name = "Success Percentage (%)", marker = list(color='green'), line=list(color='green'),
                               yaxis = "y2",
                               hovertemplate = paste('<i>Month</i>: %{x}',
                                                     '<br><i>Success Percentage</i>: %{y}<br>'))
    route.plot <- route.plot %>% layout(title = paste('Number of Attempts and Success Percentage per Route', input$route.name, '(2010-2015)'),
      yaxis = list(title='Total Number Of Attempts'), barmode = 'stack', yaxis2 = double.y,
      legend = list(orientation = "v",   
                    xanchor = "center",  
                    y = 0.5, x = 1.2)
    )
    
    # Displaying the plot
    route.plot
  })
  
  # Generate text commenting about the trend in general
  output$route.text <- renderUI({
    HTML(paste("The three most common routes are : <i>Disappointment Cleaver</i>, <i>Emmons-Winthrop</i> and <i>Ingraham Direct</i> whereas the three least common routes are : <i>Curtis RIngraham Directge</i>, <i>	Edmonds HW</i> and <i>Liberty Wall</i>.", "",
               "The brown segment indicates the number of failed attempts, blue segment indicates number of succeeded attempts and the green segment indicates the success percentage.", "",
               "<b><--- Checkout other routes and then goto next tab to see how's the weather up there! ---></b>", sep ="<br/>"))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
