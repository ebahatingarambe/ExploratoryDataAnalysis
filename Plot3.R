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

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#Loading ggplot2 libary
library(ggplot2)
library(plyr)

#Which have seen increases/decreases in emissions from 1999–2008 in Baltimore? 

#Subsetting data
subData3 <- mergedData %>% filter (fips == "24510") %>%
  ddply(.(year, type), summarise, TotalEmissions = sum(Emissions))

#Definning the ploting device and the plot
png (file = "Plot3.png")

ggplot(subData3, aes (x = year, y= TotalEmissions)) + 
  geom_bar(stat = "identity") + 
  facet_grid(.~type) +
  ggtitle ("Total emissions per type in Baltimore over 1999-2008") +
  xlab ("Year") + 
  ylab ("Total Emissions")

dev.off()
