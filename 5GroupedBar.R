# Tidy your work environment, if necessary:
rm(list=ls())

# Load the MASS package so that it is active:
library(MASS)

# Read in the sample dataset:
data("crabs")

# This dataset consists of morphological measurements of the crab Leptograpsus variegatus.
# There are 8 variables, but we will focus on three here:
# sp (color form): blue "B" or orange "O"
# sex: "M" or "F"
# CL: carapace length (mm)
# Enter the code: ?crabs for more information about the dataset.

# We will make a grouped bar plot of the mean carapace length for each sex, by color form.
# Color form will be along the x-axis, but within each color there will be side-by-side 
# bars for both sexes.

# We will use the aggregate command to calculate the mean carapace length for each sex, 
# separately for both color forms, and save this as a data frame:
data <- as.data.frame(aggregate(CL~sp+sex, crabs, FUN=mean))

# We will use the same format to calculate the standard deviations for our error bars.
# The [,3] at the end selects only the third column of the output, which is the one that
# contains the vector of calculated values.
data$sd <- aggregate(CL~sp+sex, crabs, FUN=sd)[,3]

# Let's rename the color forms from "B" and "O" to "Blue" and "Orange" (this is not an
# essential step):
data$color <- as.character(data$sp)
data <- within(data, color[color=="B"] <- "Blue")
data <- within(data, color[color=="O"] <- "Orange")

# In order to create the graph, the data must be in a matrix format rather than a data 
# frame. We can get the data in the correct order and format through the following:
means <- data.matrix(xtabs(CL ~ sex + color, data))
sd <- data.matrix(xtabs(sd ~ sex + color, data))
# We do this separately to save the means and the standard deviations.

# To make the bar plot:
bp <- barplot(height = means, # the heights of the bars are given by the values in the means matrix
              beside = TRUE, # stacks the bars side-by-side rather than vertically
              las = 1, # rotates the y-axis numbers to read horizontally
              ylim = c(0, max(means)+max(sd)), # makes the plot tall enough to fit the error bars; the maximum mean value plus the maximum standard deviation
              col=heat.colors(length(rownames(means))), # each sex will be represented by a different color
              ylab = "Carapace Length (mm)",
              xlab = "Color Form",
              main = "Carapace Length of 'Leptograpsus' Crabs",
              legend.text = TRUE,
              args.legend = list(title = "Sex", x = "top", cex=0.75))

# To place the error bars onto the figure bars:
arrows(bp, means - sd, bp, means + sd, lwd = 1.5, angle = 90, code = 3, length = 0.05)
