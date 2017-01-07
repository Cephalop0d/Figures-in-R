# This command will clear your work environment of any previously-saved data or values:
rm(list=ls())

# Load the MASS package so that it is active:
library(MASS)

# Read in the sample dataset:
data("Animals")

# This dataset contains average body weight in kg ("body") and average brain weight in kg
# ("brain") for 28 species of animals. Therefore, there are 28 observations each of the
# two numeric variables.

# The default plot function will make a simple scatterplot. First you must specify the 
# vector that contains the x-values, and then you specify the vector containing the y-values.
# Recall: specify values within a dataset using the format: dataset$variable
plot(Animals$body, Animals$brain)

# From this initial plot, it looks like most of the species have varying brain weights for
# similar body weights. However, note the spread of values on both axes; each spans several
# orders of magnitude. This makes it difficult to see what is going on at the smaller 
# values. We can fix this problem by transforming the values, using log-transformation.
# Taking the logarithm of each value effectively reduces the differences between large 
# values and stretches the differences between small values so that we can visualize and 
# compare them better.
plot(log(Animals$body), log(Animals$brain))

# Now the trend in the data is much more visible: on average, as body weight increases, 
# brain weight also increases in a nonlinear fashion (remember that we are viewing 
# transformed values). This phenomenon is described by allometry.

# There are several ways to add features to a basic scatterplot. Enter the code ?plot for 
# descriptions. In the last step here we will change the axis labels and add a title:
plot(log(Animals$body), log(Animals$brain), main="Animal Weights", xlab="Log Body Weight (kg)", ylab="Log Brain Weight (kg)")
