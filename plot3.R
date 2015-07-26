source('export.R')

plot3 <- function() {
  # Read data files
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
  
  # Getting/subsetting and aggregating the data by year and type
  baltimoreEmissions <- subset(NEI, fips == 24510)
  aggregateBaltimoreEmissionsPerTypeAndYear <- aggregate(Emissions ~ year + type, 
                                                         data = baltimoreEmissions, 
                                                         FUN=sum)
  
  library(ggplot2)
  png('plot3.png', width = 800, height = 500, units = 'px')
  
  # Using a bar graph because we are comparing results between different groups and 
  # changes over time. The change over time was considerable, so bar graphs are better
  # than line graphs in this case.
  p <- ggplot(aggregateBaltimoreEmissionsPerTypeAndYear, aes(x=factor(year), y=Emissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(scales="free", space="free", . ~ type) +
    guides(fill=FALSE) + theme_bw() +
    xlab("Year") +
    ylab(expression('PM'[2]*'')) +
    ggtitle(expression("PM"[2.5]*paste(" Emissions per Type in Baltimore.", sep="")))
  
  exportGGPlot(p)
}