# The Final, Definitive Dockerfile - Built for Reliability

# Use the official R base image. It is 100% public and compatible.
FROM r-base:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install a complete set of system libraries AND compilers.
RUN apt-get update && apt-get install -y \
    build-essential \
    gfortran \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install ALL R packages, one by one, from the reliable Posit binary repository.
# This makes any failure loud and clear, and leverages Docker's layer caching.
RUN R -e "install.packages('shiny', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('bslib', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('thematic', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('DT', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('ggplot2', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('dplyr', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('tidyr', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('rhandsontable', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('car', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('psych', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('scales', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('readxl', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('shinyWidgets', repos='https://packagemanager.posit.co/cran/latest')"
RUN R -e "install.packages('bsicons', repos='https://packagemanager.posit.co/cran/latest')"

# --- Copy your application code ---
COPY . /app
WORKDIR /app

# The Final COMMAND: This dynamically uses the port provided by the cloud platform.
CMD ["R", "-e", "options(shiny.port = as.numeric(Sys.getenv('PORT', 3838))); shiny::runApp('.', host='0.0.0.0')"]