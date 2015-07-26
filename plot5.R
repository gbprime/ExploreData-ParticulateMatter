source('export.R')

plot5 <- function() {
  # Read data files
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
  
  # Getting data from Baltimore & from motor vehicles
  baltimoreEmissionsOnRoad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
  aggregateBaltimoreEmissionsPerYear <- aggregate(Emissions ~ year, 
                                                  data = baltimoreEmissionsOnRoad, 
                                                  FUN=sum)
  
  # plot
  library(ggplot2)
  png("plot5.png")
  p <- ggplot(aggregateBaltimoreEmissionsPerYear, aes(x=factor(year), y=Emissions)) +
    geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression('PM'[2]*'')) +
    ggtitle("Vehicle Emissions in Baltimore")
  
  exportGGPlot(p)
}