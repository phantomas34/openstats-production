# Use the official, pre-configured R Shiny App image from Posit.
# This image is multi-platform and contains all necessary system dependencies.
FROM ghcr.io/r-lib/r-shiny-app:latest

# This image includes a special script to install packages reliably.
# We just need to list the packages we need.
RUN install-r-packages \
    bslib \
    thematic \
    DT \
    ggplot2 \
    dplyr \
    tidyr \
    rhandsontable \
    car \
    psych \
    scales \
    readxl \
    shinyWidgets \
    bsicons

# Copy the entire application into the '/srv/shiny-app/' directory.
COPY . /srv/shiny-app/

# The base image will automatically run the app. No CMD needed.