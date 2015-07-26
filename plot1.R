source('export.R')

plot1 <- function() {
  # Read data files
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
  
  # Getting and aggregating the data
  aggregateEmissions <- aggregate(Emissions ~ year, NEI, sum)
  
  # Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
  barplot(height=aggregateEmissions$Emissions, names.arg=aggregateEmissions$year,
          xlab="Years", ylab=expression('PM'[2]*''),
          main=expression('Total PM'[2]*' Emissions From 1999-2008'))
  
  # using the graphics package to copy the plot to the current folder.
  exportPlot("plot1.png")
}