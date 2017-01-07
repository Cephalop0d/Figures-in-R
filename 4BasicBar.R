# Tidy your work environment, if needed:
rm(list=ls())

# Load the MASS package so that it is active:
library(MASS)

# Read in the sample dataset:
data("painters")

# This dataset has 5 variables, but we will only use two here. The 18th century art critic,
# de Piles, scored 54 classical painters on four different categories. We will look at how 
# color scores ("Colour") varied among schools of artists ("School").

# When we make the barplot, we will need a vector that specifies the heights of the bars.
# For this figure, the height will be the mean color score for each school of artists.
# The aggregate command applies a mathematical function to a set of variables. 
# First specify the formula telling which values to apply the function to and which variable
# to group them by, then which dataset contains the values, and lastly which function to apply.
# In the line of code below, we are asking for mean color scores for each school:
means <- aggregate(Colour ~ School, painters, FUN=mean)[,2]
# The [,2] at the end selects only the second column of the output to be saved, which is 
# the one that contains the vector of calculated values.

# We can calculate and save standard deviations for our means in the same way:
sd <- aggregate(Colour ~ School, painters, FUN=sd)[,2]

# To make the barplot:
bp <- barplot(height = means, # the heights of the bars are given by the data in the means vector
              beside = TRUE, # stacks the bars horizontally
              las = 1, # rotates the y-axis numbers to read horizontally
              ylim = c(0, max(means)+max(sd)), # makes the plot tall enough to fit the error bars; the maximum mean value plus the maximum standard deviation
              names.arg = c("A","B","C","D","E","F","G","H"),
              col="darkgray",
              ylab = "Color Score",
              xlab = "Artistic School",
              main="de Piles Color Scores")

# Since we are graphing means, we will add error bars.
# The arrows() command will place the error bars onto the figure bars:
arrows(bp, means - sd, bp, means + sd, lwd = 1.5, angle = 90, code = 3, length = 0.05)

# One conclusion that we might suggest based on this figure is that the artists within
# the school "D" (which corresponds to Venetian) tended to earn relatively higher and less
# variable color scores than most of the other groups of artists.

# There is also another way to add x-axis labels to the barplot.
# First, save a vector with the names (in the correct order):
schools <- c("Renaissance", "Mannerist", "Seicento", "Venetian", "Lombard", "16th Century", "17th Century", "French")

# Make a barplot without x-variable names:
bp <- barplot(height = means,
              beside = TRUE,
              las = 1,
              ylim = c(0, max(means)+max(sd)),
              col="mediumpurple3",
              ylab = "Color Score",
              xlab = "Artistic School",
              main="de Piles Color Scores")

# Add the error bars:
arrows(bp, means - sd, bp, means + sd, lwd = 1.5, angle = 90, code = 3, length = 0.05)

# We can use the text() command to add the bar labels. "x" and "y" give the coordinates of 
# where the text should go, "labels" defines the text vector, "cex" adjusts the text size,
# and "srt" rotates the text with respect to the x-axis:
text(x=bp-.25, y=-3, labels=schools, cex=0.75, srt=35, xpd=TRUE)
