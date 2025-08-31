# The Final, Unified Dockerfile for a Clean Build

FROM r-base:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    gfortran \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c( \
    'shiny', 'bslib', 'thematic', 'DT', 'ggplot2', 'dplyr', 'tidyr', \
    'rhandsontable', 'car', 'psych', 'scales', 'readxl', \
    'shinyWidgets', 'bsicons' \
), repos='https://packagemanager.posit.co/cran/latest')"

RUN mkdir /app
COPY . /app
WORKDIR /app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('.', host='0.0.0.0', port=3838)"]