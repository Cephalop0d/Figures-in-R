# First, tidy your work environment (if necessary):
rm(list=ls())

# Load the MASS package so that it is active:
library(MASS)

# Read in the sample dataset:
data("forbes")

# This dataset contains observations of two variables, boiling point ("bp") measured in
# degrees Farenheit and barometric pressure ("pres") measured in inches of mercury.
# Scottish physicist and glaciologist James Forbes measured the atmospheric pressure
# and boiling temperature of water at 17 different locations in the Alps and published 
# these data in 1857.

# What is the relationship between atmospheric pressure and the boiling point of water?
plot(forbes$pres, forbes$bp, xlab="Pressure (inches Hg)", ylab="Boiling Point (F)", main="Forbes's Data")

# It appears that as atmospheric pressure (in inches mercury) increases, the boiling 
# temperature of water (measured in Farenheit) tends to increase in a linear fashion.

# We can use linear regression to fit a line to these observations and use the line to 
# predict the boiling temperature at a given air pressure, or vice versa.

# The lm function will fit a linear regression model to these data. First specify the 
# formula in the format y~x and then specify the dataset:
m1 <- lm(bp~pres, data=forbes)

# To print the results of the regression:
summary(m1)
# We find a statistically significant slope and intercept for the linear form y=mx+b.
# The estimated intercept (b) is located in: row = (Intercept), column = Estimate
# The estimated slope (m) is located in: row = pres, column = Estimate
# Putting this together, we get the equation: bp = 1.9*(pres) + 155.3

# We can add the line to our plot using the abline function with the name of the saved model:
abline(m1)

# We can also adjust features of the line, including its color and thickness:
abline(m1, col = "red", lwd=2)

# ...and can use the parameter estimates for the equation y=mx+b to solve for the estimated
# boiling point temperature at any measured barometric pressure.