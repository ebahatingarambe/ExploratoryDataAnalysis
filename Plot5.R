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

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#selecting baltimore only
baltimore <- mergedData %>% filter(fips == "24510") 

# Select motor vehicles only in baltimore
vehicleOnly <- baltimore[grep("^Mobile",baltimore$EI.Sector,ignore.case=TRUE), ]

#Calculating total emissions by motor vehicles in baltimore
TotalEmissions <- as.vector(tapply(vehicleOnly$Emissions,vehicleOnly$year, sum))

#Definning the ploting device and the plot
png (file = "Plot5.png")

barplot(TotalEmissions, names.arg = levels(vehicleOnly$year),
        main = "Total vehicle emissions in in Baltimore over 1999-2008",
        xlab = "Year",
        ylab = "Total vehicle Emissions")

dev.off()

