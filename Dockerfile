# The Final, Unbreakable Dockerfile

# Use the official, pre-configured R Shiny App image from Posit.
# This image contains all necessary system dependencies and compilers.
FROM ghcr.io/r-lib/r-shiny-app:latest

# This image includes a special script to install packages reliably.
# We just need to list the packages from your global.R file.
# NOTE: 'shiny' and 'stats' are already included in the base image.
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

# This image automatically handles the port and runs the app. No CMD is needed.