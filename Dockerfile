FROM rocker/r-base:4.1.3

ENV REPOS "https://cran.rstudio.com" 

USER root
RUN apt-get update && apt-get install -y git
RUN chmod -R 777 /usr/lib/R/library

RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"

COPY renv.lock /home/docker/renv.lock
COPY modules /home/docker/modules
COPY utils /home/docker/utils
COPY www /home/docker/www
COPY dev /home/docker/dev
COPY tests /home/docker/tests
COPY config /home/docker/config
COPY .Rprofile /home/docker/.Rprofile
COPY global.R /home/docker/global.R
COPY server.R /home/docker/server.R
COPY ui.R /home/docker/ui.R
COPY DESCRIPTION /home/docker/DESCRIPTION

RUN R --vanilla -e "renv::consent(provided = TRUE)"
RUN R --vanilla -e "renv::restore()"

USER docker:docker