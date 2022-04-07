FROM rocker/r-base:4.1.3

ENV REPOS "https://cran.rstudio.com"

USER root
RUN apt-get update && apt-get install -y git
RUN mkdir /.cache
RUN chmod -R 777 /.cache
RUN chmod -R 777 /usr/local/lib/R/site-library



USER docker
RUN R -e "install.packages('renv', repos=Sys.getenv('REPOS'))"