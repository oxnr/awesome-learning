# This file reads the data into a datasets and subsets it

# Check if file exists, specify wd and load otherwise
if (!file.exists(paste(file.path(getwd()),"/data/",sep=""))){
  setwd("/Users/onurakpolat/Github/ExData_Plotting1/")
  source("load_data.R", chdir = T)
}

# Plotting the graph
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
par(mfrow = c(2, 2))
## Top-left
plot(df$Datetime, df$Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
## Top-right
plot(df$Datetime, df$Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")
## Bottom-left
plot(df$Datetime, df$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(df$Datetime, df$Sub_metering_2, col = "red")
lines(df$Datetime, df$Sub_metering_3, col = "blue")
# Remove the border of legend here.
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Bottom-right
plot(df$Datetime, df$Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(df)[4])
dev.off()