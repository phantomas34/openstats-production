# The Final, Definitive, Unified Dockerfile for Cloud Building

# Use the official R base image. It is 100% public and compatible with Render's anonymous build.
FROM r-base:latest

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install a complete set of system libraries AND compilers (including gfortran).
# This provides the necessary foundation for a successful compilation on Render.
RUN apt-get update && apt-get install -y \
    build-essential \
    gfortran \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install ALL R packages from the reliable Posit binary repository.
# This ensures speed, compatibility, and a successful installation.
RUN R -e "install.packages(c( \
    'shiny', 'bslib', 'thematic', 'DT', 'ggplot2', 'dplyr', 'tidyr', \
    'rhandsontable', 'car', 'psych', 'scales', 'readxl', \
    'shinyWidgets', 'bsicons' \
), repos='https://packagemanager.posit.co/cran/latest')"

# --- Copy your application code ---
RUN mkdir /app
COPY . /app
WORKDIR /app

# The Final COMMAND: This dynamically uses the port provided by Render.
CMD ["R", "-e", "options(shiny.port = as.numeric(Sys.getenv('PORT', 3838))); shiny::runApp('.', host='0.0.0.0')"]