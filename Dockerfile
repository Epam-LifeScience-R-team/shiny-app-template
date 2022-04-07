FROM rocker/r-base:4.1.3

ENV REPOS "https://cran.rstudio.com"

USER root
RUN apt-get update && apt-get install -y git
RUN chmod -R 777 /usr/local/lib/R/site-library


USER docker
RUN R -e "install.packages('renv', repos=Sys.getenv('REPOS'))"
RUN which R

COPY .Rprofile .Rprofile
COPY renv.lock renv.lock
COPY modules modules
COPY utils utils
COPY www www
COPY dev dev
COPY tests tests
COPY config config
COPY global.R global.R
COPY server.R server.R
COPY ui.R ui.R
COPY DESCRIPTION DESCRIPTION

RUN R -e "renv::restore()"
RUN R -e "shiny::runTests()"