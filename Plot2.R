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

#Ploting baltimore emissions
png (file = "Plot2.png")

#Selecting baltimore and subset the data
baltimore <- mergedData %>% filter(fips == "24510") %>% select(fips, year, Emissions)

#Calculatinf total emissions
TotalEmissions <- as.vector(tapply(baltimore$Emissions, baltimore$year, sum))

#Creating the plot name and ploting it
png(file = "Plot2.png")

barplot(TotalEmissions, names.arg = levels(baltimore$year), 
                         main = "Total emissions in Baltimore over 1999-2008", 
                         xlab = "Year", 
                         ylab = "Total Emissions", 
                        )

#Closing the ploting device
dev.off()
