# The Final, Definitive Dockerfile

# Use the official R base image. It is 100% compatible.
FROM r-base:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# STAGE 1: Install the most complex R packages that are available as pre-compiled system binaries.
# This provides a rock-solid foundation.
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
    && rm -rf /var/lib/apt/lists/*

# STAGE 2: Install the remaining, more specialized packages from the reliable Posit repository.
# This list includes the packages that were not found in apt-get.
RUN R -e "install.packages(c('thematic', 'rhandsontable', 'shinyWidgets', 'bsicons'), repos='https://packagemanager.posit.co/cran/latest')"

# --- Copy your application code ---
RUN mkdir /app
COPY . /app
WORKDIR /app

# The Final COMMAND: This dynamically uses the port provided by Render.
CMD ["R", "-e", "options(shiny.port = as.numeric(Sys.getenv('PORT', 3838))); shiny::runApp('.', host='0.0.0.0')"]