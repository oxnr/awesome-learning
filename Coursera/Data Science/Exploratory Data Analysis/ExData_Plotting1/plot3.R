# This file reads the data into a datasets and subsets it

# Check if file exists, specify wd and load otherwise
if (!file.exists(paste(file.path(getwd()),"/data/",sep=""))){
  setwd("/Users/onurakpolat/Github/ExData_Plotting1/")
  source("load_data.R", chdir = T)
}

# Plotting the graph
png(filename = "plot3.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
plot(df$Datetime, df$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(df$Datetime, df$Sub_metering_2, col = "red")
lines(df$Datetime, df$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
dev.off()