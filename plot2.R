# assumed 'exdata_data_NEI_data.zip' file has been unzipped in working directory

# load data sets - may take several seconds to load
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

subNEI  <- NEI[NEI$fips=="24510", ]
aggYear <- aggregate(Emissions~year,subNEI,sum)
png('plot2.png')
barplot(height=aggYear$Emissions, names.arg=aggYear$year, xlab="year", ylab=expression('PM'[2.5]*' emissions'),main=expression('PM'[2.5]*' in Baltimore annual emmissions'))
dev.off()