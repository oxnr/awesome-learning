# Basic
## Read in pollution data
pollution <- read.csv("data/avgpm25.csv", colClasses = c("numeric","character","factor","numeric","numeric"))
head(pollution)

##Five number summary
summary(pollution$pm25)

# Visualizations
## Boxplot
boxplot(pollution$pm25, col = "blue")

## Histogram
## Get shape of distribution

hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

## Barplot

barplot(table(pollution$region), col = "wheat", main = "Number of Countries in Each Region")

## Overlaying feature
boxplot(pollution$pm25, col = "blue")
abline(h = 12)

hist(pollution$pm25, col = "green", breaks = 100)
abline( v = 12, lwd = 2)
abline (v = median(pollution$pm25), col = "magenta", lwd = 4)

## Multiple Boxplot

boxplot(pm25 ~ region, data = pollution, col = "red")

## Multiple Histogram

par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

## Scatterplot

with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)

par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))

## Multiple Scatterplots
par(mfrow =c(1,2), mar = c(5,4,2,1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))

# Plotting Systems in R
## Base Plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))

## Lattice System

library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

## ggplot2

library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

# Base Plotting System

## Simple Base Graphics: Histogram
library(datasets)
hist(airquality$Ozone)

## Simple Base Graphics: Scatterplot

library(datasets)
with(airquality, plot(Wind, Ozone))

## Simple Base Grpahics: Boxplot

library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

## Some important Base Graphics Parameters
## pch, lty, lwd, col, xlab, ylab
## las, bg, mar, oma, mfrow, mfcol

# Base Plotting Functions
## plot, lines, points, text, title, mtext, axis

## Base Plot with Annotations
library(datasets)
with(airquality, plot(Wind, Zone))
title(main = "Ozone and Wind in New York City")

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

## Base Plot with Regression Line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

## Multiple Base Plots
par(mfrow = c(1, 2))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

## Multiple Base Plots
par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
        mtext("Ozone and Weather in New York City", outer = TRUE)
})

# Basic Plotting Demonstration

x <- rnorm(100)
hist(x)

y <- rnorm(100)
plot(x,y)

par(mar = c(4,4,2,2))
plot(x,y)
plot(y,x, pch = 20)

example(points)

x <- rnorm(100)
y <- rnorm(100)
plot(x,y)
title("Scatterplot")
text(-2,-2,"Label")
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit)
abline(fit, lwd = 3)
abline(fit, lwd = 3, col = "blue")

plot(x, y, xlab = "Weight", ylab = "Height", main = "Scatterplot", pch = 20)
legend("topright", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "red")
z <- rpois(100, 2)
par(mfrow = c(2, 1))
plot(x,y, pch = 19)
par(mar = c(2,2,1,1))