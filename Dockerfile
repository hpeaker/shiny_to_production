# Base image - https://rocker-project.org/images/versioned/r-ver.html
# Extending image advice - https://rocker-project.org/use/extending.html
FROM rocker/r-ver:4
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxt6 libpq-dev \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    && rm -rf /var/lib/apt/lists/*
RUN install2.r --skipinstalled --error \
    shiny bslib dplyr readr ggplot2 ggExtra \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so
RUN echo "local(options(shiny.port = 3838, shiny.host = '0.0.0.0'))" >> /usr/local/lib/R/etc/Rprofile.site
RUN addgroup --system app \
    && adduser --system --ingroup app app
WORKDIR /home/app
COPY *.R .
RUN chown app:app -R /home/app
USER app
EXPOSE 3838
CMD ["R", "-e", "shiny::runApp('/home/app')"]
