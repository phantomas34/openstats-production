# The Final, Unified Dockerfile for a Clean Build

# Use the official R base image. It is 100% compatible.
FROM r-base:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install a complete set of system libraries AND compilers (including gfortran).
# This provides the necessary foundation for the pre-compiled R binaries.
RUN apt-get update && apt-get install -y \
    build-essential \
    gfortran \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install ALL R packages from a single, reliable source: The Posit Package Manager.
# This ensures all package versions are 100% compatible with each other.
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