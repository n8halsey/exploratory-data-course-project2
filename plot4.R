# code assumes 'exdata_data_NEI_data.zip' file has been unzipped in working directory

# load data sets - may take several seconds to load
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# merge two data sets
if(!exists("NEISCC")){
    NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# combustion related NEI data
coal <- grepl("coal", NEISCC$Short.Name,ignore.case=TRUE)
coalNEISCC <- NEISCC[coal, ]
aggYear <- aggregate(Emissions~year,coalNEISCC,sum)

png("plot4.png",width=640,height=480)
gplot <- ggplot(aggYear,aes(factor(year),Emissions))
gplot <- gplot+geom_bar(stat="identity")+
    xlab("year")+
    ylab(expression('PM'[2.5]*"Emissions"))+
    ggtitle('Coal Emissions 1999 to 2008')
print(gplot)
dev.off()