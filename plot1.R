
# assumed 'exdata_data_NEI_data.zip' file has been unzipped in working directory

# load data sets - may take several seconds to load
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
aggregatedYear <- aggregate(Emissions ~ year, NEI, sum)
png('plot1.png')
barplot(height=aggregatedYear$Emissions, names.arg=aggregatedYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()