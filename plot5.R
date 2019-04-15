# code assumes 'exdata_data_NEI_data.zip' file has been unzipped in working directory

# load data sets - may take several seconds to load
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# merge two data sets
if(!exists("NEISCC")){
    NEISCC <- merge(NEI, SCC, by="SCC")
}

# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# 24510 = Baltimore
# ON-ROAD type NEI
onroadNEI <- NEI[NEI$fips=="24510"&NEI$type=="ON-ROAD", ]
aggYear <- aggregate(Emissions~year,onroadNEI,sum)

png("plot5.png",width=840,height=480)
gplot <- ggplot(aggYear,aes(factor(year),Emissions))
gplot <- gplot+geom_bar(stat="identity")+
    xlab("year")+
    ylab(expression('PM'[2.5]*" Emissions"))+
    ggtitle('Vehicle emissions in Baltimore (fips = "24510") from 1999 to 2008')
print(gplot)
dev.off()