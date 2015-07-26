source('export.R')

plot4 <- function() {
  # Read data files
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
  
  # Finding coal combustion-related sources
  coalBased <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
  coalCombustionSources <- SCC[coalBased,]
  
  # Finding emissions from coal combustion-related sources
  emissions <- NEI[(NEI$SCC %in% coalCombustionSources$SCC), ]
  
  # Grouping by year
  aggregateEmissionsPerYear <- aggregate(Emissions ~ year, data=emissions, FUN=sum)
  
  # plot
  png("plot4.png")
  library(ggplot2)
  
  # using aes() in order to use visual aesthetics
  p <- ggplot(aggregateEmissionsPerYear, aes(x=factor(year), y=Emissions)) +
    geom_bar(stat="identity") +
    xlab("Years") +
    ylab(expression('PM'[2]*'')) +
    ggtitle("Emissions From Coal Combustion-Related Sources")
  
  exportGGPlot(p)
}