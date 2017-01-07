# Tidy your work environment, if needed:
rm(list=ls())

# Load the MASS package so that it is active:
library(MASS)

# Read in the sample dataset:
data("waders")

# This dataset contains counts of 19 species of wading birds at 15 different sites in
# South Africa. We will reduce the dataset a bit for our purposes, and will compare the
# proportions of plover species counts between coastal and wetland habitats.

# To keep all rows (sites), but only the counts for the five plover species:
data <- waders[,c(2:6)]

# To rename the remaining columns with the corresponding species names, first save a 
# vector of names:
species <- c("White-fronted","Kitt Lutz","Three-banded","Grey","Ringed")

# ...and then use it to rename the columns:
colnames(data) <- species

# We will classify each site as either coast or wetland to compare the plover species
# counts in the two different habitat types.
# First add a column to the data frame based on the row names, which correspond to sites:
data$habitat <- rownames(data)

# The following code will rename the habitat entries appropriately as either coast or
# wetland:
data <- within(data, habitat[habitat=="A"|habitat=="C"|habitat=="E"|habitat=="G"|habitat=="I"|habitat=="K"|habitat=="M"|habitat=="N"] <- "coast")
data <- within(data, habitat[habitat!="coast"] <- "wetland")

# We will calculate, for each habitat type, the species proportions of the total number of
# counted plovers. Habitats will be displayed on the x-axis while the proportions for each
# plover species will be stacked vertically for each habitat type. Since the calculations
# are proportions of the totals, each bar will be bounded by 0 and 1.

# Each habitat type had counts from multiple sites. We need to know the total number of 
# plovers counted for each species, in each habitat type.
# The aggregate command applies a mathematical function to a vector based on one or more
# variables. Here, we are telling it that we want to calculate the sum of plovers for
# each species, separately for each habitat type:
totals <- as.data.frame(aggregate(.~habitat, data, FUN=sum))

# In order to create this plot, the data must be in a matrix format rather than a data 
# frame. We can get the data in the correct order and format through the following:
counts <- data.matrix(t(totals[,-1]))
# The [,-1] omits the habitat column, which we do not need to have counted.

# The command prop.table creates a table of proportions from the counts.
# Margin refers to whether the proportions will be calculated by row (1) or column (2).
prop <- prop.table(counts,margin=2)

# Our plot will include a key/legend, which we don't want to overlap the bars. We will
# adjust the plot margins to make room to the right side of the graph, where we will 
# place the key:
par(mar=c(5.1, 4.1, 4.1, 7.1), xpd=TRUE)

# There is an option to specify which colors to use in the bar plot (1 for each species):
colors <- c("darkred",
            "gold2",
            "darkolivegreen",
            "navy",
            "tan4")

# To make the bar plot:
bp <- barplot(prop, # the bar heights will be based on the data in our proportions table
              las=1, # rotates the y-axis numbers to read horizontally
              col=colors, # assigns colors to the bars from the saved vector
              width=2, # bar width
              main="South African Plover Counts",
              xlab="Habitat", 
              ylab="Proportion of Plovers",
              names.arg = c("Coast","Wetland"),
              legend.text = TRUE, # this will give us a key telling what each of the stacks on the bar represents
              args.legend = list(title = "Species", x = "right", inset=c(-.4,0), cex=0.75)) # Here we title the key, tell where we want it to be located (outside of the plot) and can change the text size.
