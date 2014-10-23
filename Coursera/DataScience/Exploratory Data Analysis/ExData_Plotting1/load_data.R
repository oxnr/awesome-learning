# This downloads the data and extract the file from the url
# Finally it subsets the data and reads it into a dataframe

# load "data.table" to use fread
library(data.table) 

# create dat directory if it doesn't exist
if (!file.exists("data")){
  dir.create("data")
}

## specify file url
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# create a temporary directory
td = tempdir()
# create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")
# download into the placeholder file
download.file(url, tf, method="curl")

# get the name of the first file in the zip archive
fname = unzip(tf, list=TRUE)$Name[1]

# create data path
dp = paste(file.path(getwd()),"/data",sep="")
# unzip the file to the data directory
unzip(tf, files=fname, exdir=dp, overwrite=TRUE)
# create subdata.txt path
fpath = paste(file.path(getwd()),"/data/",fname,sep="")

# open .txt file for reading
tmpfile <- file(fpath, "r")

# find the lines with dates 1/2/2007 through 2/2/2007
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(tmpfile), value=TRUE), sep="\n", file="data/subdata.txt")
close(tmpfile)

# read the selected data into memory
df <- fread("data/subdata.txt", sep=";", header=TRUE, na.strings="?")

# Convert date and time to new column datetime
df$Date <- as.Date(df$Date, "%d/%m/%Y")
datetime <- paste(as.character(df$Date), df$Time, sep=" ")
df$Datetime <- as.POSIXct(datetime)