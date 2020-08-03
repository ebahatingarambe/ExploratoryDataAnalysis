# unzip the file
NEI_data <- unzip(filename)

#Load libraries
library(RDS)
library(dplyr)

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Checking if the files in the listing
dir()

#Merging files
mergedData <- merge(NEI, SCC)

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (
# fips == "06037"\color{red}{\verb|fips == "06037"|}
# fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions

# Subseting data for Baltimore and Los Angeles
selectedCities <- mergedData %>% filter(fips == "06037"| fips == "24510")

# Select motor vehicles only
vehicleOnly <- selectedCities[grep("^Mobile",selectedCities$EI.Sector,ignore.case=TRUE), ]

#Calculating total emissions
TotalEmissions <- ddply(selectedCities, .(year, fips), summarise, TotalEmissions = sum(Emissions))

#Definning the ploting device and the plot
png (file = "Plot6.png")

ggplot(TotalEmissions, aes(x = year, y = TotalEmissions, fill = fips)) + 
  geom_bar(stat = "identity") + 
  facet_wrap(~fips) +
  theme(legend.position = "right") + 
  scale_fill_discrete(name ="City", labels=c("Los Angeles", "Baltimore")) + 
  xlab("Year") + ylab("Tota Emissions")  + 
  ggtitle("Total Vehicle Emissions in Los Angeles and Baltimore over 1999-2008")

# Ending plot
dev.off()
