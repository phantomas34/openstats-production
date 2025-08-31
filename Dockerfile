# The Final, Definitive Dockerfile

# Use the official R base image. It is 100% compatible.
FROM r-base:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# STAGE 1: Install the most complex R packages as pre-compiled system binaries.
# This is the most reliable method and solves the 'car' installation failure.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    # Pre-compiled R packages from the Debian repository
    r-cran-shiny \
    r-cran-bslib \
    r-cran-dt \
    r-cran-ggplot2 \
    r-cran-dplyr \
    r-cran-tidyr \
    r-cran-car \
    r-cran-psych \
    r-cran-scales \
    r-cran-readxl \
    r-cran-shinywidgets \
    && rm -rf /var/lib/apt/lists/*

# STAGE 2: Install the few remaining packages from the reliable Posit repository.
RUN R -e "install.packages(c('thematic', 'rhandsontable', 'bsicons'), repos='https://packagemanager.posit.co/cran/latest')"

# --- Copy your application code ---
RUN mkdir /app
COPY . /app
WORKDIR /app

# The EXPOSE command is informational for Docker. Render will use the dynamic port.
EXPOSE 3838

# The Final COMMAND: This is the second critical fix.
# It tells Shiny to listen on the port provided by the Render environment ($PORT),
# defaulting to 3838 if it's not set (for local running).
CMD ["R", "-e", "options(shiny.port = as.numeric(Sys.getenv('PORT', 3838))); shiny::runApp('.', host='0.0.0.0')"]