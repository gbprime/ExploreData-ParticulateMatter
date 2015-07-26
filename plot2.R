source('export.R')

plot2 <- function() {
  # Read data files
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
  
  # Getting/subsetting and aggregating the data
  baltimoreEmissions <- subset(NEI, fips == 24510)
  # group emissions by year
  aggregateBaltimoreEmissionsPerYear <- aggregate(Emissions ~ year, baltimoreEmissions, sum)
  
  # Using the base plotting system to determine whether total emissions from PM2.5 decreased 
  # in Baltimore between 1999 to 2008
  barplot(height = aggregateBaltimoreEmissionsPerYear$Emissions,
          names.arg = aggregateBaltimoreEmissionsPerYear$year,
          xlab = "Years", ylab = expression('PM'[2]*''),
          main=expression('Total PM'[2]*' Emissions in Baltimore'))
  
  # using the graphics package to copy the plot to the current folder.
  exportPlot('plot2.png')
}