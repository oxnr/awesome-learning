# The Lattice Plotting System

## Main Function

#xyplot
#bwplot
#histogram
#stripplot
#dotplot
#splom
#levelplot, counterplot

## Simple Lattice Plots
library(lattice)
library(datasets)
## Simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)

## Convert "Month" to a factor variable

airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))

p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)

## Lattice Panel Functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
xyplot(y ~ x | f, layout = c(2, 1))

## Custom Panel Functions

xyplot(y ~ x | f, panel = function(x, y, ...) {
        panel.xyplot(x, y, ...)
        panel.abline(h = median(y), lty = 2)
})

xyplot(y ~ x | f, panel = function(x, y, ...) {
        panel.xyplot(x, y, ...)
        panel.lmline(x, y, col = 2)
})

# ggplot2 Plotting System

library(ggplot2)
str(mpg)

qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)

## Adding a geom
qplot(displ, hwy, data = mpg, geom = c("point","smooth"))

## Histograms

qplot(hwy, data = mpg, fill = drv)

## Facets
## Split out data by variable

qplot(displ, hwy, data = mpg, facets = .~drv)

qplot(pm25, NocturnalSympt, data = maacs, facest = . ~ bmicat, geom = c("point", "smooth"), method = "lm")

## Axis limits

testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))

g <- ggplot(testdat, aes(x = x, y = y))
g +geom_line()

g + geom_line() + ylim(-3,3)
g + geom_line() + coord_cartesian(ylim = c(-3,3))

## Compley example

 