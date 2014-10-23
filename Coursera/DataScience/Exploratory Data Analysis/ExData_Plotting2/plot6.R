####################
# Basic Setup
####################

# Specify wd
setwd("/Users/onurakpolat/Github/ExData_Plotting2/")

# create data directory if it doesn't exist
if (!file.exists("data")){
  dir.create("data")
}

# create figure directory if it doesn't exist
if (!file.exists("figure")){
  dir.create("figure")
}

####################
# Downloading Data
####################

# specify file url
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# create a temporary directory
td = tempdir()
# create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")
# download into the placeholder file
download.file(url, tf, method="curl")

# create data path
dp = paste(file.path(getwd()),"/data",sep="")
# unzip the file to the data directory
unzip(tf, exdir=dp, overwrite=TRUE)

####################
# Read Data
####################

if (!"neiData" %in% ls()) {
  neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
  sccData <- readRDS("./data/Source_Classification_Code.rds")
}

subset <- neiData[neiData$fips == "06037", ] 

####################
# Make Plot
####################

library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./figure/plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
motor <- grep("motor", sccData$Short.Name, ignore.case = T)
motor <- sccData[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]

g <- ggplot(motor, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Comparison of Total Emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008") +
  scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
dev.off()