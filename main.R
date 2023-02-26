###############################################################################
# main.R
#
# Authors: Seth Cottengim 
#          Monica Launcheros
#          Caroline Jenkins
# 
# Libraries: psych
#            ggplot2
# 
# Other functions: getData.R
#
###############################################################################


#------------------------------------------------------------------------------
#                                Initialize                                   |
#------------------------------------------------------------------------------

library(psych)
library(ggplot2)

# Get user input to import data from their specific computer.
# Only runs if you don't already have the data loaded. 
if (!exists("dat")) {
  access <- readline(prompt="Enter first letter of first name: ");
  source("getData.R")
  dat <- getData(access)
  names(dat) <- c("citiesA", "citiesS", "countiesA", "countiesS", "zipcodesA", "zipcodesS")
} else
  print("Data is already loaded")

# project data is now available as 'dat$'









