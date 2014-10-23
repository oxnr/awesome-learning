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

####################
# Make Plot
####################

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999???2008 for Baltimore City? Which have seen increases in emissions from 1999???2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./figure/plot3.png", 
    width = 480, height = 480, 
    units = "px")
g <- ggplot(subset, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
dev.off()
