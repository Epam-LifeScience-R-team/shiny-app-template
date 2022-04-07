FROM rocker/r-base:4.1.3

ENV REPOS "https://cran.rstudio.com" 

USER root
RUN apt-get update && apt-get install -y git

USER docker:docker
RUN whoami
RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"

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

USER docker:docker