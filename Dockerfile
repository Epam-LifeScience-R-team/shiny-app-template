FROM rocker/r-base:3.6

ENV REPOS "https://cran.rstudio.com" 

USER root
RUN yum install -y git
RUN chmod -R 777 /opt/R/3.6.2/lib/R/library

RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"

COPY renv/ /home/docker/renv
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