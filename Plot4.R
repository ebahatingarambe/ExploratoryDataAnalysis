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

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#Subsetting data for emissions caused by coal
coalOnly <- mergedData[grep("coal",mergedData$Short.Name,ignore.case=TRUE), ]                

#Calculating total emissions from coal
TotalEmissions <- as.vector(tapply(coalOnly$Emissions,coalOnly$year, sum))


#Definning the ploting device and the plot
png (file = "Plot4.png")

barplot(TotalEmissions, names.arg = levels(coalOnly$year),
        main = "Total coal emissions in USA over 1999-2008",
        xlab = "Year",
        ylab = "Total Coal Emissions")

dev.off()
