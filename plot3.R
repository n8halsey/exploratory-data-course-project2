# code assumes 'exdata_data_NEI_data.zip' file has been unzipped in working directory

# load data sets - may take several seconds to load
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Question 3: Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

install.packages("ggplot2")
library(ggplot2)

baltNEI  <- NEI[NEI$fips=="24510", ]
aggYear <- aggregate(Emissions~year,subNEI,sum)
png("plot3.png")
ggplot(baltNEI,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(.~type,scales = "free",space="free") +
    labs(x="year", y=expression("PM"[2.5]*" Emissions")) +
    labs(title=expression("PM"[2.5]*"Baltimore Emissions 1999-2008 by Source Type"))
dev.off()