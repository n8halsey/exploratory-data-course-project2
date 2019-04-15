# code assumes 'exdata_data_NEI_data.zip' file has been unzipped in working directory

# load data sets - may take several seconds to load
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# merge two data sets
if(!exists("NEISCC")){
    NEISCC <- merge(NEI, SCC, by="SCC")
}

# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?
onroadNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
aggYearFips <- aggregate(Emissions~year+fips,onroadNEI,sum)
aggYearFips$fips[aggYearFips$fips=="06037"]<-"Los Angeles, CA"
aggYearFips$fips[aggYearFips$fips=="24510"]<-"Baltimore, MD"

png("plot6.png",width=1040,height=480)
gplot <- ggplot(aggYearFips,aes(factor(year),Emissions))
gplot <- gplot+facet_grid(.~fips)
gplot <- gplot+geom_bar(stat="identity")+
    xlab("year") +
    ylab(expression('PM'[2.5]*" Emissions")) +
    ggtitle('Vehicle Emissions Baltimore vs Los Angeles 1999-2008')
print(gplot)
dev.off()
