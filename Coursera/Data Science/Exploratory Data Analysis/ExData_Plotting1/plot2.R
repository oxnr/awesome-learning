# This file reads the data into a datasets and subsets it

# Check if file exists, specify wd and load otherwise
if (!file.exists(paste(file.path(getwd()),"/data/",sep=""))){
  setwd("/Users/onurakpolat/Github/ExData_Plotting1/")
  source("load_data.R", chdir = T)
}

# Plotting the graph
png(filename = "plot2.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
plot(df$Datetime, df$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()