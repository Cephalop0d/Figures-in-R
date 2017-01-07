# Tidy your work environment, if necessary:
rm(list=ls())

# Load the MASS package so that it is active:
library(MASS)

# Read in the sample dataset:
data("wtloss")

# This dataset contains weight measurements of a patient over time; the two variables are
# "Days" (the time since recording started) and "Weight" (the patient's weight in kg).

# To make the line graph:
plot(wtloss$Days, wtloss$Weight, type="o", main="Weight Loss Over Time", xlab="Days",ylab="Weight (kg)")
# The code type="o" specifies printing both the points and the connecting lines on the plot.

# We have several options for customizing our graph.
# First I will save a color scheme for the graph:
colfunc <- colorRampPalette(c("red4", "gold2"))

# "col" specifies the colors of the line and/or points
# "lwd" adjusts the thickness of the line
# "pch" changes the symbol used to mark points
# for certain symbols, "bg" specifies the fill color and "col" specifies the border color
# "cex" is a scaling factor that adjusts the size of the points

# To make a customized line graph:
plot(wtloss$Days, wtloss$Weight, type="o", main="Weight Loss Over Time", xlab="Days",ylab="Weight (kg)", bg=colfunc(52), col="black", lwd=2, pch=24, cex=1.25)
