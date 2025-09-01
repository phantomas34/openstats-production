# install.R
# This script is run once during the build process on DigitalOcean

install.packages(c(
  "shiny",
  "bslib",
  "thematic",
  "DT",
  "ggplot2",
  "dplyr",
  "tidyr",
  "rhandsontable",
  "car",          # The package that was causing the error
  "psych",
  "scales",
  "readxl",
  "shinyWidgets",
  "bsicons"
))

# Note: 'stats' is a base R package and does not need to be installed.