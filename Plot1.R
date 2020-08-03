filename <- "exdata_data_NEI_data.zip"

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

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

mergedData <- transform(mergedData, year = factor(year))
USPlot1 <- mergedData %>% select (year, Emissions) %>% 
  group_by(year) %>%
  summarise(TotalEmissions = sum(Emissions)) 
head(USPlot1)

#Creating the plot name and ploting it
png(file = "Plot1.png")

with (USPlot1, barplot(TotalEmissions, 
                       main = "Total emissions in USA over the last decade", 
                       xlab = "Year", 
                       ylab = "Total Emissions",
                       names.arg = levels(USPlot1$year)))
#Closing the ploting device
dev.off()
