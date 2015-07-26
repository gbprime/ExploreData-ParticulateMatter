source('export.R')

plot6 <- function() {
  NEI <- readRDS("data/summarySCC_PM25.rds")
  NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
  SCC <- readRDS("data/Source_Classification_Code.rds")
  
  # Subsetting the data by city and give each dataset a city name
  baltimoreEmissions <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
  baltimoreEmissions$city <- "Baltimore"
  LAEmissions <- subset(NEI, fips == '06037' & type == 'ON-ROAD')
  LAEmissions$city <- "Los Angeles"
  
  # Binding the two subsets into one dataframe
  bothCities <- rbind(baltimoreEmissions, LAEmissions)
  
  library(ggplot2)
  png("plot6.png", width=800, height=500, units="px", bg="transparent")
  
  # answering the question by placing the bar graphs next to each other.  
  # side-by-side comparison looks better than top-bottom diagrams.
  p <- ggplot(bothCities, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="Year", y=expression('PM'[2.5])) + 
    labs(title=expression("PM"[2.5]*" Vehicle Source Emissions Comparison: Baltimore vs. LA (1999-2008)"))
  
  exportGGPlot(p)
}